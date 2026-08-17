import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';

import '../../core/theme/app_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../state/app_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';
import '../nutrition/nutrition_hub_screen.dart';
import '../reminders/reminders_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final appState = ref.watch(appStateProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _LanguageCard(appState: appState, l10n: l10n),
          const SizedBox(height: AppSpacing.lg),
          _ThemeCard(appState: appState, l10n: l10n),
          const SizedBox(height: AppSpacing.lg),
          _NavCard(
            icon: Icons.notifications_active_outlined,
            color: AppColors.primary,
            title: l10n.reminders,
            subtitle: l10n.reminderHint,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const RemindersScreen()),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _NavCard(
            icon: Icons.restaurant_outlined,
            color: AppColors.success,
            title: l10n.nutritionHub,
            subtitle: l10n.phaseMeals,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NutritionHubScreen()),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _GuardianCard(appState: appState, l10n: l10n),
          const SizedBox(height: AppSpacing.lg),
          _PrivacyCard(l10n: l10n),
          const SizedBox(height: AppSpacing.lg),
          _AboutCard(l10n: l10n, isDark: isDark),
          const SizedBox(height: AppSpacing.xxl),
          AppButton(
            label: l10n.resetData,
            icon: Icons.delete_outline,
            style: AppButtonStyle.ghost,
            expanded: true,
            onPressed: () => _confirmReset(context, appState, l10n),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmReset(
    BuildContext context,
    AppState appState,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.resetData),
        content: Text(l10n.resetDataConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.resetData,
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await appState.resetAll();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.resetDataDone)),
        );
      }
    }
  }
}

class _LanguageCard extends ConsumerWidget {
  const _LanguageCard({required this.appState, required this.l10n});

  final AppState appState;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.language, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          SegmentedButton<Locale>(
            segments: const [
              ButtonSegment(
                value: Locale('bn'),
                label: Text('বাংলা'),
                icon: Icon(Icons.language),
              ),
              ButtonSegment(
                value: Locale('en'),
                label: Text('English'),
                icon: Icon(Icons.translate),
              ),
            ],
            selected: {appState.locale},
            onSelectionChanged: (selection) =>
                appState.setLocale(selection.first),
            style: const ButtonStyle(
              visualDensity: VisualDensity.comfortable,
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeCard extends ConsumerWidget {
  const _ThemeCard({required this.appState, required this.l10n});

  final AppState appState;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.themeMode, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(
                value: ThemeMode.light,
                label: Text(l10n.lightMode),
                icon: const Icon(Icons.light_mode_outlined),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text(l10n.darkMode),
                icon: const Icon(Icons.dark_mode_outlined),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                label: Text(l10n.systemMode),
                icon: const Icon(Icons.settings_brightness_outlined),
              ),
            ],
            selected: {appState.themeMode},
            onSelectionChanged: (selection) =>
                appState.setThemeMode(selection.first),
            showSelectedIcon: false,
            style: const ButtonStyle(
              visualDensity: VisualDensity.comfortable,
            ),
          ),
          ),
        ],
      ),
    );
  }
}

class _NavCard extends ConsumerWidget {
  const _NavCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return AppCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.panel),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppRadii.control),
                ),
                child: Icon(icon, size: 24, color: color),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    Text(subtitle, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuardianCard extends ConsumerStatefulWidget {
  const _GuardianCard({required this.appState, required this.l10n});

  final AppState appState;
  final AppLocalizations l10n;

  @override
  ConsumerState<_GuardianCard> createState() => _GuardianCardState();
}

class _GuardianCardState extends ConsumerState<_GuardianCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _relationController;
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.appState.guardianName);
    _relationController =
        TextEditingController(text: widget.appState.guardianRelation);
    _enabled = widget.appState.guardianEnabled;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _relationController.dispose();
    super.dispose();
  }

  Future<void> _save(BuildContext sheetContext) async {
    await widget.appState.updateGuardian(
      name: _nameController.text.trim(),
      relation: _relationController.text.trim(),
      enabled: _enabled,
    );
    if (sheetContext.mounted) {
      Navigator.of(sheetContext).pop();
    }
  }

  void _openEditor() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: 0,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom +
              AppSpacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.l10n.guardian,
                style: Theme.of(sheetContext).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: widget.l10n.guardianPlaceholder,
                labelText: widget.l10n.guardianName,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _relationController,
              decoration: InputDecoration(
                hintText: widget.l10n.guardianRelationPlaceholder,
                labelText: widget.l10n.guardianRelation,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                widget.l10n.guardianActive,
                style: Theme.of(sheetContext).textTheme.bodyMedium,
              ),
              value: _enabled,
              activeThumbColor: AppColors.success,
              onChanged: (v) => setState(() => _enabled = v),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: widget.l10n.save,
              expanded: true,
              onPressed: () => _save(sheetContext),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = widget.l10n;
    final active = widget.appState.guardianEnabled;
    final color = active ? AppColors.success : AppColors.textTertiaryDark;

    return AppCard(
      borderColor: active
          ? AppColors.success.withValues(alpha: 0.5)
          : theme.dividerTheme.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined, size: 20, color: color),
              const SizedBox(width: AppSpacing.sm),
              Text(l10n.guardian, style: theme.textTheme.titleMedium),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: active
                      ? AppColors.success.withValues(alpha: 0.12)
                      : AppColors.bgDarkMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      active ? Icons.check_circle_outline : Icons.circle_outlined,
                      size: 14,
                      color: color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      active ? l10n.guardianActive : l10n.guardianInactive,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.guardianDescription, style: theme.textTheme.bodySmall),
          const SizedBox(height: AppSpacing.md),
          if (active) ...[
            Text(
              '${widget.appState.guardianName} · ${widget.appState.guardianRelation}',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          TextButton.icon(
            onPressed: _openEditor,
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: Text(active ? l10n.edit : l10n.configure),
          ),
        ],
      ),
    );
  }
}

class _PrivacyCard extends ConsumerWidget {
  const _PrivacyCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lock_outline, size: 20, color: AppColors.success),
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
    );
  }
}

class _AboutCard extends ConsumerWidget {
  const _AboutCard({required this.l10n, required this.isDark});

  final AppLocalizations l10n;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.about, style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.aboutText, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Text(
                '${l10n.versionLabel}: ${l10n.version}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
