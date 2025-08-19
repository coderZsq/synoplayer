import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

import '../services/credentials/credentials_service.dart';
import '../utils/logger.dart';

part 'auth_providers.g.dart';
part 'auth_providers.freezed.dart';

/// 认证状态管理
/// 
/// 负责管理应用的认证状态，包括：
/// - 用户登录状态管理
/// - 凭据缓存和验证
/// - 会话有效性检查
/// - 认证状态刷新
@riverpod
class AuthNotifier extends _$AuthNotifier {
  // ==== 私有字段 ====
  
  /// 缓存的用户凭据，避免重复读取
  LoginCredentials? _cachedCredentials;
  
  /// 会话验证状态，避免重复验证
  bool _hasCheckedSession = false;
  
  /// 初始化状态标志，防止重复初始化
  bool _isInitializing = false;
  
  @override
  Future<AuthState> build() async {
    // ==== 防止重复初始化 ====
    if (_isInitializing) {
      AppLogger.info('🔄 AuthNotifier 正在初始化中，跳过重复调用');
      return state.valueOrNull ?? const AuthState.unauthenticated();
    }
    
    _isInitializing = true;
    AppLogger.info('🔐 AuthNotifier 开始初始化认证状态');
    
    try {
      return await _initializeAuthState();
    } catch (error, stackTrace) {
      AppLogger.error('🚨 AuthNotifier 初始化失败', error: error, stackTrace: stackTrace);
      return const AuthState.unauthenticated();
    } finally {
      _isInitializing = false;
    }
  }

  /// 初始化认证状态的核心逻辑
  Future<AuthState> _initializeAuthState() async {
    // ==== 检查缓存状态 ====
    if (_shouldUseCachedState()) {
      return _getCachedAuthState();
    }
    
    // ==== 获取凭据服务 ====
    final credentialsService = ref.read(credentialsServiceProvider);
    AppLogger.debug('🔐 凭据服务已获取');
    
    // ==== 读取并缓存凭据 ====
    await _loadAndCacheCredentials(credentialsService);
    
    // ==== 验证会话有效性 ====
    if (_cachedCredentials != null) {
      return await _validateSessionAndReturnState(credentialsService);
    }
    
    // ==== 返回未认证状态 ====
    AppLogger.info('❌ 认证状态: 未认证');
    return const AuthState.unauthenticated();
  }

  /// 检查是否应该使用缓存状态
  bool _shouldUseCachedState() {
    return _cachedCredentials != null && _hasCheckedSession;
  }

  /// 获取缓存的认证状态
  AuthState _getCachedAuthState() {
    AppLogger.info('📋 使用缓存的认证状态');
    return AuthState.authenticated(_cachedCredentials!);
  }

  /// 加载并缓存凭据
  Future<void> _loadAndCacheCredentials(CredentialsService credentialsService) async {
    if (_cachedCredentials == null) {
      _cachedCredentials = await credentialsService.getCredentials();
      AppLogger.debug('🔐 读取凭据结果: ${_cachedCredentials != null ? "有凭据" : "无凭据"}');
    }
  }

  /// 验证会话并返回认证状态
  Future<AuthState> _validateSessionAndReturnState(CredentialsService credentialsService) async {
    if (!_hasCheckedSession) {
      return await _performSessionValidation(credentialsService);
    } else {
      return _getCachedAuthState();
    }
  }

  /// 执行会话验证
  Future<AuthState> _performSessionValidation(CredentialsService credentialsService) async {
    AppLogger.debug('🔐 开始检查会话有效性');
    final hasValidSession = await credentialsService.hasValidSession();
    _hasCheckedSession = true;
    AppLogger.info('🔐 会话有效性检查结果: $hasValidSession');
    
    if (hasValidSession) {
      AppLogger.info('✅ 认证状态: 已认证');
      return AuthState.authenticated(_cachedCredentials!);
    } else {
      await _clearInvalidCredentials(credentialsService);
      return const AuthState.unauthenticated();
    }
  }

  /// 清除无效凭据
  Future<void> _clearInvalidCredentials(CredentialsService credentialsService) async {
    await credentialsService.clearCredentials();
    _cachedCredentials = null;
    _hasCheckedSession = false;
    AppLogger.warning('⚠️ 会话已过期，清除凭据和缓存');
  }

  /// 用户登录
  /// 
  /// [username] 用户名
  /// [password] 密码
  /// [quickConnectId] QuickConnect ID
  /// [workingAddress] 工作地址（可选）
  /// [rememberCredentials] 是否记住凭据（默认：true）
  /// 
  /// Throws: [Exception] 当登录失败时
  Future<void> login({
    required String username,
    required String password,
    required String quickConnectId,
    String? workingAddress,
    bool rememberCredentials = true,
  }) async {
    state = const AsyncLoading();
    
    try {
      final credentials = await _createAndSaveCredentials(
        username: username,
        password: password,
        quickConnectId: quickConnectId,
        workingAddress: workingAddress,
        rememberCredentials: rememberCredentials,
      );
      
      _updateStateAndCache(credentials);
    } catch (error, stackTrace) {
      _handleLoginError(error, stackTrace);
    }
  }

  /// 创建并保存凭据
  Future<LoginCredentials> _createAndSaveCredentials({
    required String username,
    required String password,
    required String quickConnectId,
    String? workingAddress,
    required bool rememberCredentials,
  }) async {
    final credentialsService = ref.read(credentialsServiceProvider);
    
    final credentials = LoginCredentials(
      username: username,
      password: password,
      quickConnectId: quickConnectId,
      workingAddress: workingAddress,
      rememberCredentials: rememberCredentials,
    );
    
    await credentialsService.saveCredentials(credentials);
    return credentials;
  }

  /// 更新状态和缓存
  void _updateStateAndCache(LoginCredentials credentials) {
    _cachedCredentials = credentials;
    _hasCheckedSession = true;
    state = AsyncData(AuthState.authenticated(credentials));
  }

  /// 处理登录错误
  void _handleLoginError(Object error, StackTrace stackTrace) {
    AppLogger.error('🚨 登录失败', error: error, stackTrace: stackTrace);
    state = AsyncError(error, stackTrace);
  }

  /// 设置会话ID
  /// 
  /// [sid] 会话ID
  /// 
  /// 注意：只有在已认证状态下才能设置会话ID
  Future<void> setSessionId(String sid) async {
    final currentState = state.valueOrNull;
    if (currentState is AuthAuthenticated) {
      await _updateSessionId(sid, currentState.credentials);
    } else {
      AppLogger.warning('⚠️ 尝试在未认证状态下设置会话ID');
    }
  }

  /// 更新会话ID
  Future<void> _updateSessionId(String sid, LoginCredentials credentials) async {
    final updatedCredentials = credentials.copyWith(sid: sid);
    
    // 更新状态和缓存
    state = AsyncData(AuthState.authenticated(updatedCredentials));
    _cachedCredentials = updatedCredentials;
    
    // 保存到本地存储
    final credentialsService = ref.read(credentialsServiceProvider);
    await credentialsService.saveCredentials(updatedCredentials);
    
    AppLogger.info('✅ 会话ID已更新: $sid');
  }

  /// 用户登出
  /// 
  /// 清除所有认证信息和缓存
  Future<void> logout() async {
    try {
      await _clearAllAuthData();
      _updateStateToUnauthenticated();
      AppLogger.info('✅ 用户已成功登出');
    } catch (error, stackTrace) {
      _handleLogoutError(error, stackTrace);
    }
  }

  /// 清除所有认证数据
  Future<void> _clearAllAuthData() async {
    final credentialsService = ref.read(credentialsServiceProvider);
    await credentialsService.clearCredentials();
  }

  /// 更新状态为未认证
  void _updateStateToUnauthenticated() {
    _cachedCredentials = null;
    _hasCheckedSession = false;
    state = const AsyncData(AuthState.unauthenticated());
  }

  /// 处理登出错误
  void _handleLogoutError(Object error, StackTrace stackTrace) {
    AppLogger.error('🚨 登出失败', error: error, stackTrace: stackTrace);
    state = AsyncError(error, stackTrace);
  }

  /// 刷新认证状态
  /// 
  /// 重新验证用户的认证状态，优先使用缓存
  Future<void> refreshAuthStatus() async {
    try {
      AppLogger.info('🔄 开始刷新认证状态');
      
      state = const AsyncLoading();
      
      if (_shouldUseCachedState()) {
        _useCachedStateForRefresh();
        return;
      }
      
      await _performFullRefresh();
    } catch (error, stackTrace) {
      _handleRefreshError(error, stackTrace);
    }
  }

  /// 使用缓存状态进行刷新
  void _useCachedStateForRefresh() {
    AppLogger.info('📋 使用缓存的认证状态进行刷新');
    state = AsyncData(AuthState.authenticated(_cachedCredentials!));
  }

  /// 执行完整的刷新流程
  Future<void> _performFullRefresh() async {
    final credentialsService = ref.read(credentialsServiceProvider);
    final credentials = await credentialsService.getCredentials();
    
    if (credentials != null) {
      await _validateAndUpdateCredentials(credentialsService, credentials);
    } else {
      _clearCacheAndSetUnauthenticated();
    }
  }

  /// 验证并更新凭据
  Future<void> _validateAndUpdateCredentials(
    CredentialsService credentialsService,
    LoginCredentials credentials,
  ) async {
    final hasValidSession = await credentialsService.hasValidSession();
    
    if (hasValidSession) {
      _updateCacheAndSetAuthenticated(credentials);
      AppLogger.info('✅ 刷新认证状态: 已认证');
    } else {
      _clearCacheAndSetUnauthenticated();
    }
  }

  /// 更新缓存并设置为已认证
  void _updateCacheAndSetAuthenticated(LoginCredentials credentials) {
    _cachedCredentials = credentials;
    _hasCheckedSession = true;
    state = AsyncData(AuthState.authenticated(credentials));
  }

  /// 清除缓存并设置为未认证
  void _clearCacheAndSetUnauthenticated() {
    _cachedCredentials = null;
    _hasCheckedSession = false;
    AppLogger.info('❌ 刷新认证状态: 未认证');
    state = const AsyncData(AuthState.unauthenticated());
  }

  /// 处理刷新错误
  void _handleRefreshError(Object error, StackTrace stackTrace) {
    AppLogger.error('🚨 刷新认证状态失败', error: error, stackTrace: stackTrace);
    state = AsyncError(error, stackTrace);
  }

  /// 检查凭据是否有效
  /// 
  /// Returns: 如果凭据有效返回 true，否则返回 false
  Future<bool> hasValidCredentials() async {
    final currentState = state.valueOrNull;
    
    if (currentState is AuthAuthenticated) {
      return await _validateCurrentCredentials();
    }
    
    return false;
  }

  /// 验证当前凭据
  Future<bool> _validateCurrentCredentials() async {
    final credentialsService = ref.read(credentialsServiceProvider);
    return await credentialsService.hasValidSession();
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
class UserSession extends Equatable {
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
  List<Object?> get props => [username, quickConnectId, workingAddress, sessionId];

  @override
  String toString() {
    return 'UserSession('
        'username: $username, '
        'quickConnectId: $quickConnectId, '
        'workingAddress: $workingAddress, '
        'sessionId: $sessionId)';
  }
}
