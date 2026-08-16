import 'package:flutter_test/flutter_test.dart';
import 'package:shustho/core/utils/cycle_engine.dart';
import 'package:shustho/core/utils/date_utils.dart';

void main() {
  group('CycleEngine.periodStarts', () {
    test('returns first day of consecutive runs', () {
      final days = [
        DateTime(2026, 1, 1),
        DateTime(2026, 1, 2),
        DateTime(2026, 1, 3),
        DateTime(2026, 1, 28),
        DateTime(2026, 1, 29),
      ];
      final starts = CycleEngine.periodStarts(days);
      expect(starts, [DateTime(2026, 1, 1), DateTime(2026, 1, 28)]);
    });

    test('ignores unsorted input', () {
      final days = [
        DateTime(2026, 2, 1),
        DateTime(2026, 1, 1),
      ];
      final starts = CycleEngine.periodStarts(days);
      expect(starts, [DateTime(2026, 1, 1), DateTime(2026, 2, 1)]);
    });
  });

  group('CycleEngine.weightedCycleLength', () {
    test('falls back to default when no data', () {
      expect(CycleEngine.weightedCycleLength([]), 28);
    });

    test('uses user default when no observed cycles', () {
      expect(
        CycleEngine.weightedCycleLength([], userCycleLength: 32),
        32,
      );
    });

    test('weights recent observed cycle lengths', () {
      // Two observed cycles: 30 and 28 days. Weighted mean blends toward 28.
      final today = dateOnly(DateTime(2026, 1, 1));
      final days = [
        today.subtract(const Duration(days: 58)),
        today.subtract(const Duration(days: 28)),
      ];
      final length = CycleEngine.weightedCycleLength(days);
      expect(length, inInclusiveRange(28, 30));
    });
  });

  group('CycleEngine.regularityScore', () {
    test('is 0 for a single observed cycle', () {
      expect(CycleEngine.regularityScore([DateTime(2026, 1, 1)]), 0.0);
    });

    test('is small for regular cycles', () {
      final today = dateOnly(DateTime(2026, 3, 1));
      final days = [
        today.subtract(const Duration(days: 56)),
        today.subtract(const Duration(days: 28)),
      ];
      expect(CycleEngine.regularityScore(days), lessThan(0.15));
    });

    test('flags irregular cycles via isRegularCycle', () {
      final today = dateOnly(DateTime(2026, 1, 1));
      // Cycle lengths 28 and 50 days → irregular.
      final irregular = [
        today.subtract(const Duration(days: 78)),
        today.subtract(const Duration(days: 50)),
      ];
      expect(CycleEngine.isRegularCycle(irregular), isFalse);
    });
  });

  group('CycleEngine.averagePeriodLength', () {
    test('returns default when empty', () {
      expect(CycleEngine.averagePeriodLength([]), 5);
    });

    test('counts consecutive period days', () {
      final days = [
        DateTime(2026, 1, 1),
        DateTime(2026, 1, 2),
        DateTime(2026, 1, 3),
      ];
      expect(CycleEngine.averagePeriodLength(days), 3);
    });
  });

  group('CycleEngine.predict', () {
    test('predicts period phase for a logged start', () {
      final today = DateTime(2026, 1, 2);
      final prediction = CycleEngine.predict(
        [DateTime(2026, 1, 1)],
        date: today,
      );
      expect(prediction.inPeriod, isTrue);
      expect(prediction.currentPeriodDay, 2);
    });

    test('computes ovulation 14 days before next period', () {
      final today = DateTime(2026, 1, 1);
      final prediction = CycleEngine.predict(
        [DateTime(2025, 12, 1)],
        date: today,
      );
      // Next period start = 2025-12-01 + 28 = 2025-12-29.
      // Ovulation = 2025-12-29 - 14 = 2025-12-15.
      expect(prediction.ovulationDay, DateTime(2025, 12, 15));
    });

    test('phaseForDay returns fertile window days', () {
      final today = DateTime(2025, 12, 12);
      final prediction = CycleEngine.predict(
        [DateTime(2025, 12, 1)],
        date: today,
      );
      // Ovulation 2025-12-15, fertile 2025-12-10..2025-12-16.
      expect(
        CycleEngine.phaseForDay(DateTime(2025, 12, 13), prediction),
        CyclePhase.fertileWindow,
      );
      expect(
        CycleEngine.phaseForDay(DateTime(2025, 12, 15), prediction),
        CyclePhase.ovulation,
      );
      expect(
        CycleEngine.phaseForDay(DateTime(2025, 12, 20), prediction),
        CyclePhase.luteal,
      );
    });

    test('marks predicted period days as period phase', () {
      final today = DateTime(2025, 12, 12);
      final prediction = CycleEngine.predict(
        [DateTime(2025, 12, 1)],
        date: today,
      );
      // Predicted period starts 2025-12-29.
      expect(
        CycleEngine.phaseForDay(DateTime(2025, 12, 29), prediction),
        CyclePhase.period,
      );
      expect(
        CycleEngine.phaseForDay(DateTime(2026, 1, 1), prediction),
        CyclePhase.period,
      );
    });
  });

  group('date utils', () {
    test('daysBetween counts whole days', () {
      expect(
        daysBetween(DateTime(2026, 1, 1), DateTime(2026, 1, 10)),
        9,
      );
    });

    test('addMonths handles year rollover', () {
      expect(addMonths(DateTime(2026, 12, 15), 1), DateTime(2027, 1, 15));
    });

    test('addMonths clamps day overflow', () {
      expect(addMonths(DateTime(2026, 1, 31), 1), DateTime(2026, 2, 28));
    });
  });
}
