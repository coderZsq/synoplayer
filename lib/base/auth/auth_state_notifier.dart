import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../components/login/entities/auth_login/auth_login_response.dart';
import '../di/providers.dart';
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
@riverpod
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
  void logout() async {
    final authStorage = ref.read(authStorageServiceProvider);
    await authStorage.clearAuthData();
    
    // 清除cookie拦截器的sessionId
    CookieInterceptor.clearSessionId();
    
    state = const AuthState(isAuthenticated: false, isInitialized: true);
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
