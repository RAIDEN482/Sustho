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
  
  // We await the initialization of our core dependencies before running the app.
  await container.read(encryptionKeyProvider.future);
  await container.read(appRepositoryProvider.future);
  await container.read(appDatabaseProvider.future);
  await container.read(mlCycleEngineProvider.future);

  await NotificationService.instance.init();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ShusthoApp(),
    ),
  );
}
