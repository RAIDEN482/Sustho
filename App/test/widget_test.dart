import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:shustho/app.dart';
import 'package:shustho/core/theme/app_theme.dart';
import 'package:shustho/data/app_repository.dart';
import 'package:shustho/l10n/app_localizations.dart';
import 'package:shustho/state/app_state.dart';
import 'package:shustho/state/cycle_controller.dart';
import 'package:shustho/core/providers/app_providers.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('shustho_test');
    Hive.init(tempDir.path);
    FlutterSecureStorage.setMockInitialValues({});
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  testWidgets('app boots to onboarding for a fresh install', (tester) async {
    final repository = AppRepository();
    await repository.init();
    final appState = AppState(repository)..load();

    final container = ProviderContainer(
      overrides: [
        appStateProvider.overrideWith((ref) => appState),
        cycleControllerProvider.overrideWith((ref) => CycleController(repository)..reload()),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const ShusthoApp(),
      ),
    );
    await tester.pump();

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
