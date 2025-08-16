import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../services/credentials/credentials_service.dart';
import '../utils/logger.dart';

part 'auth_providers.g.dart';
part 'auth_providers.freezed.dart';

/// 认证状态管理
@riverpod
class AuthNotifier extends _$AuthNotifier {
  // 缓存凭据，避免重复读取
  LoginCredentials? _cachedCredentials;
  bool _hasCheckedSession = false;
  bool _isInitializing = false;
  
  @override
  Future<AuthState> build() async {
    // 防止重复初始化
    if (_isInitializing) {
      AppLogger.info('🔄 AuthNotifier 正在初始化中，跳过重复调用');
      return state.valueOrNull ?? const AuthState.unauthenticated();
    }
    
    _isInitializing = true;
    AppLogger.info('🔐 AuthNotifier 开始初始化认证状态');
    
    try {
      // 如果已有缓存的凭据且已验证过会话，直接返回
      if (_cachedCredentials != null && _hasCheckedSession) {
        AppLogger.info('📋 使用缓存的认证状态');
        return AuthState.authenticated(_cachedCredentials!);
      }
      
      final credentialsService = ref.read(credentialsServiceProvider);
      AppLogger.debug('🔐 凭据服务已获取');
      
      // 只在没有缓存时读取凭据
      if (_cachedCredentials == null) {
        _cachedCredentials = await credentialsService.getCredentials();
        AppLogger.debug('🔐 读取凭据结果: ${_cachedCredentials != null ? "有凭据" : "无凭据"}');
      }
      
      if (_cachedCredentials != null) {
        // 只在没有验证过会话时检查
        if (!_hasCheckedSession) {
          AppLogger.debug('🔐 开始检查会话有效性');
          final hasValidSession = await credentialsService.hasValidSession();
          _hasCheckedSession = true;
          AppLogger.info('🔐 会话有效性检查结果: $hasValidSession');
          
          if (hasValidSession) {
            AppLogger.info('✅ 认证状态: 已认证');
            return AuthState.authenticated(_cachedCredentials!);
          } else {
            // 会话无效，清除凭据和缓存
            await credentialsService.clearCredentials();
            _cachedCredentials = null;
            _hasCheckedSession = false;
            AppLogger.warning('⚠️ 会话已过期，清除凭据和缓存');
          }
        } else {
          // 已验证过会话，直接返回
          AppLogger.info('✅ 使用已验证的缓存凭据');
          return AuthState.authenticated(_cachedCredentials!);
        }
      }
      
      AppLogger.info('❌ 认证状态: 未认证');
      return const AuthState.unauthenticated();
    } catch (error, stackTrace) {
      AppLogger.error('🚨 AuthNotifier 初始化失败', error: error, stackTrace: stackTrace);
      return const AuthState.unauthenticated();
    } finally {
      _isInitializing = false;
    }
  }

  /// 登录
  Future<void> login({
    required String username,
    required String password,
    required String quickConnectId,
    String? workingAddress,
    bool rememberCredentials = true,
  }) async {
    state = const AsyncLoading();
    
    try {
      final credentialsService = ref.read(credentialsServiceProvider);
      
      // 创建凭据对象
      final credentials = LoginCredentials(
        username: username,
        password: password,
        quickConnectId: quickConnectId,
        workingAddress: workingAddress,
        rememberCredentials: rememberCredentials,
      );
      
      // 保存凭据
      await credentialsService.saveCredentials(credentials);
      
      // 更新状态
      state = AsyncData(AuthState.authenticated(credentials));
      
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// 设置会话ID
  Future<void> setSessionId(String sid) async {
    final currentState = state.valueOrNull;
    if (currentState is AuthAuthenticated) {
      final updatedCredentials = currentState.credentials.copyWith(sid: sid);
      state = AsyncData(AuthState.authenticated(updatedCredentials));
      
      // 更新缓存
      _cachedCredentials = updatedCredentials;
      
      // 保存到本地存储
      final credentialsService = ref.read(credentialsServiceProvider);
      await credentialsService.saveCredentials(updatedCredentials);
    }
  }

  /// 登出
  Future<void> logout() async {
    try {
      final credentialsService = ref.read(credentialsServiceProvider);
      await credentialsService.clearCredentials();
      
      // 清除缓存
      _cachedCredentials = null;
      _hasCheckedSession = false;
      
      state = const AsyncData(AuthState.unauthenticated());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// 刷新认证状态
  Future<void> refreshAuthStatus() async {
    try {
      AppLogger.info('🔄 开始刷新认证状态');
      
      // 先设置为加载状态
      state = const AsyncLoading();
      
      // 如果已有缓存且已验证过，直接使用缓存
      if (_cachedCredentials != null && _hasCheckedSession) {
        AppLogger.info('📋 使用缓存的认证状态进行刷新');
        state = AsyncData(AuthState.authenticated(_cachedCredentials!));
        return;
      }
      
      final credentialsService = ref.read(credentialsServiceProvider);
      final credentials = await credentialsService.getCredentials();
      
      if (credentials != null) {
        final hasValidSession = await credentialsService.hasValidSession();
        if (hasValidSession) {
          // 更新缓存
          _cachedCredentials = credentials;
          _hasCheckedSession = true;
          AppLogger.info('✅ 刷新认证状态: 已认证');
          state = AsyncData(AuthState.authenticated(credentials));
          return;
        }
      }
      
      // 清除缓存
      _cachedCredentials = null;
      _hasCheckedSession = false;
      AppLogger.info('❌ 刷新认证状态: 未认证');
      state = const AsyncData(AuthState.unauthenticated());
    } catch (error, stackTrace) {
      AppLogger.error('🚨 刷新认证状态失败', error: error, stackTrace: stackTrace);
      state = AsyncError(error, stackTrace);
    }
  }

  /// 检查凭据是否有效
  Future<bool> hasValidCredentials() async {
    final currentState = state.valueOrNull;
    if (currentState is AuthAuthenticated) {
      final credentialsService = ref.read(credentialsServiceProvider);
      return await credentialsService.hasValidSession();
    }
    return false;
  }

  /// 获取当前用户信息
  LoginCredentials? get currentUser {
    final currentState = state.valueOrNull;
    if (currentState is AuthAuthenticated) {
      return currentState.credentials;
    }
    return null;
  }

  /// 获取当前认证状态
  bool get isAuthenticated {
    final currentState = state.valueOrNull;
    return currentState is AuthAuthenticated;
  }
}

/// 认证状态
@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.authenticated(LoginCredentials credentials) = AuthAuthenticated;
  const factory AuthState.authenticating() = AuthAuthenticating;
}

/// 认证状态扩展方法
extension AuthStateExtension on AuthState {
  /// 是否为已认证状态
  bool get isAuthenticated => this is AuthAuthenticated;
  
  /// 是否为未认证状态
  bool get isUnauthenticated => this is AuthUnauthenticated;
  
  /// 是否为认证中状态
  bool get isAuthenticating => this is AuthAuthenticating;
  
  /// 获取用户凭据（仅在已认证状态下有效）
  LoginCredentials? get credentials {
    if (this is AuthAuthenticated) {
      return (this as AuthAuthenticated).credentials;
    }
    return null;
  }
  
  /// 获取用户名
  String? get username => credentials?.username;
  
  /// 获取 QuickConnect ID
  String? get quickConnectId => credentials?.quickConnectId;
  
  /// 获取工作地址
  String? get workingAddress => credentials?.workingAddress;
  
  /// 获取会话ID
  String? get sessionId => credentials?.sid;
}

/// 认证状态监听器 Provider
@riverpod
Stream<AuthState> authStateStream(Ref ref) {
  final authNotifier = ref.watch(authNotifierProvider.notifier);
  
  return Stream.fromFuture(authNotifier.build()).asBroadcastStream();
}

/// 当前用户 Provider
@riverpod
LoginCredentials? currentUser(Ref ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.when(
    data: (state) => state.credentials,
    loading: () => null,
    error: (_, __) => null,
  );
}

/// 认证状态 Provider
@riverpod
bool isAuthenticated(Ref ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.when(
    data: (state) => state.isAuthenticated,
    loading: () => false,
    error: (_, __) => false,
  );
}

/// 用户会话信息 Provider
@riverpod
UserSession? userSession(Ref ref) {
  final credentials = ref.watch(currentUserProvider);
  if (credentials == null) return null;
  
  return UserSession(
    username: credentials.username,
    quickConnectId: credentials.quickConnectId,
    workingAddress: credentials.workingAddress ?? '',
    sessionId: credentials.sid,
  );
}

/// 用户会话信息
class UserSession {
  const UserSession({
    required this.username,
    required this.quickConnectId,
    required this.workingAddress,
    this.sessionId,
  });

  final String username;
  final String quickConnectId;
  final String workingAddress;
  final String? sessionId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserSession &&
        other.username == username &&
        other.quickConnectId == quickConnectId &&
        other.workingAddress == workingAddress &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    return Object.hash(username, quickConnectId, workingAddress, sessionId);
  }

  @override
  String toString() {
    return 'UserSession('
        'username: $username, '
        'quickConnectId: $quickConnectId, '
        'workingAddress: $workingAddress, '
        'sessionId: $sessionId)';
  }
}
