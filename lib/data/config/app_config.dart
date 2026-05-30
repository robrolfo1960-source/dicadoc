import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Configurazione persistente del device:
/// - paziente correntemente attivo (impostato dall'onboarding QR)
/// - URL del server di sync (opzionale; assente = modalità offline)
class AppConfig {
  AppConfig._();
  static final AppConfig instance = AppConfig._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    mOptions: MacOsOptions(useDataProtectionKeyChain: false),
  );
  static const _keyPazienteId = 'paziente_id';
  static const _keyPazienteNome = 'paziente_nome';
  static const _keyServerUrl = 'server_url';

  Future<bool> isOnboarded() async =>
      await _storage.read(key: _keyPazienteId) != null;

  Future<int?> getPazienteId() async {
    final s = await _storage.read(key: _keyPazienteId);
    return s != null ? int.tryParse(s) : null;
  }

  Future<String?> getPazienteNome() async =>
      _storage.read(key: _keyPazienteNome);

  Future<String?> getServerUrl() async =>
      _storage.read(key: _keyServerUrl);

  Future<void> setPaziente({
    required int id,
    String? nome,
    String? serverUrl,
  }) async {
    await _storage.write(key: _keyPazienteId, value: id.toString());
    if (nome != null) await _storage.write(key: _keyPazienteNome, value: nome);
    if (serverUrl != null) {
      await _storage.write(key: _keyServerUrl, value: serverUrl);
    }
  }

  Future<void> reset() async => _storage.deleteAll();
}
