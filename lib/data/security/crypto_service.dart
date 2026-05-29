import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Gestisce la passphrase SQLCipher: generata una volta, custodita nel
/// keystore cifrato del SO (Keychain su iOS, Keystore su Android).
class CryptoService {
  CryptoService._();
  static final CryptoService instance = CryptoService._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  static const _keyPassphrase = 'dicadoc_db_passphrase';

  /// Restituisce la passphrase del DB. Al primo avvio ne genera una nuova
  /// di 32 byte casuali e la persiste nel keystore.
  Future<String> getPassphrase() async {
    var key = await _storage.read(key: _keyPassphrase);
    if (key == null) {
      final bytes =
          List<int>.generate(32, (_) => Random.secure().nextInt(256));
      key = base64UrlEncode(bytes);
      await _storage.write(key: _keyPassphrase, value: key);
    }
    return key;
  }
}
