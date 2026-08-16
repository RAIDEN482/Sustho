import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/utils/cycle_engine.dart';
import '../../core/utils/date_formats.dart';
import '../../core/utils/date_utils.dart';
import '../../l10n/app_localizations.dart';
import '../../models/enums.dart';
import '../../state/cycle_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';
import '../log/log_period_screen.dart';
import '../log/log_symptoms_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    _month = startOfMonth(today());
  }

  void _shift(int months) {
    setState(() => _month = addMonths(_month, months));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = context.watch<CycleController>();
    final prediction = controller.prediction;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.calendar)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _MonthHeader(
            label: l10n.monthYear(_month),
            onPrev: () => _shift(-1),
            onNext: () => _shift(1),
          ),
          const SizedBox(height: AppSpacing.md),
          _WeekdayHeader(l10n: l10n),
          _MonthGrid(
            month: _month,
            controller: controller,
            prediction: prediction,
            onDayTap: (day) => _showDaySheet(context, day),
          ),
          const SizedBox(height: AppSpacing.lg),
          const _Legend(),
          const SizedBox(height: AppSpacing.lg),
          _CycleHistory(controller: controller),
        ],
      ),
    );
  }

  void _showDaySheet(BuildContext context, DateTime day) {
    final controller = context.read<CycleController>();
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => _DaySheet(
        day: day,
        controller: controller,
        onLogPeriod: () async {
          Navigator.of(context).pop();
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => LogPeriodScreen(initialDate: day),
            ),
          );
        },
        onLogSymptoms: () async {
          Navigator.of(context).pop();
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => LogSymptomsScreen(initialDate: day),
            ),
          );
        },
      ),
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({required this.label, required this.onPrev, required this.onNext});

  final String label;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        IconButton(
          onPressed: onPrev,
          icon: const Icon(Icons.chevron_left, size: 24),
        ),
        Expanded(
          child: Center(
            child: Text(label, style: theme.textTheme.titleLarge),
          ),
        ),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right, size: 24),
        ),
      ],
    );
  }
}

class _WeekdayHeader extends StatelessWidget {
  const _WeekdayHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Week starts on Sunday (index 6 = Sunday in Dart).
    const order = [6, 0, 1, 2, 3, 4, 5];
    return Row(
      children: [
        for (final idx in order)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Text(
                  _shortWeekday(DateTime(2026, 1, 4 + idx), l10n),
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ),
          ),
      ],
    );
  }

  static String _shortWeekday(DateTime sample, AppLocalizations l10n) {
    return DateFormats.weekdayShort(sample, bn: l10n.isBn);
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.controller,
    required this.prediction,
    required this.onDayTap,
  });

  final DateTime month;
  final CycleController controller;
  final CyclePrediction prediction;
  final ValueChanged<DateTime> onDayTap;

  @override
  Widget build(BuildContext context) {
    final first = DateTime(month.year, month.month, 1);
    final totalDays = daysInMonth(month);
    final lead = first.weekday % 7; // Sunday-based offset
    final cells = lead + totalDays;

    final predictedPeriodDays = <DateTime>{};
    for (final s in prediction.predictedStarts) {
      for (var i = 0; i < prediction.periodLength; i++) {
        predictedPeriodDays.add(s.add(Duration(days: i)));
      }
    }

    final List<Widget> children = [];
    for (var i = 0; i < cells; i++) {
      final dayIndex = i - lead + 1;
      if (dayIndex < 1 || dayIndex > totalDays) {
        children.add(const SizedBox.shrink());
        continue;
      }
      final day = DateTime(month.year, month.month, dayIndex);
      final entry = controller.entryFor(day);
      final isLogged = entry != null && entry.isPeriodDay;
      final phase = CycleEngine.phaseForDay(day, prediction);
      children.add(
        _DayCell(
          day: day,
          phase: phase,
          isLoggedPeriod: isLogged,
          isPredictedPeriod:
              !isLogged && predictedPeriodDays.contains(day),
          isLogged: entry != null && (entry.isPeriodDay || entry.symptoms.isNotEmpty),
          isToday: day == today(),
          onTap: () => onDayTap(day),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.xs,
      crossAxisSpacing: AppSpacing.xs,
      children: children,
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.phase,
    required this.isLoggedPeriod,
    required this.isPredictedPeriod,
    required this.isLogged,
    required this.isToday,
    required this.onTap,
  });

  final DateTime day;
  final CyclePhase? phase;
  final bool isLoggedPeriod;
  final bool isPredictedPeriod;
  final bool isLogged;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color? fg;
    Color? dot;

    if (isLoggedPeriod) {
      // Solid pink logged circle with white text.
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.control),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppRadii.control),
            border: isToday
                ? Border.all(color: AppColors.secondary, width: 2)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormats.compactDay(day, bn: l10n.isBn),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      );
    }

    switch (phase) {
      case CyclePhase.fertileWindow:
        fg = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
        dot = AppColors.secondary;
      case CyclePhase.ovulation:
        fg = AppColors.success;
        dot = AppColors.success;
      case CyclePhase.follicular:
      case CyclePhase.luteal:
      case CyclePhase.period:
      case CyclePhase.unknown:
      case null:
        fg = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    }

    if (isPredictedPeriod) {
      // Dashed blue predicted period circle.
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.control),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.control),
            border: Border.all(
              color: AppColors.secondary.withValues(alpha: 0.7),
              width: 1.4,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormats.compactDay(day, bn: l10n.isBn),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Color? bg;
    if (phase == CyclePhase.fertileWindow) {
      bg = AppColors.secondary.withValues(alpha: 0.14);
    } else if (phase == CyclePhase.ovulation) {
      bg = AppColors.success.withValues(alpha: 0.14);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.control),
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadii.control),
          border: isToday
              ? Border.all(color: AppColors.primary, width: 1.6)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormats.compactDay(day, bn: l10n.isBn),
              style: TextStyle(
                fontSize: 14,
                fontWeight: isToday ? FontWeight.w500 : FontWeight.w400,
                color: isToday ? AppColors.primary : fg,
              ),
            ),
            const SizedBox(height: 2),
            if (dot != null)
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
              )
            else
              const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.sm,
      children: [
        _LegendItem(color: AppColors.primary, label: l10n.legendPeriod),
        _LegendItem(
          color: AppColors.primary.withValues(alpha: 0.4),
          label: l10n.legendPredicted,
        ),
        _LegendItem(
          color: AppColors.secondary.withValues(alpha: 0.5),
          label: l10n.legendFertile,
        ),
        _LegendItem(color: AppColors.secondary, label: l10n.legendOvulation),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _DaySheet extends StatelessWidget {
  const _DaySheet({
    required this.day,
    required this.controller,
    required this.onLogPeriod,
    required this.onLogSymptoms,
  });

  final DateTime day;
  final CycleController controller;
  final VoidCallback onLogPeriod;
  final VoidCallback onLogSymptoms;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final entry = controller.entryFor(day);
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.dayDetails, style: theme.textTheme.titleLarge),
            const SizedBox(height: 2),
            Text(
              l10n.fullDate(day),
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (entry != null) ...[
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (entry.isPeriodDay)
                      Text(
                        '${l10n.loggedFlow} ${_flowLabel(entry.flow, l10n)}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    if (entry.symptoms.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.xs),
                        child: Text(
                          '${l10n.loggedSymptoms} ${entry.symptoms.map((s) => _symptomLabel(s, l10n)).join(', ')}',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                    if (entry.moods.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.xs),
                        child: Text(
                          entry.moods.map((m) => _moodLabel(m, l10n)).join(', '),
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    if (entry.notes.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.xs),
                        child: Text(entry.notes, style: theme.textTheme.bodySmall),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: l10n.logPeriod,
                    style: AppButtonStyle.primary,
                    icon: Icons.water_drop_outlined,
                    expanded: true,
                    onPressed: onLogPeriod,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: l10n.logSymptoms,
                    style: AppButtonStyle.secondary,
                    icon: Icons.mood_outlined,
                    expanded: true,
                    onPressed: onLogSymptoms,
                  ),
                ),
              ],
            ),
          ],
        ),
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

  static String _moodLabel(Mood mood, AppLocalizations l10n) {
    switch (mood) {
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
  }

  static String _symptomLabel(SymptomType symptom, AppLocalizations l10n) {
    switch (symptom) {
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
  }
}

class _CycleHistory extends StatelessWidget {
  const _CycleHistory({required this.controller});

  final CycleController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final starts = CycleEngine.periodStarts(controller.periodDays);
    if (starts.length < 2) {
      return AppCard(
        child: Text(
          l10n.noDataYet,
          style: theme.textTheme.bodyMedium,
        ),
      );
    }

    final lengths = <int>[];
    for (var i = 1; i < starts.length; i++) {
      lengths.add(daysBetween(starts[i - 1], starts[i]));
    }
    final mean = lengths.fold<int>(0, (a, b) => a + b) / lengths.length;
    final variance = lengths.fold<double>(
          0,
          (acc, v) => acc + (v - mean) * (v - mean),
        ) /
        lengths.length;
    final cv = (variance / (mean * mean)).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: l10n.cycleHistory),
        const SizedBox(height: AppSpacing.md),
        for (var i = lengths.length - 1; i >= 0; i--)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: AppCard(
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadii.control),
                    ),
                    child: Text(
                      l10n.num(i + 1),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.cycleNo(i + 1),
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${l10n.startDate}: ${l10n.fullDate(starts[i])}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${l10n.lengthLabel}: ${l10n.num(lengths[i])} ${l10n.daysUnit}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: _lengthColor(cv),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _regularityLabel(cv, l10n),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  static Color _lengthColor(double cv) {
    if (cv <= 0.15) return AppColors.success;
    if (cv <= 0.25) return AppColors.warning;
    return AppColors.danger;
  }

  static String _regularityLabel(double cv, AppLocalizations l10n) {
    if (cv <= 0.15) return l10n.regular;
    if (cv <= 0.25) return l10n.irregular;
    return l10n.pcosHint;
  }
}
