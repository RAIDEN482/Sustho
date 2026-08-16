import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'package:shustho/app.dart';
import 'package:shustho/core/theme/app_theme.dart';
import 'package:shustho/data/app_repository.dart';
import 'package:shustho/l10n/app_localizations.dart';
import 'package:shustho/state/app_state.dart';
import 'package:shustho/state/cycle_controller.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('shustho_test');
    Hive.init(tempDir.path);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  testWidgets('app boots to onboarding for a fresh install', (tester) async {
    final repository = AppRepository();
    await repository.init();
    final appState = AppState(repository)..load();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AppState>.value(value: appState),
          ChangeNotifierProvider<CycleController>(
            create: (_) => CycleController(repository)..reload(),
          ),
        ],
        child: const ShusthoApp(),
      ),
    );
    await tester.pumpAndSettle();

    const l10n = AppLocalizations(Locale('en'));
    expect(find.text(l10n.onboardingTitle), findsOneWidget);
  });

  testWidgets('light and dark themes apply the flat border style',
      (tester) async {
    final light = AppTheme.light();
    expect(light.cardTheme.elevation, 0);
    final dark = AppTheme.dark();
    expect(dark.cardTheme.elevation, 0);
    expect(dark.scaffoldBackgroundColor, const Color(0xFF0D1117));
  });
}
