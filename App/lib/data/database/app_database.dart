import 'package:drift/drift.dart';
import 'connection/connection.dart' as impl;

part 'app_database.g.dart';

@DataClassName('SymptomLog')
class Symptoms extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().unique()();

  // Basic tracking
  IntColumn get painLevel => integer().withDefault(const Constant(0))();
  TextColumn get moods => text().withDefault(const Constant('[]'))();
  TextColumn get physicalSymptoms => text().withDefault(const Constant('[]'))();
  TextColumn get notes => text().withDefault(const Constant(''))();

  // Future: PCOS / Endometriosis advanced tracking
  IntColumn get acneSeverity => integer().nullable()();
  RealColumn get weight => real().nullable()();
  BoolColumn get hairLoss => boolean().nullable()();
  TextColumn get painLocations => text().nullable()();
}

@DataClassName('NutritionLog')
class NutritionLogs extends Table {
  DateTimeColumn get date => dateTime()();
  IntColumn get waterCups => integer().withDefault(const Constant(0))();
  TextColumn get foodIds => text().withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {date};
}

@DriftDatabase(tables: [Symptoms, NutritionLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase(List<int> encryptionKey) : super(impl.openConnection(encryptionKey));

  @override
  int get schemaVersion => 1;
}
