import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../core/utils/cycle_engine.dart';
import '../data/app_repository.dart';
import '../services/notification_service.dart';

/// Types of offline reminders the user can toggle.
enum ReminderType {
  periodPredict(0, 'reminderPeriodPredict'),
  periodEnd(1, 'reminderPeriodEnd'),
  pill(2, 'reminderPill'),
  water(3, 'reminderWater'),
  symptom(4, 'reminderSymptom'),
  doctor(5, 'reminderDoctor');

  const ReminderType(this.id, this.settingsKey);

  final int id;
  final String settingsKey;
}

/// Schedules and persists reminder preferences. All scheduling happens on-device
/// via [NotificationService] (offline-first).
class RemindersController extends ChangeNotifier {
  RemindersController(this.repository);

  final AppRepository repository;

  bool get enabled => repository.remindersEnabled;
  String get time => repository.reminderTime;
  String get quietStart => repository.quietStart;
  String get quietEnd => repository.quietEnd;

  bool isTypeEnabled(ReminderType type) =>
      repository.reminderEnabled(type.settingsKey, true);

  Future<void> setMasterEnabled(bool value) async {
    await repository.setRemindersEnabled(value);
    if (value) {
      await scheduleAll();
    } else {
      await NotificationService.instance.cancelAll();
    }
    notifyListeners();
  }

  Future<void> setTime(String value) async {
    await repository.setReminderTime(value);
    await scheduleAll();
    notifyListeners();
  }

  Future<void> setQuietHours(String start, String end) async {
    await repository.setQuietHours(start, end);
    notifyListeners();
  }

  Future<void> setTypeEnabled(ReminderType type, bool value) async {
    await repository.setReminderEnabled(type.settingsKey, value);
    if (!value) {
      await NotificationService.instance.cancel(type.id);
    } else {
      await scheduleAll();
    }
    notifyListeners();
  }

  Future<void> scheduleAll() async {
    if (!enabled) return;
    await NotificationService.instance.cancelAll();
    await NotificationService.instance.requestPermissions();

    final now = DateTime.now();
    final startTime = _parseTime(time);
    final quiet = _parseQuiet();

    // Pill & doctor are daily time-based reminders.
    if (isTypeEnabled(ReminderType.pill)) {
      final when = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
      if (!_inQuiet(now, quiet)) {
        await NotificationService.instance.schedule(
          id: ReminderType.pill.id,
          title: _pillTitle,
          body: _pillBody,
          when: when,
        );
      }
    }
    if (isTypeEnabled(ReminderType.doctor)) {
      final when = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute + 30);
      if (!_inQuiet(now, quiet)) {
        await NotificationService.instance.schedule(
          id: ReminderType.doctor.id,
          title: _doctorTitle,
          body: _doctorBody,
          when: when,
        );
      }
    }
  }

  // ---- Derived text (localized by caller where needed; keep concise) ----

  String get _pillTitle => 'Shustho';
  String get _pillBody => 'Take your medicine on time.';
  String get _doctorTitle => 'Shustho';
  String get _doctorBody => 'Doctor appointment? Tap to log it.';

  ({int hour, int minute}) _parseTime(String value) {
    final parts = value.split(':');
    final hour = parts.isNotEmpty ? int.tryParse(parts[0]) ?? 9 : 9;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return (hour: hour, minute: minute);
  }

  ({int startMinutes, int endMinutes}) _parseQuiet() {
    final s = _parseTime(quietStart);
    final e = _parseTime(quietEnd);
    return (
      startMinutes: s.hour * 60 + s.minute,
      endMinutes: e.hour * 60 + e.minute,
    );
  }

  bool _inQuiet(DateTime now, ({int startMinutes, int endMinutes}) quiet) {
    final minutes = now.hour * 60 + now.minute;
    if (quiet.startMinutes <= quiet.endMinutes) {
      return minutes >= quiet.startMinutes && minutes < quiet.endMinutes;
    }
    // Overnight quiet window (e.g. 22:00-07:00).
    return minutes >= quiet.startMinutes || minutes < quiet.endMinutes;
  }

  /// Whether a reminder at [when] would fall inside quiet hours.
  bool wouldBeQuiet(DateTime when) => _inQuiet(when, _parseQuiet());

  /// Days until the next predicted period for period reminders.
  int daysUntilNextPeriod(CyclePrediction prediction) =>
      math.max(0, prediction.daysUntilNextPeriod);
}
