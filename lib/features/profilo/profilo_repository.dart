import 'package:drift/drift.dart';

import '../../data/db/database.dart';

class ProfiloData {
  const ProfiloData({
    required this.paziente,
    required this.patologie,
    required this.terapieAttive,
    required this.anamnesiCount,
  });
  final Paziente paziente;
  final List<Patologia> patologie;
  final List<Terapia> terapieAttive;
  final int anamnesiCount;
}

class ProfiloRepository {
  ProfiloRepository(this._db);
  final AppDatabase _db;

  Future<ProfiloData?> carica(int pazienteId) async {
    final paziente = await (_db.select(_db.pazienti)
          ..where((p) => p.id.equals(pazienteId)))
        .getSingleOrNull();
    if (paziente == null) return null;

    final patologie = await (_db.select(_db.patologie)
          ..where((p) => p.pazienteId.equals(pazienteId)))
        .get();

    final terapie = await (_db.select(_db.terapie)
          ..where((t) => t.pazienteId.equals(pazienteId) & t.attiva.equals(true))
          ..orderBy([(t) => OrderingTerm(expression: t.nomeFarmaco)]))
        .get();

    final anamnesi = await (_db.select(_db.risposteAnamnesi)
          ..where((r) => r.pazienteId.equals(pazienteId)))
        .get();

    return ProfiloData(
      paziente: paziente,
      patologie: patologie,
      terapieAttive: terapie,
      anamnesiCount: anamnesi.length,
    );
  }
}
