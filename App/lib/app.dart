import 'package:device_preview/device_preview.dart';
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
    // Wait for the repository to be ready before accessing sync providers.
    final repoAsync = ref.watch(appRepositoryProvider);

    return repoAsync.when(
      loading: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home: const Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 24),
                Text('Loading Shustho...', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
      error: (err, stack) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to initialize:\n$err',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      data: (_) => _buildApp(ref, context),
    );
  }

  Widget _buildApp(WidgetRef ref, BuildContext context) {
    final state = ref.watch(appStateProvider);
    return MaterialApp(
      title: 'Shustho',
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: state.themeMode,
      locale: DevicePreview.locale(context) ?? state.locale,
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
  }
}
