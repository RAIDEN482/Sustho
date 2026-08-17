import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/utils/cycle_engine.dart';
import '../../l10n/app_localizations.dart';
import '../../models/food_item.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';

class NutritionHubScreen extends ConsumerWidget {
  const NutritionHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(nutritionControllerProvider);
    final cycle = ref.watch(cycleControllerProvider);
    final today = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.nutritionHub)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _WaterCard(
            cups: controller.waterFor(today),
            onAdd: () => controller.addWater(today),
            onReset: () => controller.resetWater(today),
            l10n: l10n,
          ),
          const SizedBox(height: AppSpacing.lg),
          _PhaseMealCard(phase: cycle.prediction.phase, l10n: l10n),
          const SizedBox(height: AppSpacing.lg),
          _IronCard(
            foods: controller.foodsFor(today),
            iron: controller.ironFor(today),
            l10n: l10n,
          ),
          const SizedBox(height: AppSpacing.lg),
          _FoodSearchCard(
            onAdd: (food) => controller.addFood(today, food),
            l10n: l10n,
          ),
        ],
      ),
    );
  }
}

class _WaterCard extends ConsumerWidget {
  const _WaterCard({
    required this.cups,
    required this.onAdd,
    required this.onReset,
    required this.l10n,
  });

  final int cups;
  final VoidCallback onAdd;
  final VoidCallback onReset;
  final AppLocalizations l10n;

  static const int _goal = 8;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = (cups / _goal).clamp(0.0, 1.0);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: l10n.waterIntake),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const Icon(Icons.water_drop_outlined,
                  size: 48, color: AppColors.secondary),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${l10n.num(cups)} / ${l10n.num(_goal)} ${l10n.cupsOf}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.waterGoal,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              AppButton(
                label: '+1',
                icon: Icons.add_outlined,
                style: AppButtonStyle.primary,
                onPressed: onAdd,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor:
                  isDark ? AppColors.borderDark : AppColors.borderLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.secondary),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onReset,
              child: Text(l10n.resetData, style: const TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseMealCard extends ConsumerWidget {
  const _PhaseMealCard({required this.phase, required this.l10n});

  final CyclePhase phase;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (String title, String desc, IconData icon) = switch (phase) {
      CyclePhase.period => (l10n.menstrualPhase, l10n.ironRich, Icons.local_florist_outlined),
      CyclePhase.fertileWindow || CyclePhase.ovulation => (
          l10n.ovulatoryPhase,
          l10n.freshVegetables,
          Icons.spa_outlined,
        ),
      CyclePhase.follicular => (
          l10n.follicularPhase,
          l10n.freshVegetables,
          Icons.eco_outlined,
        ),
      CyclePhase.luteal => (
          l10n.lutealPhaseName,
          l10n.complexCarbs,
          Icons.grass_outlined,
        ),
      CyclePhase.unknown => (
          l10n.phaseMeals,
          l10n.ironRich,
          Icons.restaurant_outlined,
        ),
    };

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? AppColors.success : AppColors.success;

    return AppCard(
      borderColor: AppColors.success.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppRadii.control),
                ),
                child: Icon(icon, size: 22, color: color),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.phaseMeals,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            desc,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
          ),
        ],
      ),
    );
  }
}

class _IronCard extends ConsumerWidget {
  const _IronCard({
    required this.foods,
    required this.iron,
    required this.l10n,
  });

  final List<FoodItem> foods;
  final double iron;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: l10n.ironChart),
          const SizedBox(height: AppSpacing.md),
          if (foods.isEmpty)
            Text(l10n.noFoodFound, style: Theme.of(context).textTheme.bodyMedium)
          else ...[
            Text(
              '${iron.toStringAsFixed(1)} ${l10n.ironUnit}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final food in foods)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.isBn ? food.nameBn : food.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    if (food.lowGi)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(AppRadii.chip),
                        ),
                        child: Text(
                          l10n.lowGi,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '${food.ironMg.toStringAsFixed(1)} ${l10n.ironUnit}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _FoodSearchCard extends ConsumerStatefulWidget {
  const _FoodSearchCard({required this.onAdd, required this.l10n});

  final ValueChanged<FoodItem> onAdd;
  final AppLocalizations l10n;

  @override
  ConsumerState<_FoodSearchCard> createState() => _FoodSearchCardState();
}

class _FoodSearchCardState extends ConsumerState<_FoodSearchCard> {
  final TextEditingController _controller = TextEditingController();
  List<FoodItem> _results = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _results = FoodDatabase.search(query, bn: widget.l10n.isBn);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: l10n.logFood),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _controller,
            onChanged: _search,
            decoration: InputDecoration(
              hintText: l10n.searchFood,
              prefixIcon: const Icon(Icons.search_outlined),
            ),
          ),
          if (_results.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            for (final food in _results)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: Icon(
                  food.lowGi ? Icons.eco_outlined : Icons.restaurant_outlined,
                  color: food.lowGi ? AppColors.success : AppColors.warning,
                ),
                title: Text(
                  l10n.isBn ? food.nameBn : food.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  '${food.ironMg.toStringAsFixed(1)} ${l10n.ironUnit} ${l10n.perServing}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.primary,
                  onPressed: () => widget.onAdd(food),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
