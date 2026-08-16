import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/app_repository.dart';
import 'services/notification_service.dart';
import 'state/app_state.dart';
import 'state/cycle_controller.dart';
import 'state/nutrition_controller.dart';
import 'state/reminders_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final repository = AppRepository();
  await repository.init();

  await NotificationService.instance.init();

  final appState = AppState(repository);
  appState.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(value: appState),
        ChangeNotifierProvider<CycleController>(
          create: (_) => CycleController(repository)..reload(),
        ),
        ChangeNotifierProvider<NutritionController>(
          create: (_) => NutritionController(repository),
        ),
        ChangeNotifierProvider<RemindersController>(
          create: (_) => RemindersController(repository),
        ),
      ],
      child: const ShusthoApp(),
    ),
  );
}
