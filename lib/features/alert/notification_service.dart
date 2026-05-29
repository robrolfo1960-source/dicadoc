import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../core/enums.dart';

/// Funzione F1: ALERT.
///
/// Pianifica le notifiche di promemoria per l'assunzione dei farmaci.
/// Per i farmaci ad alta priorita'/salvavita applica il "rilancio
/// dell'allarme": fino a 3 promemoria ravvicinati finche' il paziente non
/// interagisce (l'interazione cancella i promemoria pendenti).
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'dicadoc_terapie';
  static const String _channelName = 'Promemoria Terapie';

  // Intervallo tra i rilanci per i farmaci ad alta priorita'.
  static const Duration _intervalloEscalation = Duration(minutes: 5);
  static const int _numeroRilanci = 3;

  Future<void> init() async {
    tzdata.initializeTimeZones();
    try {
      final localInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localInfo.identifier));
    } catch (_) {
      // Fallback prudente: in caso di errore resta su UTC.
    }

    const androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);
    await _plugin.initialize(settings: initSettings);
  }

  /// Richiede i permessi di notifica (Android 13+) e di sveglia esatta
  /// (Android 12+, necessaria per i promemoria puntuali dei salvavita).
  Future<void> requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();

    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    await ios?.requestPermissions(alert: true, badge: true, sound: true);
  }

  NotificationDetails _details(PrioritaTerapia priorita) {
    final android = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: 'Promemoria per l\'assunzione delle terapie',
      importance:
          priorita.richiedeEscalation ? Importance.max : Importance.high,
      priority:
          priorita.richiedeEscalation ? Priority.max : Priority.high,
      category: AndroidNotificationCategory.reminder,
    );
    return NotificationDetails(
      android: android,
      iOS: const DarwinNotificationDetails(),
    );
  }

  /// ID notifica derivato in modo stabile dall'orario (+ indice rilancio).
  int _notifId(int orarioId, int rilancio) => orarioId * 100 + rilancio;

  /// Pianifica il promemoria giornaliero per una dose.
  /// [ora] e [minuto] sono l'orario locale; si ripete ogni giorno.
  Future<void> pianificaDoseGiornaliera({
    required int orarioId,
    required String nomeFarmaco,
    required String? dosaggio,
    required int ora,
    required int minuto,
    required PrioritaTerapia priorita,
  }) async {
    final corpo = dosaggio == null
        ? 'E\' ora di assumere $nomeFarmaco.'
        : 'E\' ora di assumere $nomeFarmaco ($dosaggio).';

    // Promemoria principale.
    await _zoned(
      id: _notifId(orarioId, 0),
      titolo: 'Promemoria terapia',
      corpo: corpo,
      quando: _prossimaOccorrenza(ora, minuto),
      priorita: priorita,
    );

    // Rilancio dell'allarme solo per alta priorita'/salvavita.
    if (priorita.richiedeEscalation) {
      for (var i = 1; i <= _numeroRilanci; i++) {
        final offset = _intervalloEscalation * i;
        final base = _prossimaOccorrenza(ora, minuto);
        await _zoned(
          id: _notifId(orarioId, i),
          titolo: 'Promemoria terapia (sollecito $i)',
          corpo: 'Non risulta confermata l\'assunzione di $nomeFarmaco.',
          quando: base.add(offset),
          priorita: priorita,
        );
      }
    }
  }

  Future<void> _zoned({
    required int id,
    required String titolo,
    required String corpo,
    required tz.TZDateTime quando,
    required PrioritaTerapia priorita,
  }) async {
    await _plugin.zonedSchedule(
      id: id,
      title: titolo,
      body: corpo,
      scheduledDate: quando,
      notificationDetails: _details(priorita),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Cancella i promemoria (principale + rilanci) per una dose:
  /// si chiama quando il paziente ha interagito (Assunto/Posticipa/Rifiutato).
  Future<void> cancellaDose(int orarioId) async {
    for (var i = 0; i <= _numeroRilanci; i++) {
      await _plugin.cancel(id: _notifId(orarioId, i));
    }
  }

  /// Promemoria singolo per il "Posticipa di 15 min".
  Future<void> posticipa15min({
    required int orarioId,
    required String nomeFarmaco,
    required PrioritaTerapia priorita,
  }) async {
    final quando = tz.TZDateTime.now(tz.local).add(const Duration(minutes: 15));
    await _plugin.zonedSchedule(
      id: _notifId(orarioId, 9),
      title: 'Promemoria terapia',
      body: 'Promemoria posticipato: $nomeFarmaco.',
      scheduledDate: quando,
      notificationDetails: _details(priorita),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  tz.TZDateTime _prossimaOccorrenza(int ora, int minuto) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, ora, minuto);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
