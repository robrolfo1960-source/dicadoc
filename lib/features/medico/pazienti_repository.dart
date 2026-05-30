import 'package:drift/drift.dart';

import '../../data/db/database.dart';
import '../../data/sync/cloud_sync.dart';
import '../../data/sync/sync_service.dart';

class PazientiRepository {
  PazientiRepository(this._db, this._sync);

  final AppDatabase _db;
  final SyncService _sync;

  Future<List<Paziente>> listaPazienti() =>
      (_db.select(_db.pazienti)
            ..orderBy([(p) => OrderingTerm(expression: p.cognome)]))
          .get();

  Future<int> creaPaziente({
    required String nome,
    required String cognome,
    required String codiceFiscale,
    required DateTime dataNascita,
    required String cellulare,
    String? telefono,
    String? indirizzo,
    String? email,
  }) async {
    final id = await _db.into(_db.pazienti).insert(
          PazientiCompanion.insert(
            nome: nome,
            cognome: cognome,
            codiceFiscale: codiceFiscale,
            dataNascita: dataNascita,
            cellulare: cellulare,
            telefono: Value(telefono),
            indirizzo: Value(indirizzo),
            email: Value(email),
          ),
        );
    return id;
  }

  Future<void> aggiornaPaziente({
    required int id,
    required String nome,
    required String cognome,
    required String codiceFiscale,
    required DateTime dataNascita,
    required String cellulare,
    String? telefono,
    String? indirizzo,
    String? email,
  }) async {
    await (_db.update(_db.pazienti)..where((p) => p.id.equals(id))).write(
      PazientiCompanion(
        nome: Value(nome),
        cognome: Value(cognome),
        codiceFiscale: Value(codiceFiscale),
        dataNascita: Value(dataNascita),
        cellulare: Value(cellulare),
        telefono: Value(telefono),
        indirizzo: Value(indirizzo),
        email: Value(email),
      ),
    );
  }

  Future<List<Terapia>> terapieAttive(int pazienteId) =>
      (_db.select(_db.terapie)
            ..where((t) =>
                t.pazienteId.equals(pazienteId) & t.attiva.equals(true))
            ..orderBy([(t) => OrderingTerm(expression: t.nomeFarmaco)]))
          .get();

  Future<List<Misurazione>> misurazioniRecenti(int pazienteId,
      {int limit = 20}) =>
      (_db.select(_db.misurazioni)
            ..where((m) => m.pazienteId.equals(pazienteId))
            ..orderBy([
              (m) => OrderingTerm(expression: m.data, mode: OrderingMode.desc)
            ])
            ..limit(limit))
          .get();

  Future<ParametroCatalogo?> parametroById(int id) =>
      (_db.select(_db.catalogoParametri)..where((p) => p.id.equals(id)))
          .getSingleOrNull();

  /// Pubblica terapie del paziente su PocketBase e scarica i suoi dati.
  Future<String> sincronizza(int pazienteId) async {
    if (!_sync.isCloudEnabled) return 'Sync non configurato';
    if (_sync is CloudSync) {
      final cs = CloudSync(_db, (_sync as CloudSync).serverUrl, // ignore: avoid_as
          pazienteId: pazienteId);
      await cs.push();
      await cs.pull();
      return 'Sincronizzazione completata';
    }
    return 'Sync non abilitato';
  }
}
