import 'package:flutter/material.dart';

import '../core/theme/app_tokens.dart';

/// Small stat tile used on the insights screen.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.icon,
    this.accent = AppColors.primary,
  });

  final String label;
  final String value;
  final String? unit;
  final IconData? icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: theme.dividerTheme.color ?? AppColors.borderLight),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: accent),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: theme.textTheme.displaySmall?.copyWith(color: accent)),
              if (unit != null) ...[
                const SizedBox(width: 4),
                Text(unit!, style: theme.textTheme.bodySmall),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
