import 'package:drift/drift.dart';

import '../../core/enums.dart';
import '../../data/db/database.dart';
import '../../data/sync/sync_service.dart';

enum StatoMisurazione { ok, attenzione, allarme, nonDisponibile }

class ParametroConValore {
  ParametroConValore({required this.parametro, this.ultimaMisurazione});

  final ParametroCatalogo parametro;
  final Misurazione? ultimaMisurazione;

  StatoMisurazione get stato {
    final m = ultimaMisurazione;
    if (m == null) return StatoMisurazione.nonDisponibile;
    final v = m.valore1;
    if (v == null) return StatoMisurazione.nonDisponibile;
    final p = parametro;
    if (p.sogliaAllarmeMax != null && v > p.sogliaAllarmeMax!) {
      return StatoMisurazione.allarme;
    }
    if (p.sogliaAttenzioneMax != null && v > p.sogliaAttenzioneMax!) {
      return StatoMisurazione.attenzione;
    }
    return StatoMisurazione.ok;
  }

  String get valoreFormattato {
    final m = ultimaMisurazione;
    if (m == null) return '—';
    if (parametro.tipoValore == TipoValore.testo) return m.valoreTesto ?? '—';
    if (parametro.tipoValore == TipoValore.coppia) {
      final v1 = m.valore1?.toStringAsFixed(0) ?? '?';
      final v2 = m.valore2?.toStringAsFixed(0) ?? '?';
      return '$v1 / $v2';
    }
    final v = m.valore1;
    if (v == null) return '—';
    return v % 1 == 0 ? v.toStringAsFixed(0) : v.toStringAsFixed(1);
  }
}

class MonitoraRepository {
  MonitoraRepository(this._db, this._sync);

  final AppDatabase _db;
  final SyncService _sync;

  Future<List<ParametroConValore>> parametriAbilitati(int pazienteId) async {
    final abilitati = await (_db.select(_db.parametriAbilitati)
          ..where((p) => p.pazienteId.equals(pazienteId)))
        .get();
    if (abilitati.isEmpty) return [];

    final ids = abilitati.map((a) => a.parametroId).toList();
    final catalogo = await (_db.select(_db.catalogoParametri)
          ..where((p) => p.id.isIn(ids) & p.attivo.equals(true))
          ..orderBy(
              [(p) => OrderingTerm(expression: p.ordineVisualizzazione)]))
        .get();

    final risultato = <ParametroConValore>[];
    for (final p in catalogo) {
      final ultime = await (_db.select(_db.misurazioni)
            ..where((m) =>
                m.pazienteId.equals(pazienteId) & m.parametroId.equals(p.id))
            ..orderBy([
              (m) => OrderingTerm(expression: m.data, mode: OrderingMode.desc)
            ])
            ..limit(1))
          .get();
      risultato.add(ParametroConValore(
        parametro: p,
        ultimaMisurazione: ultime.isEmpty ? null : ultime.first,
      ));
    }
    return risultato;
  }

  Future<void> aggiungiMisurazione({
    required int pazienteId,
    required int parametroId,
    double? valore1,
    double? valore2,
    String? valoreTesto,
  }) async {
    await _db.into(_db.misurazioni).insert(
          MisurazioniCompanion.insert(
            pazienteId: pazienteId,
            parametroId: parametroId,
            data: DateTime.now(),
            fonteEffettiva: FonteParametro.manuale,
            valore1: Value(valore1),
            valore2: Value(valore2),
            valoreTesto: Value(valoreTesto),
            sincronizzato: const Value(false),
          ),
        );
    await _sync.push();
  }
}
