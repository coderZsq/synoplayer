import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../quickconnect/entities/auth_login/auth_login_response.dart';

part 'auth_state_notifier.g.dart';

/// 认证状态数据模型
class AuthState {
  final bool isAuthenticated;
  final LoginData? loginData;
  
  const AuthState({
    required this.isAuthenticated,
    this.loginData,
  });
  
  AuthState copyWith({
    bool? isAuthenticated,
    LoginData? loginData,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      loginData: loginData ?? this.loginData,
    );
  }
}

/// 全局认证状态管理
@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() {
    return const AuthState(isAuthenticated: false);
  }
  
  /// 登录成功
  void login(LoginData loginData) {
    state = AuthState(
      isAuthenticated: true,
      loginData: loginData,
    );
  }
  
  /// 登出
  void logout() {
    state = const AuthState(isAuthenticated: false);
  }
  
  /// 检查是否已登录
  bool get isLoggedIn => state.isAuthenticated;
  
  /// 获取登录数据
  LoginData? get loginData => state.loginData;
  
  /// 获取会话ID
  String? get sessionId => state.loginData?.sid;
}
