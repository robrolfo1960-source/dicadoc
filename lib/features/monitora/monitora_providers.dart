import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../terapia/terapia_providers.dart';
import 'monitora_repository.dart';

final monitoraRepositoryProvider = Provider<MonitoraRepository>((ref) {
  return MonitoraRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(syncServiceProvider),
  );
});

final parametriAbilitatiProvider =
    FutureProvider<List<ParametroConValore>>((ref) async {
  final repo = ref.watch(monitoraRepositoryProvider);
  final pazienteId = ref.watch(pazienteCorrenteIdProvider);
  return repo.parametriAbilitati(pazienteId);
});
