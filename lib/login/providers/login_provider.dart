import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/router/navigation_service.dart';
import '../../core/di/providers.dart';
import '../../core/error/error_mapper.dart';
import '../../core/auth/auth_state_notifier.dart';
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
      final data = await quickConnectService.login(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      ref.read(authStateNotifierProvider.notifier).login(data);
      NavigationService.goToHome();
      state = AsyncValue.data(data);
    } catch (e, stackTrace) {
      final errorMessage = ErrorMapper.mapToUserMessage(e);
      state = AsyncValue.error(errorMessage, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
