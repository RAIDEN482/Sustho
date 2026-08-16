import 'package:flutter/material.dart';

import 'app_tokens.dart';

/// Theme factory. Both light and dark themes share the same typography,
/// radii and flat (border-only) elevation language.
abstract class AppTheme {
  static const String fontFamily = 'Inter';
  static const List<String> fontFamilyFallback = ['NotoSansBengali'];

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final Color background =
        isDark ? AppColors.bgDark : AppColors.bgLight;
    final Color elevated =
        isDark ? AppColors.bgDarkElevated : AppColors.bgLightElevated;
    final Color muted = isDark ? AppColors.bgDarkMuted : AppColors.bgLightMuted;
    final Color textPrimary =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textTertiary =
        isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight;
    final Color border = isDark ? AppColors.borderDark : AppColors.borderLight;

    final baseTextTheme = _textTheme(textPrimary, textSecondary, textTertiary);
    final base = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );

    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: isDark ? AppColors.textPrimaryDark : Colors.white,
        error: AppColors.danger,
        onError: Colors.white,
        surface: elevated,
        onSurface: textPrimary,
      ),
      scaffoldBackgroundColor: background,
      textTheme: baseTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: base.textTheme.headlineSmall?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: elevated,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          side: BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: muted,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: TextStyle(color: textTertiary, fontSize: 16),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: muted,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withValues(alpha: 0.12),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: elevated,
        indicatorColor: AppColors.primary.withValues(alpha: 0.14),
        elevation: 0,
        height: 64,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : textSecondary,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : textSecondary,
            size: 24,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.primary),
      dialogTheme: DialogThemeData(
        backgroundColor: elevated,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.modal),
          side: BorderSide(color: border),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: elevated,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.modal),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return textTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withValues(alpha: 0.35);
          }
          return muted;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primary
              : Colors.transparent,
        ),
        side: BorderSide(color: border),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.chip),
          side: const BorderSide(color: AppColors.primary),
        ),
        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: muted)),
    );
  }

  static TextTheme _textTheme(
    Color textPrimary,
    Color textSecondary,
    Color textTertiary,
  ) {
    const w400 = FontWeight.w400;
    const w500 = FontWeight.w500;

    TextStyle style(
      double size,
      FontWeight weight,
      double height,
      Color color,
    ) {
      return TextStyle(
        fontSize: size,
        fontWeight: weight,
        height: height,
        color: color,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
      );
    }

    return TextTheme(
      displayLarge: style(40, w500, 1.1, textPrimary),
      displayMedium: style(36, w500, 1.1, textPrimary),
      displaySmall: style(32, w500, 1.1, textPrimary),
      headlineLarge: style(28, w500, 1.2, textPrimary),
      headlineMedium: style(24, w500, 1.25, textPrimary),
      headlineSmall: style(22, w500, 1.3, textPrimary),
      titleLarge: style(20, w500, 1.3, textPrimary),
      titleMedium: style(18, w500, 1.4, textPrimary),
      titleSmall: style(16, w500, 1.4, textPrimary),
      bodyLarge: style(16, w400, 1.5, textPrimary),
      bodyMedium: style(15, w400, 1.5, textPrimary),
      bodySmall: style(14, w400, 1.5, textSecondary),
      labelLarge: style(16, w500, 1.4, textPrimary),
      labelMedium: style(14, w500, 1, textPrimary),
      labelSmall: style(12, w400, 1.4, textSecondary),
    );
  }
}
