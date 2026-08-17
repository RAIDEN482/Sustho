import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';

import '../../core/theme/app_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../state/reminders_controller.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';

class RemindersScreen extends ConsumerStatefulWidget {
  const RemindersScreen({super.key});

  @override
  ConsumerState<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends ConsumerState<RemindersScreen> {
  late TimeOfDay _quietStart;
  late TimeOfDay _quietEnd;

  @override
  void initState() {
    super.initState();
    final controller = ref.read(remindersControllerProvider);
    _quietStart = _parse(controller.quietStart);
    _quietEnd = _parse(controller.quietEnd);
  }

  static TimeOfDay _parse(String value) {
    final parts = value.split(':');
    final hour = parts.isNotEmpty ? int.tryParse(parts[0]) ?? 9 : 9;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String _format(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  Future<void> _pickTime({required bool isQuietStart}) async {
    final controller = ref.read(remindersControllerProvider);
    final picked = await showTimePicker(
      context: context,
      initialTime: isQuietStart ? _quietStart : _quietEnd,
    );
    if (picked == null) return;
    setState(() {
      if (isQuietStart) {
        _quietStart = picked;
      } else {
        _quietEnd = picked;
      }
    });
    await controller.setQuietHours(_format(_quietStart), _format(_quietEnd));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(remindersControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reminders)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.notifications_active_outlined,
                        size: 24, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.remindersEnabled,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            l10n.notificationsOffline,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: controller.enabled,
                      activeTrackColor: AppColors.primary,
                      onChanged: (v) => controller.setMasterEnabled(v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (controller.enabled) ...[
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: l10n.reminderTypes),
                  const SizedBox(height: AppSpacing.sm),
                  _ReminderToggle(
                    icon: Icons.water_drop_outlined,
                    color: AppColors.primary,
                    title: l10n.reminderPeriodPredict,
                    subtitle: l10n.periodPredictionDesc,
                    value:
                        controller.isTypeEnabled(ReminderType.periodPredict),
                    onChanged: (v) => controller
                        .setTypeEnabled(ReminderType.periodPredict, v),
                  ),
                  _ReminderToggle(
                    icon: Icons.task_alt_outlined,
                    color: AppColors.success,
                    title: l10n.reminderPeriodEnd,
                    subtitle: l10n.periodEndDesc,
                    value: controller.isTypeEnabled(ReminderType.periodEnd),
                    onChanged: (v) =>
                        controller.setTypeEnabled(ReminderType.periodEnd, v),
                  ),
                  _ReminderToggle(
                    icon: Icons.medication_outlined,
                    color: AppColors.warning,
                    title: l10n.reminderPill,
                    subtitle: l10n.pillDesc,
                    value: controller.isTypeEnabled(ReminderType.pill),
                    onChanged: (v) =>
                        controller.setTypeEnabled(ReminderType.pill, v),
                  ),
                  _ReminderToggle(
                    icon: Icons.local_drink_outlined,
                    color: AppColors.secondary,
                    title: l10n.reminderWater,
                    subtitle: l10n.waterDesc,
                    value: controller.isTypeEnabled(ReminderType.water),
                    onChanged: (v) =>
                        controller.setTypeEnabled(ReminderType.water, v),
                  ),
                  _ReminderToggle(
                    icon: Icons.assignment_outlined,
                    color: AppColors.warning,
                    title: l10n.reminderSymptom,
                    subtitle: l10n.symptomDesc,
                    value: controller.isTypeEnabled(ReminderType.symptom),
                    onChanged: (v) =>
                        controller.setTypeEnabled(ReminderType.symptom, v),
                  ),
                  _ReminderToggle(
                    icon: Icons.event_outlined,
                    color: AppColors.danger,
                    title: l10n.reminderDoctor,
                    subtitle: l10n.doctorDesc,
                    value: controller.isTypeEnabled(ReminderType.doctor),
                    onChanged: (v) =>
                        controller.setTypeEnabled(ReminderType.doctor, v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: l10n.quietHours),
                  const SizedBox(height: 4),
                  Text(
                    l10n.quietHoursDesc,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: _TimeChip(
                          icon: Icons.bedtime_outlined,
                          label: '${l10n.quietStart}: ${_format(_quietStart)}',
                          onTap: () => _pickTime(isQuietStart: true),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _TimeChip(
                          icon: Icons.wb_sunny_outlined,
                          label: '${l10n.quietEnd}: ${_format(_quietEnd)}',
                          onTap: () => _pickTime(isQuietStart: false),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ReminderToggle extends ConsumerWidget {
  const _ReminderToggle({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(AppRadii.control),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Switch(
            value: value,
            activeTrackColor: color,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _TimeChip extends ConsumerWidget {
  const _TimeChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.control),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.control),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
