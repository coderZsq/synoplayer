import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/logger.dart';

part 'credentials_service.freezed.dart';
part 'credentials_service.g.dart';

/// 登录凭据模型
@freezed
class LoginCredentials with _$LoginCredentials {
  const factory LoginCredentials({
    required String quickConnectId,
    required String username,
    required String password,
    String? workingAddress,
    String? sid,
    DateTime? loginTime,
    @Default(true) bool rememberCredentials,
  }) = _LoginCredentials;

  factory LoginCredentials.fromJson(Map<String, dynamic> json) =>
      _$LoginCredentialsFromJson(json);
}

/// 会话状态枚举
enum SessionStatus {
  valid,      // 会话有效
  expired,    // 会话过期
  invalid,    // 会话无效
  notFound,   // 未找到会话
}

/// 凭据服务 - 管理用户登录凭据和会话
class CredentialsService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // 存储键名
  static const String _quickConnectIdKey = 'quickconnect_id';
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';
  static const String _workingAddressKey = 'working_address';
  static const String _sidKey = 'session_id';
  static const String _loginTimeKey = 'login_time';
  static const String _rememberCredentialsKey = 'remember_credentials';

  // 会话配置
  static const Duration _sessionTimeout = Duration(hours: 24);

  /// 保存完整的登录凭据
  Future<void> saveCredentials(LoginCredentials credentials) async {
    try {
      AppLogger.debug('🔧 开始保存凭据，rememberCredentials: ${credentials.rememberCredentials}');
      
      if (credentials.rememberCredentials) {
        AppLogger.debug('🔧 准备保存以下数据:');
        AppLogger.debug('  - QuickConnect ID: ${credentials.quickConnectId}');
        AppLogger.debug('  - Username: ${credentials.username}');
        AppLogger.debug('  - Working Address: ${credentials.workingAddress}');
        AppLogger.debug('  - SID: ${credentials.sid}');
        AppLogger.debug('  - Login Time: ${credentials.loginTime}');
        
        final futures = <Future<void>>[
          _storage.write(key: _quickConnectIdKey, value: credentials.quickConnectId),
          _storage.write(key: _usernameKey, value: credentials.username),
          _storage.write(key: _passwordKey, value: credentials.password),
          _storage.write(key: _rememberCredentialsKey, value: 'true'),
        ];

        // 可选字段
        if (credentials.workingAddress != null) {
          futures.add(_storage.write(
            key: _workingAddressKey,
            value: credentials.workingAddress!,
          ));
        }

        if (credentials.sid != null) {
          futures.add(_storage.write(key: _sidKey, value: credentials.sid!));
        }

        if (credentials.loginTime != null) {
          futures.add(_storage.write(
            key: _loginTimeKey,
            value: credentials.loginTime!.millisecondsSinceEpoch.toString(),
          ));
        }

        await Future.wait(futures);
        AppLogger.info('✅ 登录凭据已保存成功');
      } else {
        await clearCredentials();
        AppLogger.info('未选择记住凭据，已清除所有保存的数据');
      }
    } catch (e, stackTrace) {
      AppLogger.error('保存凭据失败', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// 更新会话信息
  Future<void> updateSession({
    required String sid,
    DateTime? loginTime,
  }) async {
    try {
      await Future.wait([
        _storage.write(key: _sidKey, value: sid),
        _storage.write(
          key: _loginTimeKey,
          value: (loginTime ?? DateTime.now()).millisecondsSinceEpoch.toString(),
        ),
      ]);
      AppLogger.info('会话信息已更新');
    } catch (e, stackTrace) {
      AppLogger.error('更新会话失败', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// 获取保存的登录凭据
  Future<LoginCredentials?> getCredentials() async {
    try {
      AppLogger.debug('🔍 开始读取保存的凭据...');
      
      final values = await Future.wait([
        _storage.read(key: _quickConnectIdKey),
        _storage.read(key: _usernameKey),
        _storage.read(key: _passwordKey),
        _storage.read(key: _workingAddressKey),
        _storage.read(key: _sidKey),
        _storage.read(key: _loginTimeKey),
        _storage.read(key: _rememberCredentialsKey),
      ]);

      final quickConnectId = values[0];
      final username = values[1];
      final password = values[2];
      final workingAddress = values[3];
      final sid = values[4];
      final loginTimeStr = values[5];
      final rememberCredentials = values[6];

      AppLogger.debug('🔍 读取到的原始数据:');
      AppLogger.debug('  - QuickConnect ID: $quickConnectId');
      AppLogger.debug('  - Username: $username');
      AppLogger.debug('  - Password: ${password != null ? "***有密码***" : "null"}');
      AppLogger.debug('  - Working Address: $workingAddress');
      AppLogger.debug('  - SID: $sid');
      AppLogger.debug('  - Login Time: $loginTimeStr');
      AppLogger.debug('  - Remember Credentials: $rememberCredentials');

      // 检查必需字段
      if (quickConnectId == null || 
          username == null || 
          password == null ||
          rememberCredentials != 'true') {
        AppLogger.warning('⚠️ 必需字段缺失或用户未选择记住凭据');
        AppLogger.debug('检查结果: quickConnectId=$quickConnectId, username=$username, password=${password != null}, rememberCredentials=$rememberCredentials');
        return null;
      }

      DateTime? loginTime;
      if (loginTimeStr != null) {
        final timestamp = int.tryParse(loginTimeStr);
        if (timestamp != null) {
          loginTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        }
      }

      final credentials = LoginCredentials(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        workingAddress: workingAddress,
        sid: sid,
        loginTime: loginTime,
        rememberCredentials: true,
      );
      
      AppLogger.info('✅ 成功读取保存的凭据');
      return credentials;
    } catch (e, stackTrace) {
      AppLogger.error('获取凭据失败', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// 检查是否有保存的凭据
  Future<bool> hasSavedCredentials() async {
    final credentials = await getCredentials();
    return credentials != null;
  }

  /// 检查会话状态
  Future<SessionStatus> checkSessionStatus() async {
    try {
      final credentials = await getCredentials();
      
      if (credentials?.sid == null) {
        return SessionStatus.notFound;
      }

      if (credentials?.loginTime == null) {
        return SessionStatus.invalid;
      }

      final now = DateTime.now();
      final timeDifference = now.difference(credentials!.loginTime!);

      if (timeDifference > _sessionTimeout) {
        AppLogger.info('会话已过期: ${timeDifference.inHours} 小时');
        return SessionStatus.expired;
      }

      return SessionStatus.valid;
    } catch (e, stackTrace) {
      AppLogger.error('检查会话状态失败', error: e, stackTrace: stackTrace);
      return SessionStatus.invalid;
    }
  }

  /// 检查是否有有效会话
  Future<bool> hasValidSession() async {
    final status = await checkSessionStatus();
    return status == SessionStatus.valid;
  }

  /// 清除会话信息（保留基本凭据）
  Future<void> clearSession() async {
    try {
      await Future.wait([
        _storage.delete(key: _sidKey),
        _storage.delete(key: _loginTimeKey),
      ]);
      AppLogger.info('会话信息已清除');
    } catch (e, stackTrace) {
      AppLogger.error('清除会话失败', error: e, stackTrace: stackTrace);
    }
  }

  /// 清除所有保存的凭据
  Future<void> clearCredentials() async {
    try {
      await Future.wait([
        _storage.delete(key: _quickConnectIdKey),
        _storage.delete(key: _usernameKey),
        _storage.delete(key: _passwordKey),
        _storage.delete(key: _workingAddressKey),
        _storage.delete(key: _sidKey),
        _storage.delete(key: _loginTimeKey),
        _storage.delete(key: _rememberCredentialsKey),
      ]);
      AppLogger.info('所有凭据已清除');
    } catch (e, stackTrace) {
      AppLogger.error('清除凭据失败', error: e, stackTrace: stackTrace);
    }
  }

  /// 获取当前会话 ID
  Future<String?> getCurrentSessionId() async {
    try {
      return await _storage.read(key: _sidKey);
    } catch (e, stackTrace) {
      AppLogger.error('获取会话ID失败', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// 验证凭据完整性
  Future<bool> validateCredentials(LoginCredentials credentials) async {
    return credentials.quickConnectId.isNotEmpty &&
           credentials.username.isNotEmpty &&
           credentials.password.isNotEmpty;
  }

  /// 获取会话过期时间
  Future<DateTime?> getSessionExpiryTime() async {
    final credentials = await getCredentials();
    if (credentials?.loginTime != null) {
      return credentials!.loginTime!.add(_sessionTimeout);
    }
    return null;
  }

  /// 获取会话剩余时间
  Future<Duration?> getSessionRemainingTime() async {
    final expiryTime = await getSessionExpiryTime();
    if (expiryTime != null) {
      final remaining = expiryTime.difference(DateTime.now());
      return remaining.isNegative ? Duration.zero : remaining;
    }
    return null;
  }

  /// 测试存储功能 (调试用)
  Future<bool> testStorage() async {
    try {
      const testKey = 'test_key';
      final testValue = 'test_value_${DateTime.now().millisecondsSinceEpoch}';
      
      AppLogger.debug('🧪 开始测试存储功能...');
      
      // 1. 写入测试数据
      await _storage.write(key: testKey, value: testValue);
      AppLogger.debug('✅ 写入测试数据: $testValue');
      
      // 2. 读取测试数据
      final readValue = await _storage.read(key: testKey);
      AppLogger.debug('🔍 读取到的数据: $readValue');
      
      // 3. 验证数据一致性
      final isValid = readValue == testValue;
      AppLogger.debug('🎯 数据一致性验证: $isValid');
      
      // 4. 清理测试数据
      await _storage.delete(key: testKey);
      AppLogger.debug('🗑️ 清理测试数据完成');
      
      return isValid;
    } catch (e, stackTrace) {
      AppLogger.error('🚨 存储测试失败', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// 测试凭据保存功能 (调试用)
  Future<bool> testCredentialsSave() async {
    try {
      AppLogger.debug('🧪 开始测试凭据保存功能...');
      
      // 创建测试凭据
      final testCredentials = LoginCredentials(
        quickConnectId: 'test_id_${DateTime.now().millisecondsSinceEpoch}',
        username: 'test_user',
        password: 'test_password',
        workingAddress: 'https://test.synology.com',
        sid: 'test_sid_123',
        loginTime: DateTime.now(),
        rememberCredentials: true,
      );
      
      AppLogger.debug('💾 保存测试凭据...');
      await saveCredentials(testCredentials);
      
      AppLogger.debug('🔍 读取测试凭据...');
      final savedCredentials = await getCredentials();
      
      if (savedCredentials != null) {
        AppLogger.debug('✅ 测试凭据读取成功: ${savedCredentials.quickConnectId}');
        
        // 清理测试数据
        await clearCredentials();
        AppLogger.debug('🗑️ 清理测试凭据完成');
        
        return true;
      } else {
        AppLogger.error('❌ 测试凭据读取失败');
        return false;
      }
    } catch (e, stackTrace) {
      AppLogger.error('🚨 凭据保存测试失败', error: e, stackTrace: stackTrace);
      return false;
    }
  }
}

/// 凭据服务 Provider
@riverpod
CredentialsService credentialsService(Ref ref) {
  return CredentialsService();
}

/// 当前登录凭据 Provider
@riverpod
Future<LoginCredentials?> currentCredentials(Ref ref) async {
  final service = ref.read(credentialsServiceProvider);
  return await service.getCredentials();
}

/// 会话状态 Provider
@riverpod
Future<SessionStatus> sessionStatus(Ref ref) async {
  final service = ref.read(credentialsServiceProvider);
  return await service.checkSessionStatus();
}

/// 是否已登录 Provider
@riverpod
Future<bool> isLoggedIn(Ref ref) async {
  final service = ref.read(credentialsServiceProvider);
  return await service.hasValidSession();
}

/// 当前会话 ID Provider
@riverpod
Future<String?> currentSessionId(Ref ref) async {
  final service = ref.read(credentialsServiceProvider);
  return await service.getCurrentSessionId();
}
