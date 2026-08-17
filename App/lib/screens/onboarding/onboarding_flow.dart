import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/utils/date_formats.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';

class OnboardingFlow extends ConsumerStatefulWidget {
  const OnboardingFlow({super.key});

  @override
  ConsumerState<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  int _step = 0;
  late DateTime _lastPeriodStart;
  int _cycleLength = 28;
  int _periodLength = 5;
  String _guardianName = '';
  String _guardianRelation = '';
  bool _guardianEnabled = false;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _lastPeriodStart = DateTime.now();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int step) {
    if (step < 0 || step > 2) return;
    _pageController.animateToPage(
      step,
      duration: AppDurations.normal,
      curve: AppCurves.standard,
    );
    setState(() => _step = step);
  }

  Future<void> _pickLastPeriod() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _lastPeriodStart,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: DateTime(now.year, now.month, now.day),
    );
    if (picked != null) {
      setState(() => _lastPeriodStart = picked);
    }
  }

  Future<void> _finish() async {
    final appState = ref.read(appStateProvider);
    await appState.completeOnboarding(
      lastPeriodStart: _lastPeriodStart,
      cycleLength: _cycleLength,
      periodLength: _periodLength,
      guardianName: _guardianName.trim(),
      guardianRelation: _guardianRelation.trim(),
      guardianEnabled: _guardianEnabled,
    );
    if (!mounted) return;
    ref.read(cycleControllerProvider).reload();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
                child: Row(
                  children: [
                    if (_step > 0)
                      IconButton(
                        onPressed: () => _goTo(_step - 1),
                        icon: const Icon(Icons.arrow_back_outlined, size: 22),
                      )
                    else
                      const SizedBox(width: 48),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (_step + 1) / 3,
                      minHeight: 4,
                      backgroundColor: isDark
                          ? AppColors.bgDarkMuted
                          : AppColors.bgLightMuted,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    '${l10n.num(_step + 1)}/${l10n.num(3)}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _step = i),
                children: [
                  _LanguageStep(l10n: l10n, theme: theme),
                  _CycleStep(
                    l10n: l10n,
                    theme: theme,
                    lastPeriodStart: _lastPeriodStart,
                    cycleLength: _cycleLength,
                    periodLength: _periodLength,
                    onPickDate: _pickLastPeriod,
                    onCycleLength: (v) => setState(() => _cycleLength = v),
                    onPeriodLength: (v) => setState(() => _periodLength = v),
                  ),
                  _GuardianStep(
                    l10n: l10n,
                    theme: theme,
                    name: _guardianName,
                    relation: _guardianRelation,
                    enabled: _guardianEnabled,
                    onName: (v) => setState(() => _guardianName = v),
                    onRelation: (v) => setState(() => _guardianRelation = v),
                    onEnabled: (v) => setState(() => _guardianEnabled = v),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xxl,
              ),
              child: Row(
                children: [
                  if (_step < 2)
                    TextButton(
                      onPressed: _finish,
                      child: Text(l10n.skip),
                    ),
                  const Spacer(),
                  AppButton(
                    label: _step == 2 ? l10n.getStarted : l10n.next,
                    icon: _step == 2 ? Icons.check_outlined : null,
                    onPressed: () {
                      if (_step < 2) {
                        _goTo(_step + 1);
                      } else {
                        _finish();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageStep extends ConsumerWidget {
  const _LanguageStep({required this.l10n, required this.theme});

  final AppLocalizations l10n;
  final ThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadii.panel),
            ),
            child: const Icon(Icons.favorite_outline,
                size: 32, color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(l10n.onboardingTitle, style: theme.textTheme.headlineLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.onboardingSubtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.brightness == Brightness.dark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.block),
          Text(l10n.stepLanguage, style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _LangCard(
                  label: 'বাংলা',
                  subtitle: 'Bangla',
                  selected: l10n.isBn,
                  onTap: () =>
                      ref.read(appStateProvider).setLocale(const Locale('bn')),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _LangCard(
                  label: 'English',
                  subtitle: 'ইংরেজি',
                  selected: !l10n.isBn,
                  onTap: () =>
                      ref.read(appStateProvider).setLocale(const Locale('en')),
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _LangCard extends ConsumerWidget {
  const _LangCard({
    required this.label,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: AppDurations.fast,
      curve: AppCurves.standard,
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary.withValues(alpha: 0.1)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.borderLight,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
          child: Column(
            children: [
              Icon(
                selected
                    ? Icons.check_circle_outlined
                    : Icons.circle_outlined,
                color: selected ? AppColors.primary : AppColors.textTertiaryDark,
                size: 24,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _CycleStep extends ConsumerWidget {
  const _CycleStep({
    required this.l10n,
    required this.theme,
    required this.lastPeriodStart,
    required this.cycleLength,
    required this.periodLength,
    required this.onPickDate,
    required this.onCycleLength,
    required this.onPeriodLength,
  });

  final AppLocalizations l10n;
  final ThemeData theme;
  final DateTime lastPeriodStart;
  final int cycleLength;
  final int periodLength;
  final VoidCallback onPickDate;
  final ValueChanged<int> onCycleLength;
  final ValueChanged<int> onPeriodLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: ListView(
        children: [
          const SizedBox(height: AppSpacing.xxl),
          Text(l10n.stepCycle, style: theme.textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.stepCycleDesc,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.brightness == Brightness.dark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.lastPeriodLabel,
                    style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                InkWell(
                  onTap: onPickDate,
                  borderRadius: BorderRadius.circular(AppRadii.control),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppRadii.control),
                      border: Border.all(
                        color: Theme.of(context).dividerTheme.color!,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined,
                            size: 20, color: AppColors.primary),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            DateFormats.full(lastPeriodStart,
                                bn: l10n.isBn),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        const Icon(Icons.chevron_right, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.lastPeriodDesc,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(l10n.cycleLengthLabel,
                        style: theme.textTheme.titleMedium),
                    const Spacer(),
                    Text(
                      '${l10n.num(cycleLength)} ${l10n.daysUnit}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: cycleLength.toDouble(),
                  min: 21,
                  max: 40,
                  divisions: 19,
                  label: '$cycleLength',
                  onChanged: (v) => onCycleLength(v.round()),
                ),
                const Divider(height: AppSpacing.xxl),
                Row(
                  children: [
                    Text(l10n.periodLengthLabel,
                        style: theme.textTheme.titleMedium),
                    const Spacer(),
                    Text(
                      '${l10n.num(periodLength)} ${l10n.daysUnit}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: periodLength.toDouble(),
                  min: 3,
                  max: 8,
                  divisions: 5,
                  label: '$periodLength',
                  onChanged: (v) => onPeriodLength(v.round()),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _GuardianStep extends ConsumerWidget {
  const _GuardianStep({
    required this.l10n,
    required this.theme,
    required this.name,
    required this.relation,
    required this.enabled,
    required this.onName,
    required this.onRelation,
    required this.onEnabled,
  });

  final AppLocalizations l10n;
  final ThemeData theme;
  final String name;
  final String relation;
  final bool enabled;
  final ValueChanged<String> onName;
  final ValueChanged<String> onRelation;
  final ValueChanged<bool> onEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: ListView(
        children: [
          const SizedBox(height: AppSpacing.xxl),
          Text(l10n.stepGuardian, style: theme.textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.guardianDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.brightness == Brightness.dark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    l10n.guardianActive,
                    style: theme.textTheme.bodyMedium,
                  ),
                  value: enabled,
                  activeThumbColor: AppColors.success,
                  onChanged: onEnabled,
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  enabled: enabled,
                  decoration: InputDecoration(
                    hintText: l10n.guardianPlaceholder,
                    labelText: l10n.guardianName,
                  ),
                  onChanged: onName,
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  enabled: enabled,
                  decoration: InputDecoration(
                    hintText: l10n.guardianRelationPlaceholder,
                    labelText: l10n.guardianRelation,
                  ),
                  onChanged: onRelation,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            borderColor: AppColors.success.withValues(alpha: 0.5),
            child: Row(
              children: [
                const Icon(Icons.lock_outline,
                    size: 20, color: AppColors.success),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    l10n.allDataStaysLocal,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}
