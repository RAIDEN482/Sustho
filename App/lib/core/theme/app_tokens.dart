import 'package:flutter/material.dart';

/// Design tokens matching the Shustho design system.
class AppColors {
  AppColors._();

  // Brand / primary
  static const Color primary = Color(0xFFE94560);
  static const Color primaryLight = Color(0xFFFF6B8A);
  static const Color primaryDark = Color(0xFFC73E54);

  // Secondary
  static const Color secondary = Color(0xFF58A6FF);
  static const Color secondaryLight = Color(0xFF7AB8FF);

  // Semantic
  static const Color success = Color(0xFF238636);
  static const Color successLight = Color(0xFF2EA043);
  static const Color warning = Color(0xFFD29922);
  static const Color warningLight = Color(0xFFE3B341);
  static const Color danger = Color(0xFFDA3633);
  static const Color dangerLight = Color(0xFFF85149);

  // Backgrounds - dark
  static const Color bgDark = Color(0xFF0D1117);
  static const Color bgDarkElevated = Color(0xFF161B22);
  static const Color bgDarkMuted = Color(0xFF21262D);

  // Backgrounds - light
  static const Color bgLight = Color(0xFFFFFFFF);
  static const Color bgLightElevated = Color(0xFFF6F8FA);
  static const Color bgLightMuted = Color(0xFFF3F4F6);

  // Text - dark mode
  static const Color textPrimaryDark = Color(0xFFC9D1D9);
  static const Color textSecondaryDark = Color(0xFF8B949E);
  static const Color textTertiaryDark = Color(0xFF6E7681);

  // Text - light mode
  static const Color textPrimaryLight = Color(0xFF1F2328);
  static const Color textSecondaryLight = Color(0xFF656D76);
  static const Color textTertiaryLight = Color(0xFF8C959F);

  // Borders
  static const Color borderDark = Color(0xFF30363D);
  static const Color borderLight = Color(0xFFD0D7DE);
}

class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double section = 32;
  static const double block = 48;
  static const double page = 64;
}

class AppRadii {
  AppRadii._();

  static const double chip = 6;
  static const double control = 8;
  static const double card = 10;
  static const double panel = 12;
  static const double modal = 16;
  static const double pill = 9999;
}

class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 100);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 300);
}

class AppCurves {
  AppCurves._();

  /// Entrance easing: cubic-bezier(0.16, 1, 0.3, 1)
  static const Curve entrance = Cubic(0.16, 1, 0.3, 1);

  /// Standard easing: cubic-bezier(0.4, 0, 0.2, 1)
  static const Curve standard = Cubic(0.4, 0, 0.2, 1);
}
