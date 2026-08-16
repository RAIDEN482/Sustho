import 'package:hive_flutter/hive_flutter.dart';

import '../models/cycle_entry.dart';
import 'app_settings.dart';
import 'cycle_entry_adapter.dart';

/// Central repository for all local (offline-first) persistence.
class AppRepository {
  AppRepository({Box<dynamic>? settingsBox, Box<CycleEntry>? entriesBox})
      : _settingsBox = settingsBox,
        _entriesBox = entriesBox;

  static const String settingsBoxName = 'settings';
  static const String entriesBoxName = 'entries';
  static const String nutritionBoxName = 'nutrition';

  Box<dynamic>? _settingsBox;
  Box<CycleEntry>? _entriesBox;
  Box<dynamic>? _nutritionBox;

  SettingsAccess get settings => SettingsAccess(_settingsBox!);

  Box<CycleEntry> get entries => _entriesBox!;

  Box<dynamic> get nutrition => _nutritionBox!;

  Future<void> init() async {
    Hive.registerAdapter(CycleEntryAdapter());
    _settingsBox ??= await Hive.openBox<dynamic>(settingsBoxName);
    _entriesBox ??= await Hive.openBox<CycleEntry>(entriesBoxName);
    _nutritionBox ??= await Hive.openBox<dynamic>(nutritionBoxName);
  }

  // ---- Entries ----

  List<CycleEntry> getAllEntries() {
    return entries.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  CycleEntry? entryFor(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    for (final e in entries.values) {
      if (e.date == d) return e;
    }
    return null;
  }

  Future<void> saveEntry(CycleEntry entry) async {
    final existing = entryFor(entry.date);
    if (existing != null) {
      existing
        ..date = entry.date
        ..flowValue = entry.flowValue
        ..painLevel = entry.painLevel
        ..moodValues = List.of(entry.moodValues)
        ..symptomValues = List.of(entry.symptomValues)
        ..notes = entry.notes
        ..productUsedValue = entry.productUsedValue
        ..hasClots = entry.hasClots
        ..clotSizeValue = entry.clotSizeValue
        ..painDurationMinutes = entry.painDurationMinutes
        ..reliefMethodValues = List.of(entry.reliefMethodValues)
        ..medName = entry.medName
        ..medDose = entry.medDose
        ..medEffectiveness = entry.medEffectiveness
        ..energyLevel = entry.energyLevel
        ..sleepQuality = entry.sleepQuality
        ..sleepHours = entry.sleepHours
        ..moodCustom = entry.moodCustom
        ..painLocationValues = List.of(entry.painLocationValues)
        ..medTime = entry.medTime;
      await existing.save();
    } else {
      await entries.add(entry);
    }
  }

  /// Period days across all entries (dates with a non-zero flow).
  List<DateTime> periodDays() {
    return entries.values
        .where((e) => e.isPeriodDay)
        .map((e) => e.date)
        .toList();
  }

  Future<void> removeEntryFor(DateTime date) async {
    final existing = entryFor(date);
    if (existing != null) {
      await existing.delete();
    }
  }

  // ---- Nutrition ----

  static String _dayKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  /// Cups of water logged for [date].
  int waterFor(DateTime date) {
    final value = nutrition.get(_dayKey(date), defaultValue: 0);
    return value is int ? value : 0;
  }

  Future<void> setWater(DateTime date, int cups) async {
    await nutrition.put(_dayKey(date), cups);
  }

  /// Food item IDs logged for [date].
  List<String> foodLogFor(DateTime date) {
    final value = nutrition.get('food-${_dayKey(date)}', defaultValue: const []);
    return value is List ? value.cast<String>() : [];
  }

  Future<void> addFood(DateTime date, String foodId) async {
    final current = foodLogFor(date);
    if (current.contains(foodId)) return;
    current.add(foodId);
    await nutrition.put('food-${_dayKey(date)}', current);
  }

  Future<void> removeFood(DateTime date, String foodId) async {
    final current = foodLogFor(date);
    current.remove(foodId);
    await nutrition.put('food-${_dayKey(date)}', current);
  }

  Future<void> clearAllData() async {
    await entries.clear();
    await nutrition.clear();
    await _resetSettings();
  }

  Future<void> _resetSettings() async {
    final box = _settingsBox!;
    await box.deleteAll([
      AppSettings.onboardingCompleted,
      AppSettings.lastPeriodStart,
      AppSettings.userCycleLength,
      AppSettings.userPeriodLength,
      AppSettings.guardianName,
      AppSettings.guardianRelation,
      AppSettings.guardianEnabled,
      AppSettings.remindersEnabled,
    ]);
  }

  // ---- Settings helpers ----

  bool get onboardingCompleted =>
      settings.getBool(AppSettings.onboardingCompleted, false);

  String get locale => settings.getString(AppSettings.locale, 'en');

  String get themeMode => settings.getString(AppSettings.themeMode, 'system');

  DateTime? get lastPeriodStart => settings.getDate(AppSettings.lastPeriodStart);

  int get userCycleLength => settings.getInt(AppSettings.userCycleLength, 28);

  int get userPeriodLength =>
      settings.getInt(AppSettings.userPeriodLength, 5);

  bool get guardianEnabled => settings.getBool(AppSettings.guardianEnabled);

  String get guardianName => settings.getString(AppSettings.guardianName);

  String get guardianRelation =>
      settings.getString(AppSettings.guardianRelation);

  bool get remindersEnabled => settings.getBool(AppSettings.remindersEnabled);

  String get reminderTime => settings.getString(AppSettings.reminderTime, '09:00');

  Future<void> setOnboardingCompleted(bool value) =>
      settings.setBool(AppSettings.onboardingCompleted, value);

  Future<void> setLocale(String value) => settings.setString(AppSettings.locale, value);

  Future<void> setThemeMode(String value) =>
      settings.setString(AppSettings.themeMode, value);

  Future<void> setLastPeriodStart(DateTime value) =>
      settings.setDate(AppSettings.lastPeriodStart, value);

  Future<void> setUserCycleLength(int value) =>
      settings.setInt(AppSettings.userCycleLength, value);

  Future<void> setUserPeriodLength(int value) =>
      settings.setInt(AppSettings.userPeriodLength, value);

  Future<void> setGuardianEnabled(bool value) =>
      settings.setBool(AppSettings.guardianEnabled, value);

  Future<void> setGuardian({required String name, required String relation}) async {
    await settings.setString(AppSettings.guardianName, name);
    await settings.setString(AppSettings.guardianRelation, relation);
  }

  Future<void> setRemindersEnabled(bool value) =>
      settings.setBool(AppSettings.remindersEnabled, value);

  Future<void> setReminderTime(String value) =>
      settings.setString(AppSettings.reminderTime, value);

  // ---- Reminder type toggles ----

  bool reminderEnabled(String key, [bool fallback = true]) =>
      settings.getBool(key, fallback);

  Future<void> setReminderEnabled(String key, bool value) =>
      settings.setBool(key, value);

  String get quietStart => settings.getString(AppSettings.quietStart, '22:00');

  String get quietEnd => settings.getString(AppSettings.quietEnd, '07:00');

  Future<void> setQuietHours(String start, String end) async {
    await settings.setString(AppSettings.quietStart, start);
    await settings.setString(AppSettings.quietEnd, end);
  }
}
