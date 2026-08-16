import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

/// Service to handle secure storage of the encryption key.
class SecureStorageService {
  static const String _encryptionKeyName = 'shustho_encryption_key';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  /// Retrieves the existing encryption key or generates a new one.
  Future<List<int>> getEncryptionKey() async {
    final String? encodedKey = await _secureStorage.read(key: _encryptionKeyName);
    
    if (encodedKey != null) {
      return base64Url.decode(encodedKey);
    } else {
      // Generate a new 256-bit AES key and save it securely.
      final key = Hive.generateSecureKey();
      await _secureStorage.write(
        key: _encryptionKeyName,
        value: base64Url.encode(key),
      );
      return key;
    }
  }

  /// Clears the stored encryption key (e.g., for a full app reset).
  Future<void> clearKey() async {
    await _secureStorage.delete(key: _encryptionKeyName);
  }
}
