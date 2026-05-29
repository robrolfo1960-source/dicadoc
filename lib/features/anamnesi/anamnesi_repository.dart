import '../../data/db/database.dart';

/// Domande del questionario anamnestico.
const List<String> domandheAnamnesi = [
  'Sei fumatore o ex fumatore?',
  'Hai allergie note a farmaci?',
  'Hai subito interventi chirurgici negli ultimi 2 anni?',
  'Hai familiari con malattie cardiovascolari?',
  'Hai familiari con diabete mellito?',
  'Pratichi attività fisica regolare (≥ 3 volte a settimana)?',
  'Bevi alcolici più di 3 volte a settimana?',
  'Hai disturbi del sonno (insonnia o apnee notturne)?',
];

class AnamnesiRepository {
  AnamnesiRepository(this._db);
  final AppDatabase _db;

  Future<Map<String, bool>> carica(int pazienteId) async {
    final righe = await (_db.select(_db.risposteAnamnesi)
          ..where((r) => r.pazienteId.equals(pazienteId)))
        .get();
    return {for (final r in righe) r.domanda: r.risposta};
  }

  Future<void> salva(int pazienteId, Map<String, bool> risposte) async {
    await _db.transaction(() async {
      for (final entry in risposte.entries) {
        await _db.into(_db.risposteAnamnesi).insertOnConflictUpdate(
              RisposteAnamnesiCompanion.insert(
                pazienteId: pazienteId,
                domanda: entry.key,
                risposta: entry.value,
              ),
            );
      }
    });
  }
}
