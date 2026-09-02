import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

/// Service to handle secure storage of the encryption key.
class SecureStorageService {
  static const String _encryptionKeyName = 'shustho_encryption_key';

  /// Retrieves the existing encryption key or generates a new one.
  Future<List<int>> getEncryptionKey() async {
    // On web, flutter_secure_storage can hang or behave unreliably.
    // Use a deterministic fallback key (web data is sandboxed by origin anyway).
    if (kIsWeb) {
      return _webFallbackKey();
    }

    final secureStorage = const FlutterSecureStorage();
    final String? encodedKey = await secureStorage.read(key: _encryptionKeyName);
    
    if (encodedKey != null) {
      return base64Url.decode(encodedKey);
    } else {
      // Generate a new 256-bit AES key and save it securely.
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: _encryptionKeyName,
        value: base64Url.encode(key),
      );
      return key;
    }
  }

  /// Clears the stored encryption key (e.g., for a full app reset).
  Future<void> clearKey() async {
    if (kIsWeb) return;
    final secureStorage = const FlutterSecureStorage();
    await secureStorage.delete(key: _encryptionKeyName);
  }

  /// Returns a stable 32-byte key for web (browser origin isolation
  /// provides the security boundary; IndexedDB is not truly encrypted).
  static List<int> _webFallbackKey() {
    // Deterministic 32-byte key derived from a fixed seed.
    // Safe because web storage is already sandboxed per origin.
    final seed = utf8.encode('shustho-web-encryption-fallback!'); // 32 bytes
    return seed;
  }
}
