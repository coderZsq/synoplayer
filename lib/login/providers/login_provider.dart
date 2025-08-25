import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/router/navigation_service.dart';
import '../../core/di/providers.dart';
import '../../core/error/error_mapper.dart';
import '../../core/auth/auth_state_notifier.dart';
import '../../core/storage/auth_storage_service.dart';
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
    required bool rememberPassword,
  }) async {
    state = const AsyncValue.loading();

    try {
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final authStorage = ref.read(authStorageServiceProvider);
      
      // 使用重试机制执行登录
      final data = await _executeLoginWithRetry(
        quickConnectService: quickConnectService,
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      if (data != null) {
        // 保存登录凭证和会话ID
        await authStorage.saveLoginCredentials(
          quickConnectId: quickConnectId,
          username: username,
          password: password,
          rememberPassword: rememberPassword,
        );
        await authStorage.saveSessionId(data.sid!);
        
        // 登录成功
        ref.read(authStateNotifierProvider.notifier).login(data);
        NavigationService.goToHome();
        state = AsyncValue.data(data);
      } else {
        // 登录失败
        state = AsyncValue.error('登录失败', StackTrace.current);
      }
    } catch (e, stackTrace) {
      final errorMessage = ErrorMapper.mapToUserMessage(e);
      state = AsyncValue.error(errorMessage, stackTrace);
    }
  }

  /// 执行带重试的登录操作
  Future<LoginData?> _executeLoginWithRetry({
    required dynamic quickConnectService,
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      // 直接执行登录，重试逻辑由网络层处理
      return await quickConnectService.login(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
    } catch (e) {
      // 如果登录失败，记录错误并返回 null
      // 重试逻辑已经在网络层的重试拦截器中处理
      return null;
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
