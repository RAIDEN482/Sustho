// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SymptomsTable extends Symptoms
    with TableInfo<$SymptomsTable, SymptomLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _painLevelMeta =
      const VerificationMeta('painLevel');
  @override
  late final GeneratedColumn<int> painLevel = GeneratedColumn<int>(
      'pain_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _moodsMeta = const VerificationMeta('moods');
  @override
  late final GeneratedColumn<String> moods = GeneratedColumn<String>(
      'moods', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _physicalSymptomsMeta =
      const VerificationMeta('physicalSymptoms');
  @override
  late final GeneratedColumn<String> physicalSymptoms = GeneratedColumn<String>(
      'physical_symptoms', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _acneSeverityMeta =
      const VerificationMeta('acneSeverity');
  @override
  late final GeneratedColumn<int> acneSeverity = GeneratedColumn<int>(
      'acne_severity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _hairLossMeta =
      const VerificationMeta('hairLoss');
  @override
  late final GeneratedColumn<bool> hairLoss = GeneratedColumn<bool>(
      'hair_loss', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("hair_loss" IN (0, 1))'));
  static const VerificationMeta _painLocationsMeta =
      const VerificationMeta('painLocations');
  @override
  late final GeneratedColumn<String> painLocations = GeneratedColumn<String>(
      'pain_locations', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        painLevel,
        moods,
        physicalSymptoms,
        notes,
        acneSeverity,
        weight,
        hairLoss,
        painLocations
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptoms';
  @override
  VerificationContext validateIntegrity(Insertable<SymptomLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('pain_level')) {
      context.handle(_painLevelMeta,
          painLevel.isAcceptableOrUnknown(data['pain_level']!, _painLevelMeta));
    }
    if (data.containsKey('moods')) {
      context.handle(
          _moodsMeta, moods.isAcceptableOrUnknown(data['moods']!, _moodsMeta));
    }
    if (data.containsKey('physical_symptoms')) {
      context.handle(
          _physicalSymptomsMeta,
          physicalSymptoms.isAcceptableOrUnknown(
              data['physical_symptoms']!, _physicalSymptomsMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('acne_severity')) {
      context.handle(
          _acneSeverityMeta,
          acneSeverity.isAcceptableOrUnknown(
              data['acne_severity']!, _acneSeverityMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('hair_loss')) {
      context.handle(_hairLossMeta,
          hairLoss.isAcceptableOrUnknown(data['hair_loss']!, _hairLossMeta));
    }
    if (data.containsKey('pain_locations')) {
      context.handle(
          _painLocationsMeta,
          painLocations.isAcceptableOrUnknown(
              data['pain_locations']!, _painLocationsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      painLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pain_level'])!,
      moods: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}moods'])!,
      physicalSymptoms: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}physical_symptoms'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      acneSeverity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}acne_severity']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      hairLoss: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}hair_loss']),
      painLocations: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pain_locations']),
    );
  }

  @override
  $SymptomsTable createAlias(String alias) {
    return $SymptomsTable(attachedDatabase, alias);
  }
}

class SymptomLog extends DataClass implements Insertable<SymptomLog> {
  final int id;
  final DateTime date;
  final int painLevel;
  final String moods;
  final String physicalSymptoms;
  final String notes;
  final int? acneSeverity;
  final double? weight;
  final bool? hairLoss;
  final String? painLocations;
  const SymptomLog(
      {required this.id,
      required this.date,
      required this.painLevel,
      required this.moods,
      required this.physicalSymptoms,
      required this.notes,
      this.acneSeverity,
      this.weight,
      this.hairLoss,
      this.painLocations});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['pain_level'] = Variable<int>(painLevel);
    map['moods'] = Variable<String>(moods);
    map['physical_symptoms'] = Variable<String>(physicalSymptoms);
    map['notes'] = Variable<String>(notes);
    if (!nullToAbsent || acneSeverity != null) {
      map['acne_severity'] = Variable<int>(acneSeverity);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || hairLoss != null) {
      map['hair_loss'] = Variable<bool>(hairLoss);
    }
    if (!nullToAbsent || painLocations != null) {
      map['pain_locations'] = Variable<String>(painLocations);
    }
    return map;
  }

  SymptomsCompanion toCompanion(bool nullToAbsent) {
    return SymptomsCompanion(
      id: Value(id),
      date: Value(date),
      painLevel: Value(painLevel),
      moods: Value(moods),
      physicalSymptoms: Value(physicalSymptoms),
      notes: Value(notes),
      acneSeverity: acneSeverity == null && nullToAbsent
          ? const Value.absent()
          : Value(acneSeverity),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      hairLoss: hairLoss == null && nullToAbsent
          ? const Value.absent()
          : Value(hairLoss),
      painLocations: painLocations == null && nullToAbsent
          ? const Value.absent()
          : Value(painLocations),
    );
  }

  factory SymptomLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      painLevel: serializer.fromJson<int>(json['painLevel']),
      moods: serializer.fromJson<String>(json['moods']),
      physicalSymptoms: serializer.fromJson<String>(json['physicalSymptoms']),
      notes: serializer.fromJson<String>(json['notes']),
      acneSeverity: serializer.fromJson<int?>(json['acneSeverity']),
      weight: serializer.fromJson<double?>(json['weight']),
      hairLoss: serializer.fromJson<bool?>(json['hairLoss']),
      painLocations: serializer.fromJson<String?>(json['painLocations']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'painLevel': serializer.toJson<int>(painLevel),
      'moods': serializer.toJson<String>(moods),
      'physicalSymptoms': serializer.toJson<String>(physicalSymptoms),
      'notes': serializer.toJson<String>(notes),
      'acneSeverity': serializer.toJson<int?>(acneSeverity),
      'weight': serializer.toJson<double?>(weight),
      'hairLoss': serializer.toJson<bool?>(hairLoss),
      'painLocations': serializer.toJson<String?>(painLocations),
    };
  }

  SymptomLog copyWith(
          {int? id,
          DateTime? date,
          int? painLevel,
          String? moods,
          String? physicalSymptoms,
          String? notes,
          Value<int?> acneSeverity = const Value.absent(),
          Value<double?> weight = const Value.absent(),
          Value<bool?> hairLoss = const Value.absent(),
          Value<String?> painLocations = const Value.absent()}) =>
      SymptomLog(
        id: id ?? this.id,
        date: date ?? this.date,
        painLevel: painLevel ?? this.painLevel,
        moods: moods ?? this.moods,
        physicalSymptoms: physicalSymptoms ?? this.physicalSymptoms,
        notes: notes ?? this.notes,
        acneSeverity:
            acneSeverity.present ? acneSeverity.value : this.acneSeverity,
        weight: weight.present ? weight.value : this.weight,
        hairLoss: hairLoss.present ? hairLoss.value : this.hairLoss,
        painLocations:
            painLocations.present ? painLocations.value : this.painLocations,
      );
  SymptomLog copyWithCompanion(SymptomsCompanion data) {
    return SymptomLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      painLevel: data.painLevel.present ? data.painLevel.value : this.painLevel,
      moods: data.moods.present ? data.moods.value : this.moods,
      physicalSymptoms: data.physicalSymptoms.present
          ? data.physicalSymptoms.value
          : this.physicalSymptoms,
      notes: data.notes.present ? data.notes.value : this.notes,
      acneSeverity: data.acneSeverity.present
          ? data.acneSeverity.value
          : this.acneSeverity,
      weight: data.weight.present ? data.weight.value : this.weight,
      hairLoss: data.hairLoss.present ? data.hairLoss.value : this.hairLoss,
      painLocations: data.painLocations.present
          ? data.painLocations.value
          : this.painLocations,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('painLevel: $painLevel, ')
          ..write('moods: $moods, ')
          ..write('physicalSymptoms: $physicalSymptoms, ')
          ..write('notes: $notes, ')
          ..write('acneSeverity: $acneSeverity, ')
          ..write('weight: $weight, ')
          ..write('hairLoss: $hairLoss, ')
          ..write('painLocations: $painLocations')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, painLevel, moods, physicalSymptoms,
      notes, acneSeverity, weight, hairLoss, painLocations);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.painLevel == this.painLevel &&
          other.moods == this.moods &&
          other.physicalSymptoms == this.physicalSymptoms &&
          other.notes == this.notes &&
          other.acneSeverity == this.acneSeverity &&
          other.weight == this.weight &&
          other.hairLoss == this.hairLoss &&
          other.painLocations == this.painLocations);
}

class SymptomsCompanion extends UpdateCompanion<SymptomLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> painLevel;
  final Value<String> moods;
  final Value<String> physicalSymptoms;
  final Value<String> notes;
  final Value<int?> acneSeverity;
  final Value<double?> weight;
  final Value<bool?> hairLoss;
  final Value<String?> painLocations;
  const SymptomsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.painLevel = const Value.absent(),
    this.moods = const Value.absent(),
    this.physicalSymptoms = const Value.absent(),
    this.notes = const Value.absent(),
    this.acneSeverity = const Value.absent(),
    this.weight = const Value.absent(),
    this.hairLoss = const Value.absent(),
    this.painLocations = const Value.absent(),
  });
  SymptomsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.painLevel = const Value.absent(),
    this.moods = const Value.absent(),
    this.physicalSymptoms = const Value.absent(),
    this.notes = const Value.absent(),
    this.acneSeverity = const Value.absent(),
    this.weight = const Value.absent(),
    this.hairLoss = const Value.absent(),
    this.painLocations = const Value.absent(),
  }) : date = Value(date);
  static Insertable<SymptomLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? painLevel,
    Expression<String>? moods,
    Expression<String>? physicalSymptoms,
    Expression<String>? notes,
    Expression<int>? acneSeverity,
    Expression<double>? weight,
    Expression<bool>? hairLoss,
    Expression<String>? painLocations,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (painLevel != null) 'pain_level': painLevel,
      if (moods != null) 'moods': moods,
      if (physicalSymptoms != null) 'physical_symptoms': physicalSymptoms,
      if (notes != null) 'notes': notes,
      if (acneSeverity != null) 'acne_severity': acneSeverity,
      if (weight != null) 'weight': weight,
      if (hairLoss != null) 'hair_loss': hairLoss,
      if (painLocations != null) 'pain_locations': painLocations,
    });
  }

  SymptomsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? painLevel,
      Value<String>? moods,
      Value<String>? physicalSymptoms,
      Value<String>? notes,
      Value<int?>? acneSeverity,
      Value<double?>? weight,
      Value<bool?>? hairLoss,
      Value<String?>? painLocations}) {
    return SymptomsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      painLevel: painLevel ?? this.painLevel,
      moods: moods ?? this.moods,
      physicalSymptoms: physicalSymptoms ?? this.physicalSymptoms,
      notes: notes ?? this.notes,
      acneSeverity: acneSeverity ?? this.acneSeverity,
      weight: weight ?? this.weight,
      hairLoss: hairLoss ?? this.hairLoss,
      painLocations: painLocations ?? this.painLocations,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (painLevel.present) {
      map['pain_level'] = Variable<int>(painLevel.value);
    }
    if (moods.present) {
      map['moods'] = Variable<String>(moods.value);
    }
    if (physicalSymptoms.present) {
      map['physical_symptoms'] = Variable<String>(physicalSymptoms.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (acneSeverity.present) {
      map['acne_severity'] = Variable<int>(acneSeverity.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (hairLoss.present) {
      map['hair_loss'] = Variable<bool>(hairLoss.value);
    }
    if (painLocations.present) {
      map['pain_locations'] = Variable<String>(painLocations.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('painLevel: $painLevel, ')
          ..write('moods: $moods, ')
          ..write('physicalSymptoms: $physicalSymptoms, ')
          ..write('notes: $notes, ')
          ..write('acneSeverity: $acneSeverity, ')
          ..write('weight: $weight, ')
          ..write('hairLoss: $hairLoss, ')
          ..write('painLocations: $painLocations')
          ..write(')'))
        .toString();
  }
}

class $NutritionLogsTable extends NutritionLogs
    with TableInfo<$NutritionLogsTable, NutritionLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _waterCupsMeta =
      const VerificationMeta('waterCups');
  @override
  late final GeneratedColumn<int> waterCups = GeneratedColumn<int>(
      'water_cups', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _foodIdsMeta =
      const VerificationMeta('foodIds');
  @override
  late final GeneratedColumn<String> foodIds = GeneratedColumn<String>(
      'food_ids', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  @override
  List<GeneratedColumn> get $columns => [date, waterCups, foodIds];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_logs';
  @override
  VerificationContext validateIntegrity(Insertable<NutritionLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('water_cups')) {
      context.handle(_waterCupsMeta,
          waterCups.isAcceptableOrUnknown(data['water_cups']!, _waterCupsMeta));
    }
    if (data.containsKey('food_ids')) {
      context.handle(_foodIdsMeta,
          foodIds.isAcceptableOrUnknown(data['food_ids']!, _foodIdsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  NutritionLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionLog(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      waterCups: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}water_cups'])!,
      foodIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_ids'])!,
    );
  }

  @override
  $NutritionLogsTable createAlias(String alias) {
    return $NutritionLogsTable(attachedDatabase, alias);
  }
}

class NutritionLog extends DataClass implements Insertable<NutritionLog> {
  final DateTime date;
  final int waterCups;
  final String foodIds;
  const NutritionLog(
      {required this.date, required this.waterCups, required this.foodIds});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['water_cups'] = Variable<int>(waterCups);
    map['food_ids'] = Variable<String>(foodIds);
    return map;
  }

  NutritionLogsCompanion toCompanion(bool nullToAbsent) {
    return NutritionLogsCompanion(
      date: Value(date),
      waterCups: Value(waterCups),
      foodIds: Value(foodIds),
    );
  }

  factory NutritionLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionLog(
      date: serializer.fromJson<DateTime>(json['date']),
      waterCups: serializer.fromJson<int>(json['waterCups']),
      foodIds: serializer.fromJson<String>(json['foodIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'waterCups': serializer.toJson<int>(waterCups),
      'foodIds': serializer.toJson<String>(foodIds),
    };
  }

  NutritionLog copyWith({DateTime? date, int? waterCups, String? foodIds}) =>
      NutritionLog(
        date: date ?? this.date,
        waterCups: waterCups ?? this.waterCups,
        foodIds: foodIds ?? this.foodIds,
      );
  NutritionLog copyWithCompanion(NutritionLogsCompanion data) {
    return NutritionLog(
      date: data.date.present ? data.date.value : this.date,
      waterCups: data.waterCups.present ? data.waterCups.value : this.waterCups,
      foodIds: data.foodIds.present ? data.foodIds.value : this.foodIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionLog(')
          ..write('date: $date, ')
          ..write('waterCups: $waterCups, ')
          ..write('foodIds: $foodIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, waterCups, foodIds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionLog &&
          other.date == this.date &&
          other.waterCups == this.waterCups &&
          other.foodIds == this.foodIds);
}

class NutritionLogsCompanion extends UpdateCompanion<NutritionLog> {
  final Value<DateTime> date;
  final Value<int> waterCups;
  final Value<String> foodIds;
  final Value<int> rowid;
  const NutritionLogsCompanion({
    this.date = const Value.absent(),
    this.waterCups = const Value.absent(),
    this.foodIds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NutritionLogsCompanion.insert({
    required DateTime date,
    this.waterCups = const Value.absent(),
    this.foodIds = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<NutritionLog> custom({
    Expression<DateTime>? date,
    Expression<int>? waterCups,
    Expression<String>? foodIds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (waterCups != null) 'water_cups': waterCups,
      if (foodIds != null) 'food_ids': foodIds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NutritionLogsCompanion copyWith(
      {Value<DateTime>? date,
      Value<int>? waterCups,
      Value<String>? foodIds,
      Value<int>? rowid}) {
    return NutritionLogsCompanion(
      date: date ?? this.date,
      waterCups: waterCups ?? this.waterCups,
      foodIds: foodIds ?? this.foodIds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (waterCups.present) {
      map['water_cups'] = Variable<int>(waterCups.value);
    }
    if (foodIds.present) {
      map['food_ids'] = Variable<String>(foodIds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionLogsCompanion(')
          ..write('date: $date, ')
          ..write('waterCups: $waterCups, ')
          ..write('foodIds: $foodIds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SymptomsTable symptoms = $SymptomsTable(this);
  late final $NutritionLogsTable nutritionLogs = $NutritionLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [symptoms, nutritionLogs];
}

typedef $$SymptomsTableCreateCompanionBuilder = SymptomsCompanion Function({
  Value<int> id,
  required DateTime date,
  Value<int> painLevel,
  Value<String> moods,
  Value<String> physicalSymptoms,
  Value<String> notes,
  Value<int?> acneSeverity,
  Value<double?> weight,
  Value<bool?> hairLoss,
  Value<String?> painLocations,
});
typedef $$SymptomsTableUpdateCompanionBuilder = SymptomsCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<int> painLevel,
  Value<String> moods,
  Value<String> physicalSymptoms,
  Value<String> notes,
  Value<int?> acneSeverity,
  Value<double?> weight,
  Value<bool?> hairLoss,
  Value<String?> painLocations,
});

class $$SymptomsTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get painLevel => $composableBuilder(
      column: $table.painLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get moods => $composableBuilder(
      column: $table.moods, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get physicalSymptoms => $composableBuilder(
      column: $table.physicalSymptoms,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get acneSeverity => $composableBuilder(
      column: $table.acneSeverity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hairLoss => $composableBuilder(
      column: $table.hairLoss, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get painLocations => $composableBuilder(
      column: $table.painLocations, builder: (column) => ColumnFilters(column));
}

class $$SymptomsTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get painLevel => $composableBuilder(
      column: $table.painLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get moods => $composableBuilder(
      column: $table.moods, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get physicalSymptoms => $composableBuilder(
      column: $table.physicalSymptoms,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get acneSeverity => $composableBuilder(
      column: $table.acneSeverity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hairLoss => $composableBuilder(
      column: $table.hairLoss, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get painLocations => $composableBuilder(
      column: $table.painLocations,
      builder: (column) => ColumnOrderings(column));
}

class $$SymptomsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get painLevel =>
      $composableBuilder(column: $table.painLevel, builder: (column) => column);

  GeneratedColumn<String> get moods =>
      $composableBuilder(column: $table.moods, builder: (column) => column);

  GeneratedColumn<String> get physicalSymptoms => $composableBuilder(
      column: $table.physicalSymptoms, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get acneSeverity => $composableBuilder(
      column: $table.acneSeverity, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<bool> get hairLoss =>
      $composableBuilder(column: $table.hairLoss, builder: (column) => column);

  GeneratedColumn<String> get painLocations => $composableBuilder(
      column: $table.painLocations, builder: (column) => column);
}

class $$SymptomsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymptomsTable,
    SymptomLog,
    $$SymptomsTableFilterComposer,
    $$SymptomsTableOrderingComposer,
    $$SymptomsTableAnnotationComposer,
    $$SymptomsTableCreateCompanionBuilder,
    $$SymptomsTableUpdateCompanionBuilder,
    (SymptomLog, BaseReferences<_$AppDatabase, $SymptomsTable, SymptomLog>),
    SymptomLog,
    PrefetchHooks Function()> {
  $$SymptomsTableTableManager(_$AppDatabase db, $SymptomsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> painLevel = const Value.absent(),
            Value<String> moods = const Value.absent(),
            Value<String> physicalSymptoms = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<int?> acneSeverity = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<bool?> hairLoss = const Value.absent(),
            Value<String?> painLocations = const Value.absent(),
          }) =>
              SymptomsCompanion(
            id: id,
            date: date,
            painLevel: painLevel,
            moods: moods,
            physicalSymptoms: physicalSymptoms,
            notes: notes,
            acneSeverity: acneSeverity,
            weight: weight,
            hairLoss: hairLoss,
            painLocations: painLocations,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            Value<int> painLevel = const Value.absent(),
            Value<String> moods = const Value.absent(),
            Value<String> physicalSymptoms = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<int?> acneSeverity = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<bool?> hairLoss = const Value.absent(),
            Value<String?> painLocations = const Value.absent(),
          }) =>
              SymptomsCompanion.insert(
            id: id,
            date: date,
            painLevel: painLevel,
            moods: moods,
            physicalSymptoms: physicalSymptoms,
            notes: notes,
            acneSeverity: acneSeverity,
            weight: weight,
            hairLoss: hairLoss,
            painLocations: painLocations,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SymptomsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SymptomsTable,
    SymptomLog,
    $$SymptomsTableFilterComposer,
    $$SymptomsTableOrderingComposer,
    $$SymptomsTableAnnotationComposer,
    $$SymptomsTableCreateCompanionBuilder,
    $$SymptomsTableUpdateCompanionBuilder,
    (SymptomLog, BaseReferences<_$AppDatabase, $SymptomsTable, SymptomLog>),
    SymptomLog,
    PrefetchHooks Function()>;
typedef $$NutritionLogsTableCreateCompanionBuilder = NutritionLogsCompanion
    Function({
  required DateTime date,
  Value<int> waterCups,
  Value<String> foodIds,
  Value<int> rowid,
});
typedef $$NutritionLogsTableUpdateCompanionBuilder = NutritionLogsCompanion
    Function({
  Value<DateTime> date,
  Value<int> waterCups,
  Value<String> foodIds,
  Value<int> rowid,
});

class $$NutritionLogsTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionLogsTable> {
  $$NutritionLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get waterCups => $composableBuilder(
      column: $table.waterCups, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodIds => $composableBuilder(
      column: $table.foodIds, builder: (column) => ColumnFilters(column));
}

class $$NutritionLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionLogsTable> {
  $$NutritionLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get waterCups => $composableBuilder(
      column: $table.waterCups, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodIds => $composableBuilder(
      column: $table.foodIds, builder: (column) => ColumnOrderings(column));
}

class $$NutritionLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionLogsTable> {
  $$NutritionLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get waterCups =>
      $composableBuilder(column: $table.waterCups, builder: (column) => column);

  GeneratedColumn<String> get foodIds =>
      $composableBuilder(column: $table.foodIds, builder: (column) => column);
}

class $$NutritionLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NutritionLogsTable,
    NutritionLog,
    $$NutritionLogsTableFilterComposer,
    $$NutritionLogsTableOrderingComposer,
    $$NutritionLogsTableAnnotationComposer,
    $$NutritionLogsTableCreateCompanionBuilder,
    $$NutritionLogsTableUpdateCompanionBuilder,
    (
      NutritionLog,
      BaseReferences<_$AppDatabase, $NutritionLogsTable, NutritionLog>
    ),
    NutritionLog,
    PrefetchHooks Function()> {
  $$NutritionLogsTableTableManager(_$AppDatabase db, $NutritionLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> date = const Value.absent(),
            Value<int> waterCups = const Value.absent(),
            Value<String> foodIds = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NutritionLogsCompanion(
            date: date,
            waterCups: waterCups,
            foodIds: foodIds,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime date,
            Value<int> waterCups = const Value.absent(),
            Value<String> foodIds = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NutritionLogsCompanion.insert(
            date: date,
            waterCups: waterCups,
            foodIds: foodIds,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NutritionLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NutritionLogsTable,
    NutritionLog,
    $$NutritionLogsTableFilterComposer,
    $$NutritionLogsTableOrderingComposer,
    $$NutritionLogsTableAnnotationComposer,
    $$NutritionLogsTableCreateCompanionBuilder,
    $$NutritionLogsTableUpdateCompanionBuilder,
    (
      NutritionLog,
      BaseReferences<_$AppDatabase, $NutritionLogsTable, NutritionLog>
    ),
    NutritionLog,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SymptomsTableTableManager get symptoms =>
      $$SymptomsTableTableManager(_db, _db.symptoms);
  $$NutritionLogsTableTableManager get nutritionLogs =>
      $$NutritionLogsTableTableManager(_db, _db.nutritionLogs);
}
