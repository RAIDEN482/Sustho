import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/providers/app_providers.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Initialize Riverpod container to pre-load critical async providers
  final container = ProviderContainer();
  
  try {
    await container.read(encryptionKeyProvider.future);
    await container.read(appRepositoryProvider.future);
  } catch (e) {
    debugPrint('Repository init error: $e');
  }

  try {
    await container.read(appDatabaseProvider.future);
  } catch (e) {
    debugPrint('Database init error: $e');
  }

  try {
    await container.read(mlCycleEngineProvider.future);
  } catch (e) {
    debugPrint('ML engine init error: $e');
  }

  try {
    await NotificationService.instance.init();
  } catch (e) {
    debugPrint('Notification init error: $e');
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ShusthoApp(),
    ),
  );
}
