import 'package:flutter/foundation.dart';

import '../core/utils/cycle_engine.dart';
import '../data/app_repository.dart';
import '../models/cycle_entry.dart';
import '../models/enums.dart';

/// Holds cycle entries and exposes the current prediction. Any write goes
/// through the repository (Hive), so data survives restarts.
class CycleController extends ChangeNotifier {
  CycleController(this.repository) {
    _entries = repository.getAllEntries();
  }

  final AppRepository repository;

  List<CycleEntry> _entries = [];
  late CyclePrediction _prediction;

  List<CycleEntry> get entries => _entries;

  CyclePrediction get prediction => _prediction;

  int get cycleLength => _prediction.cycleLength;
  int get periodLength => _prediction.periodLength;

  void reload() {
    _entries = repository.getAllEntries();
    _recompute();
  }

  void _recompute() {
    _prediction = CycleEngine.predict(
      repository.periodDays(),
      userCycleLength: repository.userCycleLength,
      userPeriodLength: repository.userPeriodLength,
      lastLoggedStart: repository.lastPeriodStart,
    );
    notifyListeners();
  }

  List<DateTime> get periodDays => repository.periodDays();

  CycleEntry? entryFor(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    for (final e in _entries) {
      if (e.date == d) return e;
    }
    return null;
  }

  Future<void> logPeriod(
    DateTime date, {
    FlowLevel flow = FlowLevel.medium,
  }) async {
    final existing = entryFor(date);
    if (existing != null) {
      existing.flow = flow;
      await repository.saveEntry(existing);
    } else {
      await repository.saveEntry(CycleEntry.create(date: date, flow: flow));
    }
    await repository.setLastPeriodStart(date);
    reload();
  }

  Future<void> logSymptoms({
    required DateTime date,
    List<Mood> moods = const [],
    String moodCustom = '',
    List<SymptomType> symptoms = const [],
    int painLevel = 0,
    String notes = '',
    List<PainLocation> painLocations = const [],
    List<ReliefMethod> reliefMethods = const [],
    int painDurationMinutes = 0,
    String medName = '',
    String medDose = '',
    String medTime = '',
    int medEffectiveness = 0,
    int energyLevel = 0,
    int sleepQuality = 0,
    double sleepHours = 0,
  }) async {
    final existing = entryFor(date);
    if (existing != null) {
      existing
        ..moods = moods
        ..moodCustom = moodCustom
        ..symptoms = symptoms
        ..painLevel = painLevel
        ..notes = notes
        ..painLocations = painLocations
        ..reliefMethods = reliefMethods
        ..painDurationMinutes = painDurationMinutes
        ..medName = medName
        ..medDose = medDose
        ..medTime = medTime
        ..medEffectiveness = medEffectiveness
        ..energyLevel = energyLevel
        ..sleepQuality = sleepQuality
        ..sleepHours = sleepHours;
      await repository.saveEntry(existing);
    } else {
      await repository.saveEntry(
        CycleEntry.create(
          date: date,
          moods: moods,
          moodCustom: moodCustom,
          symptoms: symptoms,
          painLevel: painLevel,
          notes: notes,
          painLocations: painLocations,
          reliefMethods: reliefMethods,
          painDurationMinutes: painDurationMinutes,
          medName: medName,
          medDose: medDose,
          medTime: medTime,
          medEffectiveness: medEffectiveness,
          energyLevel: energyLevel,
          sleepQuality: sleepQuality,
          sleepHours: sleepHours,
        ),
      );
    }
    reload();
  }

  /// Start of the most recent logged period, if any.
  DateTime? get currentPeriodStart {
    final starts = periodDays.toSet();
    if (starts.isEmpty) return null;
    return starts.reduce((a, b) => a.isAfter(b) ? a : b);
  }

  /// Day number of the current period (1-based), or null when not in a period.
  int? get currentDayOfPeriod {
    final start = currentPeriodStart;
    if (start == null) return null;
    final now = DateTime.now();
    final day = DateTime(now.year, now.month, now.day)
            .difference(DateTime(start.year, start.month, start.day))
            .inDays +
        1;
    if (day < 1 || day > periodLength) return null;
    return day;
  }

  Future<void> markNotPeriod(DateTime date) async {
    final existing = entryFor(date);
    if (existing == null) return;
    existing.flow = FlowLevel.none;
    await repository.saveEntry(existing);
    reload();
  }

  Future<void> deleteEntry(DateTime date) async {
    await repository.removeEntryFor(date);
    reload();
  }

  Future<void> clearAll() async {
    await repository.clearAllData();
    reload();
  }
}
