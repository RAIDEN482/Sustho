// ignore_for_file: deprecated_member_use

import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor openConnection(List<int> encryptionKey) {
  return LazyDatabase(() async {
    try {
      final storage = DriftWebStorage.indexedDb('shustho_db');
      return WebDatabase.withStorage(storage);
    } catch (_) {
      return WebDatabase('shustho_db');
    }
  });
}
