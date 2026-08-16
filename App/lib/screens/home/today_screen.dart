import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/cycle_engine.dart';
import '../../core/utils/date_utils.dart';
import '../../l10n/app_localizations.dart';
import '../../models/enums.dart';
import '../../state/cycle_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';
import '../log/log_period_screen.dart';
import '../log/log_symptoms_screen.dart';
import 'phase_info.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(cycleControllerProvider);
    final prediction = controller.prediction;
    final todayDate = today();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              child: const Icon(
                Icons.favorite_outline,
                size: 18,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Text('Shustho'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            child: Center(
              child: Text(
                l10n.fullDate(todayDate),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            l10n.welcome,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.xxl),
          _DayOfPeriodCard(controller: controller),
          const SizedBox(height: AppSpacing.xxl),
          _PhaseCard(prediction: prediction),
          const SizedBox(height: AppSpacing.xxl),
          _PredictionCard(prediction: prediction),
          const SizedBox(height: AppSpacing.xxl),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: l10n.logPeriod,
                  icon: Icons.water_drop_outlined,
                  style: AppButtonStyle.primary,
                  expanded: true,
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LogPeriodScreen(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  label: l10n.logSymptoms,
                  icon: Icons.mood_outlined,
                  style: AppButtonStyle.secondary,
                  expanded: true,
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LogSymptomsScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          _TodayEntry(controller: controller, today: todayDate),
          const SizedBox(height: AppSpacing.xxl),
          _HealthTipCard(l10n: l10n),
        ],
      ),
    );
  }
}

class _DayOfPeriodCard extends StatelessWidget {
  const _DayOfPeriodCard({required this.controller});

  final CycleController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final prediction = controller.prediction;
    final day = controller.currentDayOfPeriod;

    return AppCard(
      borderColor: AppColors.primary.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (day != null) ...[
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppRadii.control),
                  ),
                  child: Text(
                    l10n.num(day),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.dayXofPeriod(day),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.nextPeriodStartsIn(l10n.num(prediction.daysUntilNextPeriod)),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ] else ...[
            Text(
              l10n.notInPeriod,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 2),
            Text(
              l10n.startPeriodWhenItBegins,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: l10n.startPeriod,
                  icon: Icons.water_drop_outlined,
                  style: AppButtonStyle.primary,
                  expanded: true,
                  onPressed: () async {
                    await controller.logPeriod(DateTime.now());
                  },
                ),
              ),
              if (day != null) ...[
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: l10n.endPeriod,
                    icon: Icons.check_outlined,
                    style: AppButtonStyle.secondary,
                    expanded: true,
                    onPressed: () async {
                      await controller.markNotPeriod(DateTime.now());
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _PredictionCard extends StatelessWidget {
  const _PredictionCard({required this.prediction});

  final CyclePrediction prediction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final String regularity;
    if (prediction.observedStarts.length < 2) {
      regularity = l10n.regularityUnknown;
    } else if (prediction.isRegular) {
      regularity = l10n.regular;
    } else if (prediction.regularityScore > 0.25) {
      regularity = l10n.pcosPattern;
    } else {
      regularity = l10n.irregular;
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: l10n.predictions),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _PredictionStat(
                label: l10n.expectedRange,
                value: '${l10n.monthYear(prediction.rangeStart)}\n${l10n.monthYear(prediction.rangeEnd)}',
                valueLines: 2,
              ),
              const SizedBox(width: AppSpacing.md),
              _PredictionStat(
                label: l10n.confidenceLabel,
                value: l10n.confidence(prediction.confidence),
              ),
              const SizedBox(width: AppSpacing.md),
              _PredictionStat(
                label: l10n.regularityLabel,
                value: regularity,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.nextPeriodIn,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                l10n.nextPeriodStartsIn(l10n.num(prediction.daysUntilNextPeriod)),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          LinearProgressIndicator(
            value: prediction.confidence / 100,
            minHeight: 6,
            borderRadius: BorderRadius.circular(AppRadii.pill),
            backgroundColor: isDark
                ? AppColors.borderDark
                : AppColors.borderLight,
            valueColor: AlwaysStoppedAnimation(
              prediction.confidence >= 70
                  ? AppColors.success
                  : (prediction.confidence >= 50
                      ? AppColors.warning
                      : AppColors.danger),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.improvesWithLogging,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _PredictionStat extends StatelessWidget {
  const _PredictionStat({
    required this.label,
    required this.value,
    this.valueLines = 1,
  });

  final String label;
  final String value;
  final int valueLines;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark ? AppColors.bgDarkElevated : AppColors.bgLightElevated,
          borderRadius: BorderRadius.circular(AppRadii.control),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(
              value,
              maxLines: valueLines,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  const _PhaseCard({required this.prediction});

  final CyclePrediction prediction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final info = phaseInfo(prediction.phase, l10n);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final phaseColor = info.color;

    final String headline;
    if (prediction.inPeriod) {
      final day = prediction.currentPeriodDay ?? 1;
      headline = l10n.periodDayX(day);
    } else if (prediction.phase == CyclePhase.ovulation) {
      headline = l10n.ovulation;
    } else if (prediction.phase == CyclePhase.fertileWindow) {
      headline = l10n.fertileWindow;
    } else if (prediction.phase == CyclePhase.unknown) {
      headline = l10n.phaseDescription;
    } else {
      headline = info.label;
    }

    final String sub;
    if (prediction.inPeriod) {
      sub = '${l10n.nextPeriod}: ${l10n.monthYear(prediction.nextPeriodStart)}';
    } else {
      final days = prediction.daysUntilNextPeriod;
      sub = days == 0
          ? l10n.periodStartsToday
          : l10n.periodStartsInDays(days);
    }

    return AnimatedContainer(
      duration: AppDurations.normal,
      curve: AppCurves.entrance,
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDarkElevated : AppColors.bgLightElevated,
        borderRadius: BorderRadius.circular(AppRadii.panel),
        border: Border.all(
          color: phaseColor.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: phaseColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppRadii.control),
                ),
                child: Icon(info.icon, size: 24, color: phaseColor),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.phaseTitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      headline,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            info.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadii.control),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.schedule_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    sub,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayEntry extends StatelessWidget {
  const _TodayEntry({required this.controller, required this.today});

  final CycleController controller;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entry = controller.entryFor(today);

    if (entry == null) {
      return AppCard(
        child: Row(
          children: [
            const Icon(
              Icons.assignment_outlined,
              size: 24,
              color: AppColors.textTertiaryDark,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                l10n.noEntryForDay,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }

    final moods = entry.moods;
    final symptoms = entry.symptoms;
    final hasContent =
        entry.isPeriodDay || moods.isNotEmpty || symptoms.isNotEmpty;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: l10n.dayDetails),
          if (entry.isPeriodDay)
            _InfoRow(
              icon: Icons.water_drop_outlined,
              label: '${l10n.loggedFlow} ${_flowLabel(entry.flow, l10n)}',
              color: AppColors.primary,
            ),
          if (moods.isNotEmpty)
            _InfoRow(
              icon: Icons.mood_outlined,
              label: moods.map(_moodLabel(l10n)).join(', '),
              color: AppColors.secondary,
            ),
          if (symptoms.isNotEmpty)
            _InfoRow(
              icon: Icons.healing_outlined,
              label: symptoms.map(_symptomLabel(l10n)).join(', '),
              color: AppColors.warning,
            ),
          if (entry.painLevel > 0)
            _InfoRow(
              icon: Icons.bolt_outlined,
              label: '${l10n.painScale}: ${l10n.num(entry.painLevel)}/10',
              color: entry.painLevel >= 7
                  ? AppColors.danger
                  : (entry.painLevel >= 4
                      ? AppColors.warning
                      : AppColors.success),
            ),
          if (entry.notes.isNotEmpty)
            _InfoRow(
              icon: Icons.notes_outlined,
              label: entry.notes,
              color: AppColors.textTertiaryDark,
            ),
          if (!hasContent)
            Text(
              l10n.noEntryForDay,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }

  static String _flowLabel(FlowLevel flow, AppLocalizations l10n) {
    switch (flow) {
      case FlowLevel.spotting:
        return l10n.spotting;
      case FlowLevel.light:
        return l10n.flowLight;
      case FlowLevel.medium:
        return l10n.flowMedium;
      case FlowLevel.heavy:
        return l10n.flowHeavy;
      case FlowLevel.none:
        return l10n.flowNone;
    }
  }

  static String Function(Mood) _moodLabel(AppLocalizations l10n) {
    return (m) {
      switch (m) {
        case Mood.happy:
          return l10n.moodHappy;
        case Mood.calm:
          return l10n.moodCalm;
        case Mood.anxious:
          return l10n.moodAnxious;
        case Mood.sad:
          return l10n.moodSad;
        case Mood.irritable:
          return l10n.moodIrritable;
        case Mood.energetic:
          return l10n.moodEnergetic;
        case Mood.tired:
          return l10n.moodTired;
        case Mood.angry:
          return l10n.moodAngry;
      }
    };
  }

  static String Function(SymptomType) _symptomLabel(AppLocalizations l10n) {
    return (s) {
      switch (s) {
        case SymptomType.cramps:
          return l10n.symCramps;
        case SymptomType.headache:
          return l10n.symHeadache;
        case SymptomType.backache:
          return l10n.symBackache;
        case SymptomType.bloating:
          return l10n.symBloating;
        case SymptomType.breastTenderness:
          return l10n.symBreastTenderness;
        case SymptomType.fatigue:
          return l10n.symFatigue;
        case SymptomType.nausea:
          return l10n.symNausea;
        case SymptomType.acne:
          return l10n.symAcne;
        case SymptomType.craving:
          return l10n.symCraving;
        case SymptomType.insomnia:
          return l10n.symInsomnia;
        case SymptomType.moodSwings:
          return l10n.symMoodSwings;
        case SymptomType.anxiety:
          return l10n.symAnxiety;
      }
    };
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs + 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _HealthTipCard extends StatelessWidget {
  const _HealthTipCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppCard(
      borderColor: AppColors.success.withValues(alpha: 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline,
                  size: 20, color: AppColors.success),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.healthTips,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.healthTip1,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
          ),
        ],
      ),
    );
  }
}
