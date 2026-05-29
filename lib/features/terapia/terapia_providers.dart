import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/database.dart';
import '../../data/sync/sync_service.dart';
import '../alert/notification_service.dart';
import 'terapia_repository.dart';

/// Database: fornito tramite override in main.dart (creato una sola volta).
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('appDatabaseProvider deve essere sovrascritto in main.dart');
});

/// Servizio notifiche: override in main.dart dopo init().
final notificationServiceProvider = Provider<NotificationService>((ref) {
  throw UnimplementedError('notificationServiceProvider deve essere sovrascritto in main.dart');
});

/// Servizio di sync. Fase 1: locale puro. Cambiare qui per abilitare il cloud.
final syncServiceProvider = Provider<SyncService>((ref) {
  return const LocalOnlySync();
});

final terapiaRepositoryProvider = Provider<TerapiaRepository>((ref) {
  return TerapiaRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(notificationServiceProvider),
    ref.watch(syncServiceProvider),
  );
});

/// Paziente correntemente attivo sul device. In Fase 1 c'e' un solo paziente
/// (id 1). Verra' impostato dall'onboarding QR in Fase 3.
final pazienteCorrenteIdProvider = Provider<int>((ref) => 1);

/// Le dosi di oggi raggruppate per farmaco (alimenta il pannello P1).
final farmaciOggiProvider = FutureProvider<List<FarmacoOggi>>((ref) async {
  final repo = ref.watch(terapiaRepositoryProvider);
  final pazienteId = ref.watch(pazienteCorrenteIdProvider);
  return repo.farmaciOggi(pazienteId);
});
