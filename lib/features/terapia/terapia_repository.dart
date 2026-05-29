import 'package:drift/drift.dart';

import '../../core/enums.dart';
import '../../data/db/database.dart';
import '../../data/sync/sync_service.dart';
import '../alert/notification_service.dart';

/// Una dose attesa "oggi": terapia + orario + eventuale assunzione registrata.
class DoseOggi {
  DoseOggi({
    required this.terapia,
    required this.orario,
    required this.prevista,
    this.assunzione,
  });

  final Terapia terapia;
  final OrarioTerapia orario;
  final DateTime prevista;
  final Assunzione? assunzione;

  StatoAssunzione get stato =>
      assunzione?.stato ?? StatoAssunzione.programmata;

  /// La dose era attesa ed e' rimasta in sospeso (display rosso/triste).
  bool get inRitardo =>
      prevista.isBefore(DateTime.now()) &&
      (stato == StatoAssunzione.programmata ||
          stato == StatoAssunzione.nonAssunta ||
          stato == StatoAssunzione.rifiutata);
}

/// Stato aggregato di un farmaco nella giornata, per l'emoticon.
enum StatoFarmaco { ok, attenzione, allarme }

class FarmacoOggi {
  FarmacoOggi({required this.terapia, required this.dosi});
  final Terapia terapia;
  final List<DoseOggi> dosi;

  StatoFarmaco get stato {
    final critiche = dosi.where((d) => d.inRitardo).toList();
    if (critiche.isEmpty) return StatoFarmaco.ok;
    // Un salvavita in ritardo e' allarme; altrimenti attenzione.
    final salvavita = terapia.priorita == PrioritaTerapia.salvavita ||
        terapia.priorita == PrioritaTerapia.alta;
    return salvavita ? StatoFarmaco.allarme : StatoFarmaco.attenzione;
  }
}

class TerapiaRepository {
  TerapiaRepository(this._db, this._notif, this._sync);

  final AppDatabase _db;
  final NotificationService _notif;
  final SyncService _sync;

  /// Pannello P1: tutte le dosi di oggi del paziente, raggruppate per farmaco.
  Future<List<FarmacoOggi>> farmaciOggi(int pazienteId) async {
    final now = DateTime.now();
    final inizioGiorno = DateTime(now.year, now.month, now.day);
    final fineGiorno = inizioGiorno.add(const Duration(days: 1));

    final terapie = await (_db.select(_db.terapie)
          ..where((t) => t.pazienteId.equals(pazienteId) & t.attiva.equals(true))
          ..orderBy([(t) => OrderingTerm(expression: t.nomeFarmaco)]))
        .get();

    // Assunzioni di oggi indicizzate per (terapiaId, orarioId).
    final assunzioniOggi = await (_db.select(_db.assunzioni)
          ..where((a) =>
              a.dataOraPrevista.isBiggerOrEqualValue(inizioGiorno) &
              a.dataOraPrevista.isSmallerThanValue(fineGiorno)))
        .get();
    final mappaAssunzioni = <String, Assunzione>{};
    for (final a in assunzioniOggi) {
      mappaAssunzioni['${a.terapiaId}_${a.orarioId}'] = a;
    }

    final risultato = <FarmacoOggi>[];
    for (final t in terapie) {
      final orari = await (_db.select(_db.orariTerapia)
            ..where((o) => o.terapiaId.equals(t.id))
            ..orderBy([(o) => OrderingTerm(expression: o.ora)]))
          .get();

      final dosi = <DoseOggi>[];
      for (final o in orari) {
        final parti = o.ora.split(':');
        final ora = int.tryParse(parti.first) ?? 0;
        final minuto = parti.length > 1 ? int.tryParse(parti[1]) ?? 0 : 0;
        final prevista =
            inizioGiorno.add(Duration(hours: ora, minutes: minuto));
        dosi.add(DoseOggi(
          terapia: t,
          orario: o,
          prevista: prevista,
          assunzione: mappaAssunzioni['${t.id}_${o.id}'],
        ));
      }
      dosi.sort((a, b) => a.prevista.compareTo(b.prevista));
      risultato.add(FarmacoOggi(terapia: t, dosi: dosi));
    }
    return risultato;
  }

  /// Registra l'esito di una dose (Assunto / Posticipato / Rifiutato) e
  /// cancella i promemoria pendenti per quella dose.
  Future<void> registraAssunzione(
    DoseOggi dose,
    StatoAssunzione stato, {
    String? note,
  }) async {
    final now = DateTime.now();
    final esistente = dose.assunzione;

    if (esistente == null) {
      await _db.into(_db.assunzioni).insert(
            AssunzioniCompanion.insert(
              terapiaId: dose.terapia.id,
              orarioId: Value(dose.orario.id),
              dataOraPrevista: dose.prevista,
              stato: stato,
              dataOraRegistrazione: Value(now),
              note: Value(note),
              sincronizzato: const Value(false),
            ),
          );
    } else {
      await (_db.update(_db.assunzioni)
            ..where((a) => a.id.equals(esistente.id)))
          .write(AssunzioniCompanion(
        stato: Value(stato),
        dataOraRegistrazione: Value(now),
        note: Value(note),
        sincronizzato: const Value(false),
      ));
    }

    // Interazione avvenuta -> stop al rilancio dell'allarme.
    await _notif.cancellaDose(dose.orario.id);

    if (stato == StatoAssunzione.posticipata) {
      await _notif.posticipa15min(
        orarioId: dose.orario.id,
        nomeFarmaco: dose.terapia.nomeFarmaco,
        priorita: dose.terapia.priorita,
      );
    }

    // Local-first: in Fase 1 e' un no-op; in Fase 3 invia al cloud.
    await _sync.push();
  }

  /// Pianifica le notifiche giornaliere per tutte le terapie attive.
  Future<void> pianificaPromemoria(int pazienteId) async {
    final farmaci = await farmaciOggi(pazienteId);
    for (final f in farmaci) {
      for (final d in f.dosi) {
        final parti = d.orario.ora.split(':');
        await _notif.pianificaDoseGiornaliera(
          orarioId: d.orario.id,
          nomeFarmaco: f.terapia.nomeFarmaco,
          dosaggio: f.terapia.dosaggio,
          ora: int.tryParse(parti.first) ?? 0,
          minuto: parti.length > 1 ? int.tryParse(parti[1]) ?? 0 : 0,
          priorita: f.terapia.priorita,
        );
      }
    }
  }
}
