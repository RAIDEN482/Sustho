import 'package:flutter/material.dart';

import '../core/theme/app_tokens.dart';

/// A selectable chip (6px radius, 500-weight label). Selected state uses the
/// primary color background with white text. Supports an optional leading icon.
class SelectableChip extends StatelessWidget {
  const SelectableChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.selectedColor = AppColors.primary,
    this.icon,
    this.iconColor,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedColor;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color borderColor =
        isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color textColor = selected
        ? Colors.white
        : (isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight);
    final Color iconColorResolved =
        selected ? Colors.white : (iconColor ?? textColor);

    return AnimatedContainer(
      duration: AppDurations.fast,
      curve: AppCurves.standard,
      decoration: BoxDecoration(
        color: selected ? selectedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadii.chip),
        border: Border.all(color: selected ? selectedColor : borderColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.chip),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: iconColorResolved),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
