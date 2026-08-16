import 'dart:math' as math;

import 'date_utils.dart';

/// Phase of the menstrual cycle for a given day.
enum CyclePhase {
  period,
  fertileWindow,
  ovulation,
  follicular,
  luteal,
  unknown,
}

/// Result of predicting the cycle around a reference date.
class CyclePrediction {
  const CyclePrediction({
    required this.today,
    required this.cycleLength,
    required this.periodLength,
    required this.observedStarts,
    required this.predictedStarts,
    required this.phase,
    required this.phaseStart,
    required this.phaseEnd,
    required this.nextPeriodStart,
    required this.ovulationDay,
    required this.confidence,
    required this.isRegular,
    required this.regularityScore,
    required this.rangeStart,
    required this.rangeEnd,
  });

  final DateTime today;

  /// Average cycle length in days (weighted, falls back to defaults).
  final int cycleLength;

  /// Average period length in days (falls back to 5).
  final int periodLength;

  /// Period start days that were actually logged.
  final List<DateTime> observedStarts;

  /// Predicted period start days (may overlap observed starts in the future).
  final List<DateTime> predictedStarts;

  final CyclePhase phase;
  final DateTime phaseStart;
  final DateTime phaseEnd;
  final DateTime nextPeriodStart;
  final DateTime ovulationDay;

  /// Confidence percentage for the next-period prediction (0-100).
  final int confidence;

  /// True when the observed cycle lengths are sufficiently regular.
  final bool isRegular;

  /// Coefficient of variation of the observed cycle lengths (0 = perfectly
  /// regular). Used to flag irregular / PCOS-like patterns.
  final double regularityScore;

  /// Expected window in which the next period may start.
  final DateTime rangeStart;
  final DateTime rangeEnd;

  bool get inPeriod => phase == CyclePhase.period;
  bool get inFertileWindow =>
      phase == CyclePhase.fertileWindow || phase == CyclePhase.ovulation;

  /// Days until the next period start (0 if today is a period day).
  int get daysUntilNextPeriod =>
      daysBetween(today, nextPeriodStart).clamp(0, 9999);

  /// Day index (1-based) of the current period if today is a period day.
  int? get currentPeriodDay {
    if (!inPeriod) return null;
    return daysBetween(phaseStart, today) + 1;
  }
}

/// Pure on-device cycle prediction engine. All dates are date-only.
///
/// The model mirrors a lightweight on-device ML approach:
///   * uses the most recent 6 observed cycle lengths, weighted toward recent
///     cycles,
///   * estimates regularity from the coefficient of variation,
///   * outputs a single expected date (±3 days) for regular cycles and a wider
///     probability range for irregular / PCOS-like cycles,
///   * reports a confidence percentage.
class CycleEngine {
  CycleEngine._();

  static const int defaultCycleLength = 28;
  static const int defaultPeriodLength = 5;
  static const int ovulationOffset = 14;

  /// Weights applied to the last observed cycle lengths (newest first).
  static const List<double> _recentWeights = [
    0.31, 0.22, 0.17, 0.13, 0.10, 0.07,
  ];

  /// Groups consecutive [DateTime]s (assumed sorted) into runs and returns the
  /// first day of each run.
  static List<DateTime> periodStarts(List<DateTime> periodDays) {
    final days = periodDays.map(dateOnly).toSet().toList()..sort();
    final starts = <DateTime>[];
    for (final d in days) {
      final prev = d.subtract(const Duration(days: 1));
      if (!days.contains(prev)) {
        starts.add(d);
      }
    }
    return starts;
  }

  /// Observed cycle lengths (in days) between consecutive period starts.
  static List<int> observedCycleLengths(List<DateTime> periodDays) {
    final starts = periodStarts(periodDays);
    final lengths = <int>[];
    for (var i = 1; i < starts.length; i++) {
      lengths.add(daysBetween(starts[i - 1], starts[i]));
    }
    return lengths;
  }

  /// Weighted average cycle length using the most recent [maxCycles] observed
  /// cycles. Falls back to the user default (or 28) when no data exists.
  static int weightedCycleLength(
    List<DateTime> periodDays, {
    int? userCycleLength,
    int maxCycles = 6,
  }) {
    final observed = observedCycleLengths(periodDays);
    if (observed.isEmpty) {
      return userCycleLength ?? defaultCycleLength;
    }
    final recent = observed.length <= maxCycles
        ? observed
        : observed.sublist(observed.length - maxCycles);
    final weights = _recentWeights.take(recent.length).toList();
    final totalWeight = weights.fold<double>(0, (a, b) => a + b);
    var weighted = 0.0;
    for (var i = 0; i < recent.length; i++) {
      weighted += recent[i] * (weights[i] / totalWeight);
    }
    // Blend toward the user default when only one or two cycles are observed.
    if (recent.length <= 2) {
      final base = userCycleLength ?? defaultCycleLength;
      final alpha = recent.length == 1 ? 0.6 : 0.75;
      weighted = weighted * alpha + base * (1 - alpha);
    }
    return weighted.round().clamp(15, 60);
  }

  /// Coefficient of variation of the recent observed cycle lengths.
  static double regularityScore(List<DateTime> periodDays, {int maxCycles = 6}) {
    final observed = observedCycleLengths(periodDays);
    if (observed.length < 2) return 0.0;
    final recent = observed.length <= maxCycles
        ? observed
        : observed.sublist(observed.length - maxCycles);
    final mean = recent.fold<double>(0, (a, b) => a + b) / recent.length;
    if (mean == 0) return 0.0;
    final variance = recent.fold<double>(
          0,
          (acc, v) => acc + math.pow(v - mean, 2).toDouble(),
        ) /
        recent.length;
    return math.sqrt(variance) / mean;
  }

  static bool isRegularCycle(List<DateTime> periodDays, {int maxCycles = 6}) {
    final cv = regularityScore(periodDays, maxCycles: maxCycles);
    if (periodDays.isEmpty) return true;
    return cv <= 0.15;
  }

  /// Average period (bleeding) length in days.
  static int averagePeriodLength(List<DateTime> periodDays) {
    if (periodDays.isEmpty) return defaultPeriodLength;
    final days = periodDays.map(dateOnly).toSet().toList()..sort();
    final runs = <List<DateTime>>[];
    for (final d in days) {
      final prev = d.subtract(const Duration(days: 1));
      if (days.contains(prev)) {
        runs.last.add(d);
      } else {
        runs.add([d]);
      }
    }
    final rounded = (runs.fold<int>(0, (sum, r) => sum + r.length) / runs.length)
        .round();
    return rounded.clamp(1, 14);
  }

  /// Confidence (0-100) for the next-period prediction.
  static int confidenceFor(
    List<DateTime> periodDays, {
    required double regularityScore,
    required int cycleLength,
    int? userCycleLength,
  }) {
    final n = observedCycleLengths(periodDays).length;
    if (periodDays.isEmpty && userCycleLength == null) return 40;
    if (periodDays.isEmpty) return 55;

    var base = 55 + math.min(n, 6) * 5; // 60..85
    if (regularityScore <= 0.10) {
      base += 8;
    } else if (regularityScore <= 0.15) {
      base += 4;
    } else if (regularityScore <= 0.25) {
      base -= 6;
    } else {
      base -= 12;
    }
    if (n < 3) base -= 5;
    return base.clamp(35, 95);
  }

  /// Predicts period start days: observed starts plus enough future starts to
  /// cover the next ~180 days.
  static List<DateTime> predictedStarts(
    List<DateTime> periodDays, {
    int? userCycleLength,
    DateTime? lastLoggedStart,
  }) {
    final cycleLength =
        weightedCycleLength(periodDays, userCycleLength: userCycleLength);
    final starts = periodStarts(periodDays).toList();
    var anchor = starts.isEmpty
        ? (lastLoggedStart ?? today())
        : starts.last;

    // If the last observed start is too far in the past relative to today,
    // keep predicting forward from today's anchor window.
    final now = today();
    while (daysBetween(anchor, now) >= cycleLength) {
      anchor = anchor.add(Duration(days: cycleLength));
    }

    final result = <DateTime>[];
    var cursor = anchor;
    var guard = 0;
    while (result.length < 12 && guard < 400) {
      guard++;
      if (!result.contains(cursor)) {
        result.add(cursor);
      }
      cursor = cursor.add(Duration(days: cycleLength));
    }
    return result;
  }

  /// Builds the full prediction for [date] (defaults to today).
  static CyclePrediction predict(
    List<DateTime> periodDays, {
    DateTime? date,
    int? userCycleLength,
    int? userPeriodLength,
    DateTime? lastLoggedStart,
  }) {
    final day = dateOnly(date ?? today());
    final cycleLength =
        weightedCycleLength(periodDays, userCycleLength: userCycleLength);
    final periodLength =
        (userPeriodLength ?? averagePeriodLength(periodDays)).clamp(1, 14);
    final cv = regularityScore(periodDays);
    final isRegular = isRegularCycle(periodDays);
    final confidence = confidenceFor(
      periodDays,
      regularityScore: cv,
      cycleLength: cycleLength,
      userCycleLength: userCycleLength,
    );

    final hasAnyData = periodDays.isNotEmpty || lastLoggedStart != null;
    final starts = predictedStarts(
      periodDays,
      userCycleLength: userCycleLength,
      lastLoggedStart: lastLoggedStart,
    );

    // No data at all: report an unknown phase with default-cycle estimates.
    if (!hasAnyData) {
      final nextStart = day.add(Duration(days: cycleLength));
      return CyclePrediction(
        today: day,
        cycleLength: cycleLength,
        periodLength: periodLength,
        observedStarts: const [],
        predictedStarts: const [],
        phase: CyclePhase.unknown,
        phaseStart: day,
        phaseEnd: day,
        nextPeriodStart: nextStart,
        ovulationDay: nextStart.subtract(const Duration(days: ovulationOffset)),
        confidence: confidence,
        isRegular: isRegular,
        regularityScore: cv,
        rangeStart: nextStart.subtract(const Duration(days: 3)),
        rangeEnd: nextStart.add(const Duration(days: 3)),
      );
    }

    // Determine the current cycle window (the latest start <= day + slack).
    final currentStart = starts.lastWhere(
      (s) => !s.isAfter(day),
      orElse: () => starts.isEmpty ? day : starts.first,
    );

    final ovulation = currentStart.add(Duration(days: cycleLength - ovulationOffset));
    final fertileStart = ovulation.subtract(const Duration(days: 5));
    final fertileEnd = ovulation.add(const Duration(days: 1));
    final periodEnd = currentStart.add(Duration(days: periodLength - 1));
    final nextStart = starts.isEmpty
        ? day.add(Duration(days: cycleLength))
        : starts.firstWhere(
            (s) => s.isAfter(day),
            orElse: () => day.add(Duration(days: cycleLength)),
          );

    // Expected range for the next period start.
    final int rangeHalfWidth;
    if (isRegular) {
      rangeHalfWidth = 3;
    } else if (cv <= 0.25) {
      rangeHalfWidth = (cv * cycleLength).round().clamp(5, 8);
    } else {
      rangeHalfWidth = (cv * cycleLength).round().clamp(8, 12);
    }
    final rangeStart = nextStart.subtract(Duration(days: rangeHalfWidth));
    final rangeEnd = nextStart.add(Duration(days: rangeHalfWidth));

    late final CyclePhase phase;
    late final DateTime phaseStart;
    late final DateTime phaseEnd;

    if (!day.isBefore(currentStart) && !day.isAfter(periodEnd)) {
      phase = CyclePhase.period;
      phaseStart = currentStart;
      phaseEnd = periodEnd;
    } else if (day == ovulation) {
      phase = CyclePhase.ovulation;
      phaseStart = ovulation;
      phaseEnd = ovulation;
    } else if (!day.isBefore(fertileStart) && !day.isAfter(fertileEnd)) {
      phase = CyclePhase.fertileWindow;
      phaseStart = fertileStart;
      phaseEnd = fertileEnd;
    } else if (day.isBefore(ovulation)) {
      phase = CyclePhase.follicular;
      phaseStart = currentStart.add(Duration(days: periodLength));
      phaseEnd = fertileStart.subtract(const Duration(days: 1));
    } else {
      phase = CyclePhase.luteal;
      phaseStart = fertileEnd.add(const Duration(days: 1));
      phaseEnd = nextStart.subtract(const Duration(days: 1));
    }

    return CyclePrediction(
      today: day,
      cycleLength: cycleLength,
      periodLength: periodLength,
      observedStarts: periodStarts(periodDays),
      predictedStarts: starts,
      phase: phase,
      phaseStart: phaseStart,
      phaseEnd: phaseEnd,
      nextPeriodStart: nextStart,
      ovulationDay: ovulation,
      confidence: confidence,
      isRegular: isRegular,
      regularityScore: cv,
      rangeStart: rangeStart,
      rangeEnd: rangeEnd,
    );
  }

  /// Map from a date to the phase it falls into, using [prediction] data for
  /// the surrounding window. Used to color calendar days.
  static CyclePhase? phaseForDay(
    DateTime day,
    CyclePrediction prediction,
  ) {
    final d = dateOnly(day);
    final starts = prediction.predictedStarts;
    // A day belongs to a cycle window if it is within [start, start + periodLength).
    for (final s in starts) {
      if (!d.isBefore(s) &&
          d.isBefore(s.add(Duration(days: prediction.periodLength)))) {
        return CyclePhase.period;
      }
    }
    // Ovulation / fertile window for each predicted start.
    for (final s in starts) {
      final ovulation =
          s.add(Duration(days: prediction.cycleLength - ovulationOffset));
      if (d == ovulation) return CyclePhase.ovulation;
      final fStart = ovulation.subtract(const Duration(days: 5));
      final fEnd = ovulation.add(const Duration(days: 1));
      if (!d.isBefore(fStart) && !d.isAfter(fEnd)) {
        return CyclePhase.fertileWindow;
      }
    }
    return null;
  }

  /// Predicted period start days within the next [daysAhead] days from [from].
  static List<DateTime> upcomingStarts(
    CyclePrediction prediction, {
    int daysAhead = 60,
  }) {
    final end = today().add(Duration(days: daysAhead));
    return prediction.predictedStarts
        .where((s) => !s.isBefore(today()) && !s.isAfter(end))
        .toList();
  }
}
