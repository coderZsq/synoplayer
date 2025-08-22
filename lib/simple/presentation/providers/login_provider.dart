import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../quickconnect/presentation/services/quickconnect_service.dart';
import '../../quickconnect/entities/auth_login/auth_login_response.dart';

part 'login_provider.g.dart';

enum LoginState { idle, loading, success, error }

class LoginData {
  final LoginState state;
  final String? errorMessage;
  final AuthLoginResponse? response;

  const LoginData({
    required this.state,
    this.errorMessage,
    this.response,
  });

  LoginData copyWith({
    LoginState? state,
    String? errorMessage,
    AuthLoginResponse? response,
  }) {
    return LoginData(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      response: response ?? this.response,
    );
  }
}

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginData build() {
    return const LoginData(state: LoginState.idle);
  }

  Future<void> login({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    state = state.copyWith(state: LoginState.loading, errorMessage: null);

    try {
      final quickConnectService = QuickConnectService();
      final response = await quickConnectService.login(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );

      if (response != null) {
        state = state.copyWith(
          state: LoginState.success,
          response: response,
        );
      } else {
        state = state.copyWith(
          state: LoginState.error,
          errorMessage: '登录失败：无效响应',
        );
      }
    } catch (e) {
      state = state.copyWith(
        state: LoginState.error,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = const LoginData(state: LoginState.idle);
  }
}
