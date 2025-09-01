import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../components/login/entities/auth_login/auth_login_response.dart';
import '../di/providers.dart';
import '../error/result.dart';
import '../error/exceptions.dart';
import '../network/interceptors/cookie_interceptor.dart';
import '../utils/logger.dart';

part 'auth_state_notifier.g.dart';

/// 认证状态数据模型
class AuthState {
  final bool isAuthenticated;
  final LoginData? loginData;
  final bool isInitialized; // 是否已完成初始化检查
  
  const AuthState({
    required this.isAuthenticated,
    this.loginData,
    this.isInitialized = false,
  });
  
  AuthState copyWith({
    bool? isAuthenticated,
    LoginData? loginData,
    bool? isInitialized,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      loginData: loginData ?? this.loginData,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

/// 全局认证状态管理
@Riverpod(keepAlive: true)
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() {
    return const AuthState(isAuthenticated: false, isInitialized: false);
  }
  
  /// 登录成功
  void login(LoginData loginData) {
    state = AuthState(
      isAuthenticated: true,
      loginData: loginData,
      isInitialized: true,
    );
  }
  
  /// 登出
  Future<Result<void>> logout() async {
    Logger.info('开始执行登出操作...', tag: 'AuthStateNotifier');
    
    try {
      // 从内存状态获取会话ID（现在状态不会丢失）
      final currentSessionId = state.loginData?.sid;
      
      if (currentSessionId != null) {
        // 调用群辉登出API
        final loginService = ref.read(loginServiceProvider);
        final logoutResult = await loginService.logout(sessionId: currentSessionId);
        
        if (logoutResult.isSuccess) {
          Logger.info('群辉登出API调用成功，开始清理本地状态', tag: 'AuthStateNotifier');
          
          // 远程登出成功后，清理本地状态
          await _clearLocalState();
          
          Logger.info('登出操作完成，远程和本地状态已同步', tag: 'AuthStateNotifier');
          return const Success(null);
        } else {
          Logger.error('群辉登出API调用失败: ${logoutResult.error.message}', tag: 'AuthStateNotifier');
          // 远程登出失败，不清理本地状态，返回错误
          return Failure(logoutResult.error);
        }
      } else {
        Logger.info('没有找到会话ID，跳过群辉登出API调用', tag: 'AuthStateNotifier');
        // 没有会话ID，直接清理本地状态
        await _clearLocalState();
        return const Success(null);
      }
    } catch (e) {
      Logger.error('登出过程中发生异常: $e', tag: 'AuthStateNotifier');
      // 发生异常，不清理本地状态，返回错误
      return Failure(ServerException('登出过程发生未知错误: ${e.toString()}'));
    }
  }
  
  /// 清理本地状态
  Future<void> _clearLocalState() async {
    // 清理本地认证数据
    final authStorage = ref.read(authStorageServiceProvider);
    await authStorage.clearAuthData();
    
    // 清除cookie拦截器的sessionId
    CookieInterceptor.clearSessionId();
    
    // 更新状态为未登录
    state = const AuthState(isAuthenticated: false, isInitialized: true);
    
    Logger.info('本地状态清理完成', tag: 'AuthStateNotifier');
  }
  
  /// 检查是否已登录
  bool get isLoggedIn => state.isAuthenticated;
  
  /// 获取登录数据
  LoginData? get loginData => state.loginData;
  
  /// 获取会话ID
  String? get sessionId => state.loginData?.sid;
  
  /// 是否已完成初始化
  bool get isInitialized => state.isInitialized;
  
  /// 自动登录检查
  Future<bool> checkAutoLogin() async {
    Logger.info('开始检查自动登录...', tag: 'AuthStateNotifier');
    final authStorage = ref.read(authStorageServiceProvider);
    final sessionId = await authStorage.getSessionId();
    
    Logger.info('获取到的 SID: $sessionId', tag: 'AuthStateNotifier');
    
    if (sessionId != null) {
      Logger.info('找到保存的 SID，设置为已登录状态', tag: 'AuthStateNotifier');
      final newState = AuthState(
        isAuthenticated: true,
        loginData: LoginData(
          account: null,
          deviceId: null,
          ikMessage: null,
          isPortalPort: null,
          sid: sessionId,
          synotoken: null,
        ),
        isInitialized: true,
      );
      
      state = newState;
      
      // 设置cookie拦截器的sessionId
      CookieInterceptor.setSessionId(sessionId);
      
      // 尝试建立与服务器的连接
      try {
        final credentials = await authStorage.getLoginCredentials();
        final quickConnectId = credentials['quickConnectId'];
        
        if (quickConnectId != null && quickConnectId.isNotEmpty) {
          Logger.info('尝试建立与服务器的连接...', tag: 'AuthStateNotifier');
          final connectionManager = ref.read(connectionManagerProvider);
          final connectionResult = await connectionManager.establishConnection(quickConnectId);
          
          if (connectionResult.isSuccess) {
            Logger.info('自动登录后连接建立成功', tag: 'AuthStateNotifier');
          } else {
            Logger.warning('自动登录后连接建立失败: ${connectionResult.error.message}', tag: 'AuthStateNotifier');
            // 连接失败不影响登录状态，只是后续操作可能需要重新连接
          }
        } else {
          Logger.warning('未找到 quickConnectId，无法建立连接', tag: 'AuthStateNotifier');
        }
      } catch (e) {
        Logger.warning('建立连接过程中发生异常: $e', tag: 'AuthStateNotifier');
        // 连接异常不影响登录状态
      }
      
      Logger.info('自动登录成功，状态已更新', tag: 'AuthStateNotifier');
      return true;
    } else {
      Logger.info('没有找到保存的 SID，设置为未登录状态', tag: 'AuthStateNotifier');
      final newState = const AuthState(isAuthenticated: false, isInitialized: true);
      state = newState;
      return false;
    }
  }
}
