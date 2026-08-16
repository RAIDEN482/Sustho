import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/app_repository.dart';
import '../../data/database/app_database.dart';
import '../../data/secure_storage.dart';
import '../utils/ml_cycle_engine.dart';
import '../../state/app_state.dart';
import '../../state/cycle_controller.dart';
import '../../state/nutrition_controller.dart';
import '../../state/reminders_controller.dart';

// --- Services ---

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final encryptionKeyProvider = FutureProvider<List<int>>((ref) async {
  final secureStorage = ref.watch(secureStorageProvider);
  return secureStorage.getEncryptionKey();
});

// --- Databases / Repositories ---

final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final key = await ref.watch(encryptionKeyProvider.future);
  return AppDatabase(key);
});

final appRepositoryProvider = FutureProvider<AppRepository>((ref) async {
  final repo = AppRepository();
  await repo.init();
  return repo;
});

final appRepositorySyncProvider = Provider<AppRepository>((ref) {
  final repo = ref.watch(appRepositoryProvider).valueOrNull;
  if (repo == null) throw StateError('AppRepository not yet initialized');
  return repo;
});

// --- ML Engine ---

final mlCycleEngineProvider = FutureProvider<MLCycleEngine>((ref) async {
  final engine = MLCycleEngine();
  await engine.init();
  return engine;
});

// --- Legacy State Controllers Migrated to Riverpod (ChangeNotifierProvider) ---

final appStateProvider = ChangeNotifierProvider<AppState>((ref) {
  final repo = ref.watch(appRepositorySyncProvider);
  final state = AppState(repo);
  state.load();
  return state;
});

final cycleControllerProvider = ChangeNotifierProvider<CycleController>((ref) {
  final repo = ref.watch(appRepositorySyncProvider);
  return CycleController(repo)..reload();
});

final nutritionControllerProvider = ChangeNotifierProvider<NutritionController>((ref) {
  final repo = ref.watch(appRepositorySyncProvider);
  return NutritionController(repo);
});

final remindersControllerProvider = ChangeNotifierProvider<RemindersController>((ref) {
  final repo = ref.watch(appRepositorySyncProvider);
  return RemindersController(repo);
});
