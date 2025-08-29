import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../base/auth/auth_state_notifier.dart';
import '../../../../base/di/providers.dart';
import '../../../../base/error/error_mapper.dart';
import '../../../../base/error/exceptions.dart';
import '../../../../base/error/result.dart';
import '../../../../base/network/interceptors/cookie_interceptor.dart';
import '../../../../base/router/navigation_service.dart';
import '../../../../base/utils/logger.dart';
import '../../entities/auth_login/auth_login_response.dart';

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
    Logger.info('开始登录流程', tag: 'LoginProvider');

    try {
      final quickConnectService = ref.read(loginServiceProvider);
      final authStorage = ref.read(authStorageServiceProvider);
      
      // 使用重试机制执行登录
      final result = await _executeLoginWithRetry(
        quickConnectService: quickConnectService,
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      Logger.info('登录结果 - isSuccess: ${result.isSuccess}', tag: 'LoginProvider');
      
      if (result.isSuccess) {
        final data = result.value;
        Logger.info('登录数据 - sid: ${data.sid}', tag: 'LoginProvider');
        
        if (data.sid != null) {
          // 保存登录凭证和会话ID
          await authStorage.saveLoginCredentials(
            quickConnectId: quickConnectId,
            username: username,
            password: password,
            rememberPassword: rememberPassword,
          );
          await authStorage.saveSessionId(data.sid!);
          
          // 设置cookie拦截器的sessionId
          CookieInterceptor.setSessionId(data.sid!);
          
          // 登录成功
          ref.read(authStateNotifierProvider.notifier).login(data);
          NavigationService.goToHome();
          state = AsyncValue.data(data);
        } else {
          // 登录失败 - 没有 sid
          Logger.error('登录失败 - 没有会话ID', tag: 'LoginProvider');
          state = AsyncValue.error('登录失败：未获取到会话ID', StackTrace.current);
        }
      } else {
        // 登录失败 - 返回错误信息
        Logger.error('登录失败 - ${result.error.message}', tag: 'LoginProvider');
        state = AsyncValue.error(result.error.message, StackTrace.current);
      }
    } catch (e, stackTrace) {
      Logger.error('登录异常 - $e', tag: 'LoginProvider');
      final errorMessage = ErrorMapper.mapToUserMessage(e);
      state = AsyncValue.error(errorMessage, stackTrace);
    }
  }

  /// 执行带重试的登录操作
  Future<Result<LoginData>> _executeLoginWithRetry({
    required dynamic quickConnectService,
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      // 执行登录，现在返回 Result<LoginData>
      return await quickConnectService.login(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
    } catch (e) {
      // 如果发生异常，包装为 Result.Failure
      if (e is AppException) {
        return Failure(e);
      }
      return Failure(ServerException('登录失败: ${e.toString()}'));
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
