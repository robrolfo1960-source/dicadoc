import '../db/database.dart';
import '../sync/sync_service.dart';

/// Servizio F6 HEALTH CONNECT — architettura pronta.
///
/// Per attivare il sync reale:
///  1. Aggiungi `health: ^12.x.x` a pubspec.yaml (attendi che il package
///     risolva il conflitto compileSdk 34 vs connect-client >= 1.1.x).
///  2. Sostituisci il body di [isDisponibile] e [importa] con le
///     chiamate al package `health` (vedere commit di Fase 5).
///  3. Aggiungi le uses-permission per health.READ_* in AndroidManifest
///     (già presenti).
class HealthConnectService {
  HealthConnectService(this._db, this._sync);

  // ignore: unused_field
  final AppDatabase _db;
  // ignore: unused_field
  final SyncService _sync;

  Future<bool> isDisponibile() async {
    // TODO(Fase 5+): return await Health().isHealthConnectAvailable();
    return false;
  }

  /// Importa le ultime [giorni] giornate da Health Connect.
  /// Restituisce il numero di nuove misurazioni inserite.
  Future<int> importa({required int pazienteId, int giorni = 30}) async {
    // TODO(Fase 5+): implementare con package:health
    throw UnsupportedError('Health Connect non ancora disponibile in questa build.');
  }
}
