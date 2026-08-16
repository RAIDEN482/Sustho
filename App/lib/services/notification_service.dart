import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Local notification channel IDs (offline, on-device).
class ReminderChannels {
  static const String general = 'reminders';
}

/// Wraps [FlutterLocalNotificationsPlugin] so reminder scheduling stays fully
/// offline. Guards against missing platforms (e.g. web preview).
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation('Asia/Dhaka'));
    } catch (_) {
      // Fall back to UTC when the timezone database is unavailable.
      tz.setLocalLocation(tz.UTC);
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings();
    const linux = LinuxInitializationSettings(
      defaultActionName: 'Open',
    );
    const settings = InitializationSettings(
      android: android,
      iOS: darwin,
      macOS: darwin,
      linux: linux,
    );

    try {
      await _plugin.initialize(settings: settings);
    } catch (_) {
      // Some platforms (web) cannot initialize; degrade gracefully.
    }
    _initialized = true;
  }

  bool get isSupported {
    // Linux, Android, iOS, macOS are supported. Web is not.
    if (kIsWeb) return false;
    return true;
  }

  Future<void> requestPermissions() async {
    try {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } catch (_) {}
  }

  Future<void> cancelAll() async {
    try {
      await _plugin.cancelAll();
    } catch (_) {}
  }

  Future<void> cancel(int id) async {
    try {
      await _plugin.cancel(id: id);
    } catch (_) {}
  }

  /// Schedules a one-off local notification at [when] (local Asia/Dhaka time).
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime when,
  }) async {
    if (!isSupported) return;
    if (when.isBefore(DateTime.now())) return;
    final tzNow = tz.TZDateTime.now(tz.local);
    var tzWhen = tz.TZDateTime.from(when, tz.local);
    if (tzWhen.isBefore(tzNow)) {
      tzWhen = tzWhen.add(const Duration(days: 1));
    }
    const androidDetails = AndroidNotificationDetails(
      ReminderChannels.general,
      'Reminders',
      channelDescription: 'Shustho cycle reminders',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
    );
    const darwinDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      linux: LinuxNotificationDetails(),
    );
    try {
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tzWhen,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } catch (_) {}
  }
}
