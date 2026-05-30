import 'package:drift/drift.dart';

import '../../core/enums.dart';
import '../db/database.dart';
import 'pocketbase_client.dart';
import 'sync_service.dart';

/// F2 SYNC — Implementazione cloud con PocketBase.
///
/// Ruolo MEDICO (macOS):
///   push() → invia terapie + orari al server
///   pull() → scarica misurazioni e assunzioni dei pazienti
///
/// Ruolo PAZIENTE (iOS/Android):
///   push() → invia misurazioni e assunzioni al server
///   pull() → scarica terapie e orari prescritti dal medico
///
/// Il ruolo è determinato da [ruolo]: di default viene dedotto
/// dal contesto (se ci sono terapie locali = medico, altrimenti paziente).
class CloudSync implements SyncService {
  CloudSync(this._db, this._serverUrl, {this.pazienteId = 1});

  final AppDatabase _db;
  final String _serverUrl;
  final int pazienteId;

  late final PocketBaseClient _pb = PocketBaseClient(_serverUrl);

  @override
  bool get isCloudEnabled => true;

  // ── PUSH ─────────────────────────────────────────────────────────────────

  @override
  Future<void> push() async {
    await _pushMisurazioni();
    await _pushAssunzioni();
    await _pushTerapie();
  }

  Future<void> _pushMisurazioni() async {
    final rows = await (_db.select(_db.misurazioni)
          ..where((m) =>
              m.sincronizzato.equals(false) &
              m.pazienteId.equals(pazienteId)))
        .get();
    if (rows.isEmpty) return;

    final catalogo = await _db.select(_db.catalogoParametri).get();
    final catMap = {for (final c in catalogo) c.id: c.codice};

    for (final m in rows) {
      final codice = catMap[m.parametroId];
      if (codice == null) continue;
      final localId = 'mis_${pazienteId}_${m.id}';

      await _pb.upsert('misurazioni', 'local_id', localId, {
        'local_id': localId,
        'paziente_id': pazienteId.toString(),
        'parametro_codice': codice,
        'valore1': m.valore1,
        'valore2': m.valore2,
        'valore_testo': m.valoreTesto,
        'data_iso': m.data.toUtc().toIso8601String(),
        'fonte': m.fonteEffettiva.index,
      });

      await (_db.update(_db.misurazioni)..where((r) => r.id.equals(m.id)))
          .write(const MisurazioniCompanion(sincronizzato: Value(true)));
    }
  }

  Future<void> _pushAssunzioni() async {
    final rows = await (_db.select(_db.assunzioni)
          ..where((a) => a.sincronizzato.equals(false)))
        .get();
    if (rows.isEmpty) return;

    for (final a in rows) {
      final localId = 'ass_${pazienteId}_${a.id}';
      await _pb.upsert('assunzioni', 'local_id', localId, {
        'local_id': localId,
        'paziente_id': pazienteId.toString(),
        'terapia_local_id': 'ter_${pazienteId}_${a.terapiaId}',
        'orario': a.orarioId?.toString(),
        'stato': a.stato.index,
        'data_ora_prevista': a.dataOraPrevista.toUtc().toIso8601String(),
        'data_ora_registrazione':
            a.dataOraRegistrazione?.toUtc().toIso8601String(),
        'note': a.note,
      });

      await (_db.update(_db.assunzioni)..where((r) => r.id.equals(a.id)))
          .write(const AssunzioniCompanion(sincronizzato: Value(true)));
    }
  }

  Future<void> _pushTerapie() async {
    final terapie = await (_db.select(_db.terapie)
          ..where((t) =>
              t.pazienteId.equals(pazienteId) & t.attiva.equals(true)))
        .get();

    for (final t in terapie) {
      final localId = 'ter_${pazienteId}_${t.id}';
      await _pb.upsert('terapie', 'local_id', localId, {
        'local_id': localId,
        'paziente_id': pazienteId.toString(),
        'nome_farmaco': t.nomeFarmaco,
        'dosaggio': t.dosaggio,
        'priorita': t.priorita.index,
        'data_inizio': t.dataInizio.toUtc().toIso8601String(),
        'attiva': t.attiva,
      });

      final orari = await (_db.select(_db.orariTerapia)
            ..where((o) => o.terapiaId.equals(t.id)))
          .get();

      for (final o in orari) {
        final orarioLocalId = 'ora_${pazienteId}_${t.id}_${o.ora}';
        await _pb.upsert('orari_terapia', 'local_id', orarioLocalId, {
          'local_id': orarioLocalId,
          'terapia_local_id': localId,
          'paziente_id': pazienteId.toString(),
          'ora': o.ora,
        });
      }
    }
  }

  // ── PULL ─────────────────────────────────────────────────────────────────

  @override
  Future<void> pull() async {
    await _pullTerapie();
    await _pullMisurazioni();
    await _pullAssunzioni();
  }

  /// Scarica le terapie dal server e le aggiorna nel DB locale.
  /// Usato dal PAZIENTE per ricevere le prescrizioni del medico.
  Future<void> _pullTerapie() async {
    final remoteTerapie = await _pb.list(
      'terapie',
      filter: 'paziente_id="${pazienteId}"',
    );

    final catalogo = await _db.select(_db.catalogoParametri).get();

    for (final rt in remoteTerapie) {
      final localId = rt['local_id'] as String?;
      if (localId == null) continue;

      final nomeFarmaco = rt['nome_farmaco'] as String? ?? '';
      final prioritaIdx = (rt['priorita'] as num?)?.toInt() ?? 2;
      final priorita = PrioritaTerapia.values[
          prioritaIdx.clamp(0, PrioritaTerapia.values.length - 1)];
      final dataInizio = DateTime.tryParse(rt['data_inizio'] as String? ?? '') ??
          DateTime.now();
      final attiva = rt['attiva'] as bool? ?? true;

      // Cerca terapia locale con questo local_id nel nome (workaround senza campo remoteId)
      // Strategia: match per nomeFarmaco + dataInizio + pazienteId
      final esistenti = await (_db.select(_db.terapie)
            ..where((t) =>
                t.pazienteId.equals(pazienteId) &
                t.nomeFarmaco.equals(nomeFarmaco)))
          .get();

      int terapiaId;
      if (esistenti.isEmpty) {
        terapiaId = await _db.into(_db.terapie).insert(
              TerapieCompanion.insert(
                pazienteId: pazienteId,
                nomeFarmaco: nomeFarmaco,
                dosaggio: Value(rt['dosaggio'] as String?),
                priorita: priorita,
                attiva: Value(attiva),
                dataInizio: dataInizio,
              ),
            );

        // Abilita i parametri del catalogo per questo paziente
        if (catalogo.isNotEmpty) {
          for (final p in catalogo) {
            await _db.into(_db.parametriAbilitati).insertOnConflictUpdate(
                  ParametriAbilitatiCompanion.insert(
                    pazienteId: pazienteId,
                    parametroId: p.id,
                  ),
                );
          }
        }
      } else {
        terapiaId = esistenti.first.id;
        await (_db.update(_db.terapie)
              ..where((t) => t.id.equals(terapiaId)))
            .write(TerapieCompanion(attiva: Value(attiva)));
      }

      // Scarica orari
      final remoteOrari = await _pb.list(
        'orari_terapia',
        filter: 'terapia_local_id="$localId"',
      );

      for (final ro in remoteOrari) {
        final ora = ro['ora'] as String? ?? '';
        final orariEsistenti = await (_db.select(_db.orariTerapia)
              ..where((o) =>
                  o.terapiaId.equals(terapiaId) & o.ora.equals(ora)))
            .get();
        if (orariEsistenti.isEmpty) {
          await _db.into(_db.orariTerapia).insert(
                OrariTerapiaCompanion.insert(terapiaId: terapiaId, ora: ora),
              );
        }
      }
    }
  }

  /// Scarica le misurazioni dal server.
  /// Usato dal MEDICO per vedere i dati registrati dal paziente.
  Future<void> _pullMisurazioni() async {
    final remoteMis = await _pb.list(
      'misurazioni',
      filter: 'paziente_id="${pazienteId}"',
      sort: '-data_iso',
    );
    if (remoteMis.isEmpty) return;

    final catalogo = await _db.select(_db.catalogoParametri).get();
    final catMap = {for (final c in catalogo) c.codice: c};

    for (final rm in remoteMis) {
      final codice = rm['parametro_codice'] as String? ?? '';
      final param = catMap[codice];
      if (param == null) continue;

      final dataStr = rm['data_iso'] as String?;
      if (dataStr == null) continue;
      final data = DateTime.tryParse(dataStr);
      if (data == null) continue;

      final esistenti = await (_db.select(_db.misurazioni)
            ..where((m) =>
                m.pazienteId.equals(pazienteId) &
                m.parametroId.equals(param.id) &
                m.data.equals(data)))
          .get();
      if (esistenti.isNotEmpty) continue;

      final fonteIdx = (rm['fonte'] as num?)?.toInt() ?? 0;
      await _db.into(_db.misurazioni).insert(
            MisurazioniCompanion.insert(
              pazienteId: pazienteId,
              parametroId: param.id,
              data: data,
              fonteEffettiva: FonteParametro.values[
                  fonteIdx.clamp(0, FonteParametro.values.length - 1)],
              valore1: Value((rm['valore1'] as num?)?.toDouble()),
              valore2: Value((rm['valore2'] as num?)?.toDouble()),
              valoreTesto: Value(rm['valore_testo'] as String?),
              sincronizzato: const Value(true),
            ),
          );
    }
  }

  Future<void> _pullAssunzioni() async {
    // Placeholder: implementare se il medico vuole vedere l'aderenza in tempo reale
  }
}
