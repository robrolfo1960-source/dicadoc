import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../terapia/terapia_providers.dart';
import 'anamnesi_repository.dart';

final anamnesiRepositoryProvider = Provider<AnamnesiRepository>((ref) {
  return AnamnesiRepository(ref.watch(appDatabaseProvider));
});

final anamnesiProvider =
    FutureProvider<Map<String, bool>>((ref) async {
  final repo = ref.watch(anamnesiRepositoryProvider);
  final pazienteId = ref.watch(pazienteCorrenteIdProvider);
  return repo.carica(pazienteId);
});
