import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'core/utils/logger.dart';

class CredentialsService {
  static const _storage = FlutterSecureStorage();
  
  // 存储键名
  static const String _quickConnectIdKey = 'quickconnect_id';
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';
  static const String _workingAddressKey = 'working_address';
  static const String _rememberCredentialsKey = 'remember_credentials';
  static const String _sidKey = 'session_id'; // 新增：会话ID
  static const String _loginTimeKey = 'login_time'; // 新增：登录时间
  
  /// 保存登录凭据
  static Future<void> saveCredentials({
    required String quickConnectId,
    required String username,
    required String password,
    String? workingAddress,
    String? sid, // 新增：会话ID
    bool rememberCredentials = true,
  }) async {
    try {
      if (rememberCredentials) {
        await _storage.write(key: _quickConnectIdKey, value: quickConnectId);
        await _storage.write(key: _usernameKey, value: username);
        await _storage.write(key: _passwordKey, value: password);
        if (workingAddress != null) {
          await _storage.write(key: _workingAddressKey, value: workingAddress);
        }
        if (sid != null) {
          await _storage.write(key: _sidKey, value: sid);
          await _storage.write(key: _loginTimeKey, value: DateTime.now().millisecondsSinceEpoch.toString());
        }
        await _storage.write(key: _rememberCredentialsKey, value: 'true');
      } else {
        // 如果不记住凭据，清除所有保存的数据
        await clearCredentials();
      }
    } catch (e) {
      AppLogger.error('保存凭据失败: $e');
    }
  }
  
  /// 获取保存的登录凭据
  static Future<Map<String, String?>> getCredentials() async {
    try {
      final quickConnectId = await _storage.read(key: _quickConnectIdKey);
      final username = await _storage.read(key: _usernameKey);
      final password = await _storage.read(key: _passwordKey);
      final workingAddress = await _storage.read(key: _workingAddressKey);
      final rememberCredentials = await _storage.read(key: _rememberCredentialsKey);
      final sid = await _storage.read(key: _sidKey); // 新增：会话ID
      final loginTime = await _storage.read(key: _loginTimeKey); // 新增：登录时间
      
      return {
        'quickConnectId': quickConnectId,
        'username': username,
        'password': password,
        'workingAddress': workingAddress,
        'rememberCredentials': rememberCredentials,
        'sid': sid, // 新增：会话ID
        'loginTime': loginTime, // 新增：登录时间
      };
    } catch (e) {
      AppLogger.error('获取凭据失败: $e');
      return {};
    }
  }
  
  /// 检查是否有保存的凭据
  static Future<bool> hasSavedCredentials() async {
    try {
      final credentials = await getCredentials();
      final hasCredentials = credentials['username'] != null && 
                           credentials['password'] != null &&
                           credentials['rememberCredentials'] == 'true';
      return hasCredentials;
    } catch (e) {
      return false;
    }
  }
  
  /// 检查是否有有效的会话
  static Future<bool> hasValidSession() async {
    try {
      final credentials = await getCredentials();
      final sid = credentials['sid'];
      final loginTime = credentials['loginTime'];
      
      if (sid == null || loginTime == null) {
        return false;
      }
      
      // 检查会话是否过期（24小时）
      final loginTimestamp = int.tryParse(loginTime) ?? 0;
      final loginDateTime = DateTime.fromMillisecondsSinceEpoch(loginTimestamp);
      final now = DateTime.now();
      final difference = now.difference(loginDateTime);
      
      // 会话有效期24小时
      return difference.inHours < 24;
    } catch (e) {
      return false;
    }
  }
  
  /// 清除所有保存的凭据
  static Future<void> clearCredentials() async {
    try {
      await _storage.delete(key: _quickConnectIdKey);
      await _storage.delete(key: _usernameKey);
      await _storage.delete(key: _passwordKey);
      await _storage.delete(key: _workingAddressKey);
      await _storage.delete(key: _rememberCredentialsKey);
      await _storage.delete(key: _sidKey); // 新增：清除会话ID
      await _storage.delete(key: _loginTimeKey); // 新增：清除登录时间
    } catch (e) {
      AppLogger.error('清除凭据失败: $e');
    }
  }
  
  /// 自动登录
  static Future<Map<String, String?>> autoLogin() async {
    try {
      if (await hasSavedCredentials()) {
        return await getCredentials();
      }
      return {};
    } catch (e) {
      AppLogger.error('自动登录失败: $e');
      return {};
    }
  }
  
  /// 验证会话是否有效
  static Future<bool> validateSession(String baseUrl) async {
    try {
      final credentials = await getCredentials();
      final sid = credentials['sid'];
      
      if (sid == null || sid.isEmpty) {
        AppLogger.error('会话ID为空');
        return false;
      }
      
      // TODO: 这里应该添加实际的会话验证逻辑
      // 例如调用群晖API验证SID是否有效
      // 暂时基于时间验证会话是否过期
      return await hasValidSession();
    } catch (e) {
      AppLogger.error('验证会话失败: $e');
      return false;
    }
  }
}
