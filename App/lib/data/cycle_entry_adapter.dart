import 'package:hive/hive.dart';

import '../models/cycle_entry.dart';

/// Manual Hive type adapter for [CycleEntry] (no build_runner required).
class CycleEntryAdapter extends TypeAdapter<CycleEntry> {
  @override
  final int typeId = 0;

  @override
  CycleEntry read(BinaryReader reader) {
    final date = reader.read() as DateTime;
    final flowValue = reader.read() as int;
    final painLevel = reader.read() as int;
    final moodValues = List<int>.from(reader.read() as List);
    final symptomValues = List<int>.from(reader.read() as List);
    final notes = reader.read() as String;
    return CycleEntry(
      date: date,
      flowValue: flowValue,
      painLevel: painLevel,
      moodValues: moodValues,
      symptomValues: symptomValues,
      notes: notes,
      productUsedValue: reader.read() as int,
      hasClots: reader.read() as bool,
      clotSizeValue: reader.read() as int,
      painDurationMinutes: reader.read() as int,
      reliefMethodValues: List<int>.from(reader.read() as List),
      medName: reader.read() as String,
      medDose: reader.read() as String,
      medEffectiveness: reader.read() as int,
      energyLevel: reader.read() as int,
      sleepQuality: reader.read() as int,
      sleepHours: reader.read() as double,
      moodCustom: reader.read() as String,
      painLocationValues: List<int>.from(reader.read() as List),
      medTime: reader.read() as String,
    );
  }

  @override
  void write(BinaryWriter writer, CycleEntry obj) {
    writer
      ..write(obj.date)
      ..write(obj.flowValue)
      ..write(obj.painLevel)
      ..write(obj.moodValues)
      ..write(obj.symptomValues)
      ..write(obj.notes)
      ..write(obj.productUsedValue)
      ..write(obj.hasClots)
      ..write(obj.clotSizeValue)
      ..write(obj.painDurationMinutes)
      ..write(obj.reliefMethodValues)
      ..write(obj.medName)
      ..write(obj.medDose)
      ..write(obj.medEffectiveness)
      ..write(obj.energyLevel)
      ..write(obj.sleepQuality)
      ..write(obj.sleepHours)
      ..write(obj.moodCustom)
      ..write(obj.painLocationValues)
      ..write(obj.medTime);
  }
}
