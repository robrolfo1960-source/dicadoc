import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/config/app_config.dart';
import '../../data/db/database.dart';
import '../../data/sync/cloud_sync.dart';
import '../../data/sync/sync_service.dart';
import '../alert/notification_service.dart';
import 'terapia_repository.dart';

/// Database: override in main.dart.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('appDatabaseProvider deve essere sovrascritto in main.dart');
});

/// Servizio notifiche: override in main.dart.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  throw UnimplementedError('notificationServiceProvider deve essere sovrascritto in main.dart');
});

/// AppConfig: override in main.dart.
final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError('appConfigProvider deve essere sovrascritto in main.dart');
});

/// Sync: LocalOnlySync in Fase 1/2; CloudSync automatico quando AppConfig
/// contiene un serverUrl (impostato via QR onboarding in Fase 3).
final syncServiceProvider = Provider<SyncService>((ref) {
  // La risoluzione del serverUrl è asincrona; in un'app reale si userebbe
  // un FutureProvider e si attenderebbe prima di costruire i repository.
  // Per ora lo leggiamo in modo sincrono usando il valore già caricato in main.
  return const LocalOnlySync();
});

final syncServiceAsyncProvider = FutureProvider<SyncService>((ref) async {
  final serverUrl = await AppConfig.instance.getServerUrl();
  if (serverUrl != null && serverUrl.isNotEmpty) {
    final db = ref.read(appDatabaseProvider);
    return CloudSync(db, serverUrl);
  }
  return const LocalOnlySync();
});

final terapiaRepositoryProvider = Provider<TerapiaRepository>((ref) {
  return TerapiaRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(notificationServiceProvider),
    ref.watch(syncServiceProvider),
  );
});

// Valore iniziale impostato da main() prima di runApp.
int _pazienteIdIniziale = 1;

/// Paziente correntemente attivo. Aggiornabile a runtime dopo onboarding QR.
final pazienteCorrenteIdProvider =
    NotifierProvider<PazienteIdNotifier, int>(PazienteIdNotifier.new);

class PazienteIdNotifier extends Notifier<int> {
  @override
  int build() => _pazienteIdIniziale;
  void set(int id) => state = id;
}

/// Chiamato da main() prima di runApp per settare il paziente dal keystore.
void impostaPazienteIniziale(int id) => _pazienteIdIniziale = id;

/// Le dosi di oggi raggruppate per farmaco (alimenta il pannello P1).
final farmaciOggiProvider = FutureProvider<List<FarmacoOggi>>((ref) async {
  final repo = ref.watch(terapiaRepositoryProvider);
  final pazienteId = ref.watch(pazienteCorrenteIdProvider);
  return repo.farmaciOggi(pazienteId);
});
