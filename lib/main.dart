import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'data/db/database.dart';
import 'data/seed/seed_data.dart';
import 'features/alert/notification_service.dart';
import 'features/terapia/terapia_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Formattazione date in italiano (usata dai DateFormat con locale it_IT).
  await initializeDateFormatting('it_IT', null);

  // Database locale + dati di esempio al primo avvio.
  final db = AppDatabase();
  await seedIfEmpty(db);

  // Notifiche locali (F1: ALERT).
  final notif = NotificationService.instance;
  await notif.init();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        notificationServiceProvider.overrideWithValue(notif),
      ],
      child: const DicaDocApp(),
    ),
  );
}
