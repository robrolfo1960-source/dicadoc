import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/theme.dart';
import 'data/config/app_config.dart';
import 'data/db/database.dart';
import 'data/seed/seed_data.dart';
import 'data/security/crypto_service.dart';
import 'data/sync/cloud_sync.dart';
import 'data/sync/sync_service.dart';
import 'features/alert/notification_service.dart';
import 'features/terapia/terapia_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Mostra subito uno schermo di caricamento: evita il blocco sulla splash
  // nativa mentre SecureStorage / SQLCipher inizializzano il Keystore.
  runApp(const _LoadingApp());

  // Inizializzazione asincrona pesante (Keystore, SQLCipher, seed).
  await initializeDateFormatting('it_IT', null);
  final passphrase = await CryptoService.instance.getPassphrase();
  final appConfig = AppConfig.instance;
  final isOnboarded = await appConfig.isOnboarded();
  final pazienteId = await appConfig.getPazienteId() ?? 1;
  final db = AppDatabase(passphrase);
  await seedIfEmpty(db);
  final notif = NotificationService.instance;
  await notif.init();

  // Sync: LocalOnly di default; CloudSync se il server è configurato.
  final serverUrl = await appConfig.getServerUrl();
  final SyncService sync = (serverUrl != null && serverUrl.isNotEmpty)
      ? CloudSync(db, serverUrl, pazienteId: pazienteId)
      : const LocalOnlySync();

  // Sostituisce il loader con l'app vera.
  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        notificationServiceProvider.overrideWithValue(notif),
        appConfigProvider.overrideWithValue(appConfig),
        pazienteCorrenteIdProvider.overrideWithValue(pazienteId),
        syncServiceProvider.overrideWithValue(sync),
      ],
      child: DicaDocApp(showOnboarding: !isOnboarded),
    ),
  );
}

class _LoadingApp extends StatelessWidget {
  const _LoadingApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppTheme.brand,
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.health_and_safety_outlined,
                  size: 64, color: Colors.white),
              SizedBox(height: 24),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
