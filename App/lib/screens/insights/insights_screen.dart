import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/utils/cycle_engine.dart';
import '../../core/utils/date_formats.dart';
import '../../l10n/app_localizations.dart';
import '../../state/cycle_controller.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_card.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(cycleControllerProvider;
    final prediction = controller.prediction;
    final periodDays = controller.periodDays;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.insights)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          SectionHeader(
            title: l10n.stats,
            subtitle: l10n.estimated,
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.35,
            children: [
              StatCard(
                label: l10n.averageCycleLength,
                value: l10n.num(prediction.cycleLength),
                unit: l10n.daysUnit,
                icon: Icons.repeat_outlined,
                accent: AppColors.primary,
              ),
              StatCard(
                label: l10n.averagePeriodLength,
                value: l10n.num(prediction.periodLength),
                unit: l10n.daysUnit,
                icon: Icons.water_drop_outlined,
                accent: AppColors.dangerLight,
              ),
              StatCard(
                label: l10n.nextPeriod,
                value: l10n.num(prediction.daysUntilNextPeriod),
                unit: l10n.daysShort,
                icon: Icons.event_outlined,
                accent: AppColors.warning,
              ),
              StatCard(
                label: l10n.nextOvulation,
                value: l10n.monthYear(prediction.ovulationDay),
                icon: Icons.flare_outlined,
                accent: AppColors.secondary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          _TrendSection(periodDays: periodDays),
          const SizedBox(height: AppSpacing.xxl),
          _NextFertileCard(prediction: prediction),
          const SizedBox(height: AppSpacing.xxl),
          const _RedFlagsCard(),
        ],
      ),
    );
  }
}

class _TrendSection extends ConsumerWidget {
  const _TrendSection({required this.periodDays});

  final List<DateTime> periodDays;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final lengths = CycleEngine.observedCycleLengths(periodDays);
    final loggedStarts = CycleEngine.periodStarts(periodDays);

    if (loggedStarts.isEmpty) {
      return AppCard(
        child: Text(
          l10n.noDataYet,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: l10n.cycleTrend),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 160,
                width: double.infinity,
                child: CustomPaint(
                  painter: _CycleTrendPainter(
                    lengths: lengths,
                    label: l10n.cycleLengthLabel,
                    bn: l10n.isBn,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.loggedPeriodDays,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CycleTrendPainter extends CustomPainter {
  _CycleTrendPainter({
    required this.lengths,
    required this.label,
    required this.bn,
  });

  final List<int> lengths;
  final String label;
  final bool bn;

  @override
  void paint(Canvas canvas, Size size) {
    if (lengths.isEmpty) return;

    const axisColor = AppColors.borderDark;
    const barColor = AppColors.primary;
    const textColor = AppColors.textSecondaryDark;

    const padding = 8.0;
    final maxValue = lengths.reduce((a, b) => a > b ? a : b) + 2;
    final chartHeight = size.height - 36;
    final chartWidth = size.width - padding * 2;
    final slot = chartWidth / lengths.length;
    final barWidth = (slot * 0.55).clamp(8.0, 32.0);

    // Baseline
    canvas.drawLine(
      Offset(padding, size.height - 30),
      Offset(size.width - padding, size.height - 30),
      Paint()
        ..color = axisColor
        ..strokeWidth = 1,
    );

    for (var i = 0; i < lengths.length; i++) {
      final h = (lengths[i] / maxValue) * chartHeight;
      final left = padding + i * slot + (slot - barWidth) / 2;
      final top = size.height - 30 - h;

      final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, barWidth, h),
        const Radius.circular(3),
      );
      canvas.drawRRect(rrect, Paint()..color = barColor);

      // Value label on top of bar
      final tp = TextPainter(
        text: TextSpan(
          text: lengths[i].toString(),
          style: const TextStyle(
            fontSize: 10,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(left + barWidth / 2 - tp.width / 2, top - 14));
    }
  }

  @override
  bool shouldRepaint(covariant _CycleTrendPainter old) =>
      old.lengths != lengths;
}

class _NextFertileCard extends ConsumerWidget {
  const _NextFertileCard({required this.prediction});

  final CyclePrediction prediction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final fertileStart =
        prediction.ovulationDay.subtract(const Duration(days: 5));
    final fertileEnd = prediction.ovulationDay.add(const Duration(days: 1));

    return AppCard(
      borderColor: AppColors.secondary.withValues(alpha: 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.spa_outlined, size: 20, color: AppColors.secondary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.nextFertileWindow,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${DateFormats.dayMonth(fertileStart, bn: l10n.isBn)} — ${DateFormats.dayMonth(fertileEnd, bn: l10n.isBn)}',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${l10n.nextOvulation}: ${DateFormats.full(prediction.ovulationDay, bn: l10n.isBn)}',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _RedFlagsCard extends ConsumerWidget {
  const _RedFlagsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final flags = [
      l10n.redFlag1,
      l10n.redFlag2,
      l10n.redFlag3,
      l10n.redFlag4,
      l10n.redFlag5,
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.danger.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.panel),
        border: Border.all(color: AppColors.danger.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_outlined,
                  size: 20, color: AppColors.danger),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.redFlagsTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.danger,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.redFlagsDesc,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final flag in flags)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(Icons.circle, size: 6, color: AppColors.danger),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      flag,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark(theme)
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
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

  static bool isDark(ThemeData theme) => theme.brightness == Brightness.dark;
}
