import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/database.dart';
import '../terapia/terapia_providers.dart';
import 'pazienti_repository.dart';

final pazientiRepositoryProvider = Provider<PazientiRepository>((ref) {
  return PazientiRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(syncServiceProvider),
  );
});

final listaPazientiProvider = FutureProvider<List<Paziente>>((ref) {
  return ref.watch(pazientiRepositoryProvider).listaPazienti();
});
