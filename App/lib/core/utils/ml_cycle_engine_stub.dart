import 'cycle_engine.dart';

/// Fallback cycle engine for web & platforms without native TFLite binaries.
class MLCycleEngine {
  Future<void> init() async {}

  CyclePrediction predict(
    List<DateTime> periodDays, {
    DateTime? date,
    int? userCycleLength,
    int? userPeriodLength,
    DateTime? lastLoggedStart,
  }) {
    return CycleEngine.predict(
      periodDays,
      date: date,
      userCycleLength: userCycleLength,
      userPeriodLength: userPeriodLength,
      lastLoggedStart: lastLoggedStart,
    );
  }

  void dispose() {}
}
