import 'dart:async';
import 'dart:io';

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

  // Cattura qualsiasi eccezione durante l'init e la mostra su schermo
  // (in release mode i crash Dart sono silenziosi → schermata bianca).
  await runZonedGuarded(_init, (error, stack) {
    runApp(_ErrorApp(error: error.toString(), stack: stack.toString()));
  });
}

Future<void> _init() async {
  // Inizializzazione asincrona pesante (Keystore, SQLCipher, seed).
  await initializeDateFormatting('it_IT', null);
  final passphrase = await CryptoService.instance.getPassphrase();
  final appConfig = AppConfig.instance;
  final isOnboarded = await appConfig.isOnboarded();
  final pazienteId = await appConfig.getPazienteId() ?? 1;
  impostaPazienteIniziale(pazienteId);
  final db = AppDatabase(passphrase);
  await seedIfEmpty(db);
  final notif = NotificationService.instance;
  await notif.init();

  // Sync: su macOS (medico) usa localhost di default; su mobile segue il QR.
  var serverUrl = await appConfig.getServerUrl();
  if (Platform.isMacOS && (serverUrl == null || serverUrl.isEmpty)) {
    serverUrl = 'http://localhost:8090';
    await appConfig.setServerUrl(serverUrl);
  }
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

// Schermata di diagnostica: sostituisce il bianco silenzioso con l'errore visibile.
class _ErrorApp extends StatelessWidget {
  const _ErrorApp({required this.error, required this.stack});
  final String error;
  final String stack;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red.shade50,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ERRORE AVVIO',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(error,
                    style: const TextStyle(fontSize: 14, color: Colors.black87)),
                const Divider(height: 24),
                Text(stack,
                    style:
                        const TextStyle(fontSize: 10, color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
