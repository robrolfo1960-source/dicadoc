import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/health/health_service.dart';
import '../terapia/terapia_providers.dart';
import 'profilo_repository.dart';

final profiloRepositoryProvider = Provider<ProfiloRepository>((ref) {
  return ProfiloRepository(ref.watch(appDatabaseProvider));
});

final profiloDataProvider = FutureProvider<ProfiloData?>((ref) async {
  final repo = ref.watch(profiloRepositoryProvider);
  final pazienteId = ref.watch(pazienteCorrenteIdProvider);
  return repo.carica(pazienteId);
});

final healthServiceProvider = Provider<HealthConnectService>((ref) {
  return HealthConnectService(
    ref.watch(appDatabaseProvider),
    ref.watch(syncServiceProvider),
  );
});
