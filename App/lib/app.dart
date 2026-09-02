import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/app_providers.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'screens/onboarding/onboarding_flow.dart';
import 'screens/home/home_shell.dart';

class ShusthoApp extends ConsumerWidget {
  const ShusthoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Wait for async repository initialization before rendering app content.
    final repoAsync = ref.watch(appRepositoryProvider);

    return repoAsync.when(
      loading: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (err, stack) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'Failed to initialize: $err',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      data: (_) {
        final state = ref.watch(appStateProvider);
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
