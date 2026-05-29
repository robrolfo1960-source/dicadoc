import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../terapia/terapia_providers.dart';
import 'referti_repository.dart';

final refertiRepositoryProvider = Provider<RefertiRepository>((ref) {
  return RefertiRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(syncServiceProvider),
  );
});

final storicoOcrProvider = FutureProvider<List<dynamic>>((ref) async {
  final repo = ref.watch(refertiRepositoryProvider);
  final pazienteId = ref.watch(pazienteCorrenteIdProvider);
  return repo.storicoOcr(pazienteId);
});
