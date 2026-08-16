import 'package:flutter/material.dart';

import '../data/app_repository.dart';
import '../models/cycle_entry.dart';
import '../models/enums.dart';

/// Application state: locale, theme, onboarding, guardian and reminders.
class AppState extends ChangeNotifier {
  AppState(this.repository);

  final AppRepository repository;

  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.system;
  bool _onboardingCompleted = false;
  bool _guardianEnabled = false;
  String _guardianName = '';
  String _guardianRelation = '';
  bool _remindersEnabled = false;
  String _reminderTime = '09:00';

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  bool get onboardingCompleted => _onboardingCompleted;
  bool get guardianEnabled => _guardianEnabled;
  String get guardianName => _guardianName;
  String get guardianRelation => _guardianRelation;
  bool get remindersEnabled => _remindersEnabled;
  String get reminderTime => _reminderTime;

  void load() {
    _locale = Locale(repository.locale);
    _themeMode = _parseThemeMode(repository.themeMode);
    _onboardingCompleted = repository.onboardingCompleted;
    _guardianEnabled = repository.guardianEnabled;
    _guardianName = repository.guardianName;
    _guardianRelation = repository.guardianRelation;
    _remindersEnabled = repository.remindersEnabled;
    _reminderTime = repository.reminderTime;
    notifyListeners();
  }

  static ThemeMode _parseThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (locale.languageCode == _locale.languageCode) return;
    _locale = locale;
    await repository.setLocale(locale.languageCode);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;
    _themeMode = mode;
    await repository.setThemeMode(mode.name);
    notifyListeners();
  }

  Future<void> completeOnboarding({
    required DateTime lastPeriodStart,
    required int cycleLength,
    required int periodLength,
    String guardianName = '',
    String guardianRelation = '',
    bool guardianEnabled = false,
  }) async {
    _onboardingCompleted = true;
    _guardianName = guardianName;
    _guardianRelation = guardianRelation;
    _guardianEnabled = guardianEnabled;
    await repository.setOnboardingCompleted(true);
    await repository.setLastPeriodStart(lastPeriodStart);
    await repository.setUserCycleLength(cycleLength);
    await repository.setUserPeriodLength(periodLength);
    if (guardianEnabled) {
      await repository.setGuardian(name: guardianName, relation: guardianRelation);
      await repository.setGuardianEnabled(true);
    }
    // Seed a period entry for the last period start with medium flow.
    if (repository.entryFor(lastPeriodStart) == null) {
      await repository.saveEntry(
        CycleEntry.create(
          date: lastPeriodStart,
          flow: FlowLevel.medium,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> updateGuardian({
    required String name,
    required String relation,
    required bool enabled,
  }) async {
    _guardianName = name;
    _guardianRelation = relation;
    _guardianEnabled = enabled;
    await repository.setGuardian(name: name, relation: relation);
    await repository.setGuardianEnabled(enabled);
    notifyListeners();
  }

  Future<void> setReminders(bool enabled, String time) async {
    _remindersEnabled = enabled;
    _reminderTime = time;
    await repository.setRemindersEnabled(enabled);
    await repository.setReminderTime(time);
    notifyListeners();
  }

  Future<void> resetAll() async {
    await repository.clearAllData();
    _onboardingCompleted = false;
    _guardianEnabled = false;
    _guardianName = '';
    _guardianRelation = '';
    _remindersEnabled = false;
    notifyListeners();
  }
}
