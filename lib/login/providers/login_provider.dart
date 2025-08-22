import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/di/providers.dart';
import '../../core/error/error_mapper.dart';
import '../../quickconnect/entities/auth_login/auth_login_response.dart';

part 'login_provider.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  FutureOr<LoginData?> build() {
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
        final errorMessage = ErrorMapper.mapToUserMessage('登录失败：服务器返回无效响应');
        state = AsyncValue.error(
          errorMessage,
          StackTrace.current,
        );
      }
    } catch (e, stackTrace) {
      final errorMessage = ErrorMapper.mapToUserMessage(e);
      state = AsyncValue.error(errorMessage, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
