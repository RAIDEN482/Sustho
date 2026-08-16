import 'package:flutter/foundation.dart';

import '../data/app_repository.dart';
import '../models/food_item.dart';

/// Tracks water intake and logged foods (persisted in Hive). The daily food
/// log drives the iron-intake chart.
class NutritionController extends ChangeNotifier {
  NutritionController(this.repository);

  final AppRepository repository;

  int waterFor(DateTime date) => repository.waterFor(date);

  Future<void> addWater(DateTime date, [int cups = 1]) async {
    await repository.setWater(date, waterFor(date) + cups);
    notifyListeners();
  }

  Future<void> resetWater(DateTime date) async {
    await repository.setWater(date, 0);
    notifyListeners();
  }

  List<FoodItem> foodsFor(DateTime date) {
    final ids = repository.foodLogFor(date);
    return FoodDatabase.all.where((f) => ids.contains(f.id)).toList();
  }

  /// Total iron (mg) from foods logged for [date].
  double ironFor(DateTime date) {
    return foodsFor(date).fold(0.0, (sum, f) => sum + f.ironMg);
  }

  Future<void> addFood(DateTime date, FoodItem food) async {
    await repository.addFood(date, food.id);
    notifyListeners();
  }

  Future<void> removeFood(DateTime date, FoodItem food) async {
    await repository.removeFood(date, food.id);
    notifyListeners();
  }
}
