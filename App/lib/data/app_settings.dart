import 'package:hive/hive.dart';

/// App-level settings persisted in the local settings box.
class AppSettings {
  AppSettings._();

  static const String locale = 'locale';
  static const String themeMode = 'themeMode';
  static const String onboardingCompleted = 'onboardingCompleted';
  static const String lastPeriodStart = 'lastPeriodStart';
  static const String userCycleLength = 'userCycleLength';
  static const String userPeriodLength = 'userPeriodLength';
  static const String guardianName = 'guardianName';
  static const String guardianRelation = 'guardianRelation';
  static const String guardianEnabled = 'guardianEnabled';
  static const String remindersEnabled = 'remindersEnabled';
  static const String reminderTime = 'reminderTime';
  static const String quietStart = 'quietStart';
  static const String quietEnd = 'quietEnd';
  static const String reminderPeriodPredict = 'reminderPeriodPredict';
  static const String reminderPeriodEnd = 'reminderPeriodEnd';
  static const String reminderPill = 'reminderPill';
  static const String reminderWater = 'reminderWater';
  static const String reminderSymptom = 'reminderSymptom';
  static const String reminderDoctor = 'reminderDoctor';
}

/// A small helper for reading/writing typed values from a Hive box.
class SettingsAccess {
  SettingsAccess(this._box);

  final Box<dynamic> _box;

  String getString(String key, [String fallback = '']) {
    final v = _box.get(key);
    return v is String ? v : fallback;
  }

  bool getBool(String key, [bool fallback = false]) {
    final v = _box.get(key);
    return v is bool ? v : fallback;
  }

  int getInt(String key, [int fallback = 0]) {
    final v = _box.get(key);
    return v is int ? v : fallback;
  }

  DateTime? getDate(String key) {
    final v = _box.get(key);
    return v is DateTime ? v : null;
  }

  Future<void> setString(String key, String value) async {
    await _box.put(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _box.put(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _box.put(key, value);
  }

  Future<void> setDate(String key, DateTime? value) async {
    if (value == null) {
      await _box.delete(key);
    } else {
      await _box.put(key, value);
    }
  }
}
