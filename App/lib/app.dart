import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'screens/onboarding/onboarding_flow.dart';
import 'screens/home/home_shell.dart';
import 'state/app_state.dart';

class ShusthoApp extends StatelessWidget {
  const ShusthoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        return MaterialApp(
          title: 'Shustho',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: state.themeMode,
          locale: state.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('bn')],
          home: state.onboardingCompleted
              ? const HomeShell()
              : const OnboardingFlow(),
        );
      },
    );
  }
}
