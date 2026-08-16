import 'package:flutter/material.dart';

import '../core/theme/app_tokens.dart';

enum AppButtonStyle { primary, secondary, outline, ghost }

/// Flat button following the Shustho design system (no shadows, 8px radius).
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.style = AppButtonStyle.primary,
    this.expanded = false,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonStyle style;
  final bool expanded;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !loading;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bg;
    final Color fg;
    final Color borderColor;
    final double borderWidth;
    switch (style) {
      case AppButtonStyle.primary:
        bg = AppColors.primary;
        fg = Colors.white;
        borderColor = Colors.transparent;
        borderWidth = 0;
        break;
      case AppButtonStyle.secondary:
        bg = AppColors.secondary;
        fg = Colors.white;
        borderColor = Colors.transparent;
        borderWidth = 0;
        break;
      case AppButtonStyle.outline:
        bg = Colors.transparent;
        fg = colors.primary;
        borderColor = colors.primary;
        borderWidth = 1;
        break;
      case AppButtonStyle.ghost:
        bg = Colors.transparent;
        fg = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
        borderColor = Colors.transparent;
        borderWidth = 0;
        break;
    }

    final button = Ink(
      decoration: BoxDecoration(
        color: enabled ? bg : bg.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadii.control),
        border: borderWidth > 0
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(AppRadii.control),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          curve: AppCurves.standard,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading) ...[
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
              ] else if (icon != null) ...[
                Icon(icon, size: 20, color: fg),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (expanded) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}
