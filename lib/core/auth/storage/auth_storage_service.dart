import 'storage_service.dart';

class AuthStorageService {
  static const String _keyQuickConnectId = 'quick_connect_id';
  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';
  static const String _keySessionId = 'session_id';
  static const String _keyRememberPassword = 'remember_password';

  final StorageService _storage;

  AuthStorageService(this._storage);

  /// 保存登录凭证
  Future<void> saveLoginCredentials({
    required String quickConnectId,
    required String username,
    required String password,
    required bool rememberPassword,
  }) async {
    if (rememberPassword) {
      await _storage.saveString(_keyQuickConnectId, quickConnectId);
      await _storage.saveString(_keyUsername, username);
      await _storage.saveString(_keyPassword, password);
      await _storage.saveBool(_keyRememberPassword, true);
    } else {
      await _storage.remove(_keyQuickConnectId);
      await _storage.remove(_keyUsername);
      await _storage.remove(_keyPassword);
      await _storage.saveBool(_keyRememberPassword, false);
    }
  }

  /// 保存会话ID
  Future<void> saveSessionId(String sessionId) async {
    await _storage.saveString(_keySessionId, sessionId);
  }

  /// 获取保存的登录凭证
  Future<Map<String, String?>> getLoginCredentials() async {
    return {
      'quickConnectId': await _storage.getString(_keyQuickConnectId),
      'username': await _storage.getString(_keyUsername),
      'password': await _storage.getString(_keyPassword),
    };
  }

  /// 获取保存的会话ID
  Future<String?> getSessionId() async {
    return await _storage.getString(_keySessionId);
  }

  /// 检查是否应该记住密码
  Future<bool> shouldRememberPassword() async {
    return await _storage.getBool(_keyRememberPassword) ?? false;
  }

  /// 清除所有认证数据
  Future<void> clearAuthData() async {
    await _storage.remove(_keyQuickConnectId);
    await _storage.remove(_keyUsername);
    await _storage.remove(_keyPassword);
    await _storage.remove(_keySessionId);
    await _storage.remove(_keyRememberPassword);
  }

  /// 保存任意字符串数据
  Future<void> saveString(String key, String value) async {
    await _storage.saveString(key, value);
  }

  /// 获取任意字符串数据
  Future<String?> getString(String key) async {
    return await _storage.getString(key);
  }

  /// 移除任意字符串数据
  Future<void> remove(String key) async {
    await _storage.remove(key);
  }
}
