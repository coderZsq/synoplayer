import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../quickconnect/entities/auth_login/auth_login_response.dart';
import '../../core/di/providers.dart';

part 'login_provider.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  FutureOr<AuthLoginResponse?> build() {
    return null;
  }

  Future<void> login({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    state = const AsyncValue.loading();

    try {
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final response = await quickConnectService.login(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );

      if (response != null) {
        state = AsyncValue.data(response);
      } else {
        state = AsyncValue.error(
          '登录失败：无效响应',
          StackTrace.current,
        );
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
