import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shustho/core/theme/app_theme.dart';
import 'package:shustho/core/theme/app_tokens.dart';
import 'package:shustho/l10n/app_localizations.dart';

void main() {
  testWidgets('light theme applies design tokens', (tester) async {
    final theme = AppTheme.light();
    expect(theme.scaffoldBackgroundColor, AppColors.bgLight);
    expect(theme.colorScheme.primary, AppColors.primary);
    expect(theme.textTheme.bodyLarge?.fontFamily, 'Inter');
    expect(theme.textTheme.bodyLarge?.fontFamilyFallback,
        contains('NotoSansBengali'));
  });

  testWidgets('dark theme applies design tokens', (tester) async {
    final theme = AppTheme.dark();
    expect(theme.scaffoldBackgroundColor, AppColors.bgDark);
    expect(theme.colorScheme.primary, AppColors.primary);
    expect(theme.cardTheme.color, AppColors.bgDarkElevated);
  });

  testWidgets('localization resolves Bangla and English', (tester) async {
    const bn = AppLocalizations(Locale('bn'));
    expect(bn.day, 'আজ');
    expect(bn.isBn, isTrue);

    const en = AppLocalizations(Locale('en'));
    expect(en.day, 'Today');
    expect(en.isBn, isFalse);
  });

  testWidgets('Bangla numerals are produced for numbers', (tester) async {
    const bn = AppLocalizations(Locale('bn'));
    expect(bn.num(12), '১২');
    expect(bn.num(7), '৭');
    const en = AppLocalizations(Locale('en'));
    expect(en.num(12), '12');
  });
}
