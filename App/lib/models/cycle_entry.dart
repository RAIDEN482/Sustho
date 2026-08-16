import 'package:hive/hive.dart';

import 'enums.dart';

/// A single day's log: period flow, products, pain, mood, symptoms and notes.
@HiveType(typeId: 0)
class CycleEntry extends HiveObject {
  CycleEntry({
    required this.date,
    required this.flowValue,
    required this.painLevel,
    required this.moodValues,
    required this.symptomValues,
    required this.notes,
    required this.productUsedValue,
    required this.hasClots,
    required this.clotSizeValue,
    required this.painDurationMinutes,
    required this.reliefMethodValues,
    required this.medName,
    required this.medDose,
    required this.medEffectiveness,
    required this.energyLevel,
    required this.sleepQuality,
    required this.sleepHours,
    required this.moodCustom,
    required this.painLocationValues,
    required this.medTime,
  });

  factory CycleEntry.create({
    required DateTime date,
    FlowLevel flow = FlowLevel.none,
    int painLevel = 0,
    List<Mood> moods = const [],
    List<SymptomType> symptoms = const [],
    String notes = '',
    ProductUsed productUsed = ProductUsed.none,
    bool hasClots = false,
    ClotSize clotSize = ClotSize.none,
    int painDurationMinutes = 0,
    List<ReliefMethod> reliefMethods = const [],
    String medName = '',
    String medDose = '',
    int medEffectiveness = 0,
    int energyLevel = 0,
    int sleepQuality = 0,
    double sleepHours = 0,
    String moodCustom = '',
    List<PainLocation> painLocations = const [],
    String medTime = '',
  }) {
    return CycleEntry(
      date: DateTime(date.year, date.month, date.day),
      flowValue: flow.value,
      painLevel: painLevel,
      moodValues: moods.map((m) => m.value).toList(),
      symptomValues: symptoms.map((s) => s.value).toList(),
      notes: notes,
      productUsedValue: productUsed.value,
      hasClots: hasClots,
      clotSizeValue: clotSize.value,
      painDurationMinutes: painDurationMinutes,
      reliefMethodValues: reliefMethods.map((r) => r.value).toList(),
      medName: medName,
      medDose: medDose,
      medEffectiveness: medEffectiveness,
      energyLevel: energyLevel,
      sleepQuality: sleepQuality,
      sleepHours: sleepHours,
      moodCustom: moodCustom,
      painLocationValues: painLocations.map((p) => p.value).toList(),
      medTime: medTime,
    );
  }

  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int flowValue;

  @HiveField(2)
  int painLevel;

  @HiveField(3)
  List<int> moodValues;

  @HiveField(4)
  List<int> symptomValues;

  @HiveField(5)
  String notes;

  @HiveField(6)
  int productUsedValue;

  @HiveField(7)
  bool hasClots;

  @HiveField(8)
  int clotSizeValue;

  @HiveField(9)
  int painDurationMinutes;

  @HiveField(10)
  List<int> reliefMethodValues;

  @HiveField(11)
  String medName;

  @HiveField(12)
  String medDose;

  @HiveField(13)
  int medEffectiveness;

  @HiveField(14)
  int energyLevel;

  @HiveField(15)
  int sleepQuality;

  @HiveField(16)
  double sleepHours;

  @HiveField(17)
  String moodCustom;

  @HiveField(18)
  List<int> painLocationValues;

  @HiveField(19)
  String medTime;

  // ---- Flow ----

  FlowLevel get flow => FlowLevel.fromValue(flowValue);

  set flow(FlowLevel value) => flowValue = value.value;

  // ---- Moods ----

  List<Mood> get moods => moodValues.map(Mood.fromValue).toList();

  set moods(List<Mood> value) =>
      moodValues = value.map((m) => m.value).toList();

  // ---- Symptoms ----

  List<SymptomType> get symptoms =>
      symptomValues.map(SymptomType.fromValue).toList();

  set symptoms(List<SymptomType> value) =>
      symptomValues = value.map((s) => s.value).toList();

  // ---- Product / clots ----

  ProductUsed get productUsed => ProductUsed.fromValue(productUsedValue);

  set productUsed(ProductUsed value) => productUsedValue = value.value;

  ClotSize get clotSize => ClotSize.fromValue(clotSizeValue);

  set clotSize(ClotSize value) => clotSizeValue = value.value;

  // ---- Relief ----

  List<ReliefMethod> get reliefMethods =>
      reliefMethodValues.map(ReliefMethod.fromValue).toList();

  set reliefMethods(List<ReliefMethod> value) =>
      reliefMethodValues = value.map((r) => r.value).toList();

  // ---- Pain location ----

  List<PainLocation> get painLocations =>
      painLocationValues.map(PainLocation.fromValue).toList();

  set painLocations(List<PainLocation> value) =>
      painLocationValues = value.map((p) => p.value).toList();

  bool get isPeriodDay => flowValue != FlowLevel.none.value;
}
