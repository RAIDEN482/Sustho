import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
  AppDatabase(List<int> encryptionKey) : super(_openConnection(encryptionKey));

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection(List<int> encryptionKey) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'shustho_db.sqlite'));

    // Apply SQLCipher encryption pragmas if needed, or rely on encrypted filesystem
    // For sqlite3_flutter_libs, we can use sqlite3.open
    return NativeDatabase.createInBackground(file, setup: (db) {
      // In a real implementation with sqlcipher, we would run:
      // db.execute("PRAGMA key = '${base64Encode(encryptionKey)}';");
    });
  });
}
