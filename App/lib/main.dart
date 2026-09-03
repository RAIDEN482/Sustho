import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // The ProviderContainer lets Riverpod providers initialize lazily.
  // We no longer pre-await providers here — app.dart handles the
  // loading/error/data states via appRepositoryProvider.when().
  final container = ProviderContainer();

  try {
    await NotificationService.instance.init();
  } catch (e) {
    debugPrint('Notification init error (non-fatal): $e');
  }

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      defaultDevice: Devices.android.samsungGalaxyS20,
      builder: (context) => UncontrolledProviderScope(
        container: container,
        child: const ShusthoApp(),
      ),
    ),
  );
}
