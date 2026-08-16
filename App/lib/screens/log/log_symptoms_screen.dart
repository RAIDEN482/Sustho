import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/utils/date_formats.dart';
import '../../l10n/app_localizations.dart';
import '../../models/enums.dart';
import '../../state/cycle_controller.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';
import '../../widgets/selectable_chip.dart';

class LogSymptomsScreen extends StatefulWidget {
  const LogSymptomsScreen({super.key, this.initialDate});

  final DateTime? initialDate;

  @override
  State<LogSymptomsScreen> createState() => _LogSymptomsScreenState();
}

class _LogSymptomsScreenState extends State<LogSymptomsScreen> {
  late DateTime _date;
  final Set<Mood> _moods = {};
  final Set<SymptomType> _symptoms = {};
  final Set<PainLocation> _painLocations = {};
  final Set<ReliefMethod> _reliefMethods = {};
  int _painLevel = 0;
  int _painDurationMinutes = 0;
  int _energyLevel = 0;
  int _sleepQuality = 0;
  double _sleepHours = 0;
  String _medName = '';
  String _medDose = '';
  String _medTime = '';
  int _medEffectiveness = 0;
  late final TextEditingController _notesController;
  late final TextEditingController _customMoodController;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _date = widget.initialDate != null
        ? DateTime(widget.initialDate!.year, widget.initialDate!.month,
            widget.initialDate!.day)
        : DateTime(now.year, now.month, now.day);
    _notesController = TextEditingController();
    _customMoodController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    _customMoodController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year, now.month, now.day),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _save() async {
    final controller = context.read<CycleController>();
    await controller.logSymptoms(
      date: _date,
      moods: _moods.toList(),
      moodCustom: _customMoodController.text.trim(),
      symptoms: _symptoms.toList(),
      painLevel: _painLevel,
      notes: _notesController.text.trim(),
      painLocations: _painLocations.toList(),
      reliefMethods: _reliefMethods.toList(),
      painDurationMinutes: _painDurationMinutes,
      medName: _medName,
      medDose: _medDose,
      medTime: _medTime,
      medEffectiveness: _medEffectiveness,
      energyLevel: _energyLevel,
      sleepQuality: _sleepQuality,
      sleepHours: _sleepHours,
    );
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.logSymptoms)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.pickDate, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                _DateRow(
                  label: DateFormats.full(_date, bn: l10n.isBn),
                  onTap: _pickDate,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.moods, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final mood in Mood.values)
                      _MoodChip(
                        mood: mood,
                        selected: _moods.contains(mood),
                        label: _moodLabel(mood, l10n),
                        color: _moodColor(mood),
                        onTap: () => setState(() {
                          _moods.contains(mood)
                              ? _moods.remove(mood)
                              : _moods.add(mood);
                        }),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: _customMoodController,
                  maxLength: 60,
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                  decoration: InputDecoration(
                    labelText: l10n.moodCustomLabel,
                    hintText: l10n.moodCustomHint,
                    counterText: '',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.energyLevel, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Slider(
                  value: _energyLevel.toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  activeColor: AppColors.success,
                  label: l10n.num(_energyLevel),
                  onChanged: (v) =>
                      setState(() => _energyLevel = v.round()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.noPain, style: theme.textTheme.bodySmall),
                    Text(l10n.painSevere, style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.sleepQuality, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Slider(
                  value: _sleepQuality.toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  activeColor: AppColors.secondary,
                  label: l10n.num(_sleepQuality),
                  onChanged: (v) =>
                      setState(() => _sleepQuality = v.round()),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.sleepHours, style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.sm),
                Slider(
                  value: _sleepHours,
                  min: 0,
                  max: 12,
                  divisions: 48,
                  activeColor: AppColors.secondary,
                  label:
                      '${l10n.num(_sleepHours.round())} ${l10n.sleepHoursUnit}',
                  onChanged: (v) =>
                      setState(() => _sleepHours = (v * 4).round() / 4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0', style: theme.textTheme.bodySmall),
                    Text('12 ${l10n.sleepHoursUnit}',
                        style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.symptoms, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final symptom in SymptomType.values)
                      SelectableChip(
                        label: _symptomLabel(symptom, l10n),
                        selected: _symptoms.contains(symptom),
                        selectedColor: AppColors.warning,
                        onTap: () => setState(() {
                          _symptoms.contains(symptom)
                              ? _symptoms.remove(symptom)
                              : _symptoms.add(symptom);
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildPainCard(l10n, theme),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.painLocations, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final loc in PainLocation.values)
                      SelectableChip(
                        label: _painLocationLabel(loc, l10n),
                        icon: _painLocationIcon(loc),
                        selected: _painLocations.contains(loc),
                        selectedColor: AppColors.danger,
                        onTap: () => setState(() {
                          _painLocations.contains(loc)
                              ? _painLocations.remove(loc)
                              : _painLocations.add(loc);
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.reliefMethods, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final method in ReliefMethod.values)
                      SelectableChip(
                        label: _reliefLabel(method, l10n),
                        selected: _reliefMethods.contains(method),
                        selectedColor: AppColors.success,
                        onTap: () => setState(() {
                          _reliefMethods.contains(method)
                              ? _reliefMethods.remove(method)
                              : _reliefMethods.add(method);
                        }),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.painDuration, style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (v) => setState(
                            () => _painDurationMinutes = int.tryParse(v) ?? 0),
                        decoration: InputDecoration(
                          hintText: '30',
                          labelText: l10n.durationMinutes,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.medication, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: TextEditingController(text: _medName),
                  onChanged: (v) => _medName = v,
                  decoration: InputDecoration(
                    labelText: l10n.medName,
                    hintText: l10n.medNameHint,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: _medDose),
                        onChanged: (v) => _medDose = v,
                        decoration: InputDecoration(
                          labelText: l10n.medDose,
                          hintText: l10n.medDoseHint,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: _medTime),
                        onChanged: (v) => _medTime = v,
                        decoration: InputDecoration(
                          labelText: l10n.medTime,
                          hintText: '09:00',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.medEffectiveness, style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.sm),
                Slider(
                  value: _medEffectiveness.toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  activeColor: AppColors.success,
                  label: l10n.num(_medEffectiveness),
                  onChanged: (v) =>
                      setState(() => _medEffectiveness = v.round()),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.notes, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  maxLength: 500,
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.notesHint,
                    counterText: '',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          AppButton(
            label: l10n.save,
            icon: Icons.check_outlined,
            expanded: true,
            onPressed: _save,
          ),
        ],
      ),
    );
  }

  Widget _buildPainCard(AppLocalizations l10n, ThemeData theme) {
    final painColor = _painColor(_painLevel);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(l10n.painScale, style: theme.textTheme.titleMedium),
              const Spacer(),
              Text(
                '${l10n.num(_painLevel)}/10',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: painColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _PainGradient(),
          const SizedBox(height: AppSpacing.sm),
          Slider(
            value: _painLevel.toDouble(),
            min: 0,
            max: 10,
            divisions: 10,
            activeColor: painColor,
            label: '$_painLevel/10',
            onChanged: (v) => setState(() => _painLevel = v.round()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.painMild, style: theme.textTheme.bodySmall),
              Text(l10n.painModerate, style: theme.textTheme.bodySmall),
              Text(l10n.painSevere, style: theme.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Color _painColor(int level) {
    if (level <= 3) return AppColors.success;
    if (level <= 6) return AppColors.warning;
    return AppColors.danger;
  }

  static String _moodLabel(Mood mood, AppLocalizations l10n) {
    switch (mood) {
      case Mood.happy:
        return l10n.moodHappy;
      case Mood.calm:
        return l10n.moodCalm;
      case Mood.anxious:
        return l10n.moodAnxious;
      case Mood.sad:
        return l10n.moodSad;
      case Mood.irritable:
        return l10n.moodIrritable;
      case Mood.energetic:
        return l10n.moodEnergetic;
      case Mood.tired:
        return l10n.moodTired;
      case Mood.angry:
        return l10n.moodAngry;
    }
  }

  static Color _moodColor(Mood mood) {
    switch (mood) {
      case Mood.happy:
        return AppColors.warning;
      case Mood.energetic:
        return AppColors.success;
      case Mood.calm:
        return AppColors.secondary;
      case Mood.tired:
        return AppColors.textTertiaryDark;
      case Mood.irritable:
        return AppColors.danger;
      case Mood.anxious:
        return AppColors.secondary;
      case Mood.sad:
        return AppColors.textSecondaryDark;
      case Mood.angry:
        return AppColors.danger;
    }
  }

  static String _symptomLabel(SymptomType symptom, AppLocalizations l10n) {
    switch (symptom) {
      case SymptomType.cramps:
        return l10n.symCramps;
      case SymptomType.headache:
        return l10n.symHeadache;
      case SymptomType.backache:
        return l10n.symBackache;
      case SymptomType.bloating:
        return l10n.symBloating;
      case SymptomType.breastTenderness:
        return l10n.symBreastTenderness;
      case SymptomType.fatigue:
        return l10n.symFatigue;
      case SymptomType.nausea:
        return l10n.symNausea;
      case SymptomType.acne:
        return l10n.symAcne;
      case SymptomType.craving:
        return l10n.symCraving;
      case SymptomType.insomnia:
        return l10n.symInsomnia;
      case SymptomType.moodSwings:
        return l10n.symMoodSwings;
      case SymptomType.anxiety:
        return l10n.symAnxiety;
    }
  }

  static String _painLocationLabel(PainLocation loc, AppLocalizations l10n) {
    switch (loc) {
      case PainLocation.lowerAbdomen:
        return l10n.locLowerAbdomen;
      case PainLocation.lowerBack:
        return l10n.locLowerBack;
      case PainLocation.upperBack:
        return l10n.locUpperBack;
      case PainLocation.thighs:
        return l10n.locThighs;
      case PainLocation.hips:
        return l10n.locHips;
      case PainLocation.head:
        return l10n.locHead;
    }
  }

  static IconData _painLocationIcon(PainLocation loc) {
    switch (loc) {
      case PainLocation.lowerAbdomen:
        return Icons.circle_outlined;
      case PainLocation.lowerBack:
        return Icons.straighten_outlined;
      case PainLocation.upperBack:
        return Icons.straighten_outlined;
      case PainLocation.thighs:
        return Icons.south_west_outlined;
      case PainLocation.hips:
        return Icons.adjust_outlined;
      case PainLocation.head:
        return Icons.face_outlined;
    }
  }

  static String _reliefLabel(ReliefMethod method, AppLocalizations l10n) {
    switch (method) {
      case ReliefMethod.heatPad:
        return l10n.reliefHeat;
      case ReliefMethod.medication:
        return l10n.reliefMedication;
      case ReliefMethod.herbalTea:
        return l10n.reliefTea;
      case ReliefMethod.rest:
        return l10n.reliefRest;
      case ReliefMethod.stretching:
        return l10n.reliefStretching;
      case ReliefMethod.massage:
        return l10n.reliefMassage;
    }
  }
}

class _MoodChip extends StatelessWidget {
  const _MoodChip({
    required this.mood,
    required this.selected,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final Mood mood;
  final bool selected;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon = switch (mood) {
      Mood.happy => Icons.wb_sunny_outlined,
      Mood.energetic => Icons.bolt_outlined,
      Mood.calm => Icons.waves_outlined,
      Mood.tired => Icons.bedtime_outlined,
      Mood.irritable => Icons.thunderstorm_outlined,
      Mood.anxious => Icons.cloud_outlined,
      Mood.sad => Icons.water_outlined,
      Mood.angry => Icons.local_fire_department_outlined,
    };
    return SelectableChip(
      label: label,
      icon: icon,
      iconColor: color,
      selected: selected,
      selectedColor: color,
      onTap: onTap,
    );
  }
}

class _PainGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        gradient: const LinearGradient(
          colors: [
            AppColors.success,
            AppColors.warning,
            AppColors.danger,
          ],
        ),
      ),
    );
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.control),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadii.control),
          border: Border.all(color: Theme.of(context).dividerTheme.color!),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                size: 20, color: AppColors.primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }
}
