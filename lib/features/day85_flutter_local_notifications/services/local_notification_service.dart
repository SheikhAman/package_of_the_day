import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final payloadStream = BehaviorSubject<String?>();

  static Future<NotificationDetails> _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'Important Notifications',
        channelDescription: 'This channel is used for critical app alerts.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future<void> init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    // FIX: version 22.3.0 uses named parameter 'settings'
    await _notificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        payloadStream.add(response.payload);
      },
    );

    if (initScheduled) {
      tz.initializeTimeZones();
    }
  }

  /// 1. Simple Notification
  static Future<void> showNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) async {
    final details = await _notificationDetails();
    // FIX: version 22.3.0 uses named parameters for all arguments
    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }

  /// 2. Scheduled Notification
  /// 2. Scheduled Notification
  static Future<void> showScheduledNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    final details = await _notificationDetails();
    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: details,
      payload: payload,
      // CHANGE: Use inexact instead of exact to avoid permission crashes
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  // Inside LocalNotificationService class
  static Future<void> requestPermissions() async {
    final androidImplementation = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidImplementation?.requestNotificationsPermission();
  }

  static Future<void> cancelAll() async =>
      await _notificationsPlugin.cancelAll();
}
