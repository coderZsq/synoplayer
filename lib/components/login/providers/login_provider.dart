import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/router/navigation_service.dart';
import '../../../core/di/providers.dart';
import '../../../core/error/error_mapper.dart';
import '../../../core/error/result.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/auth/auth_state_notifier.dart';
import '../../../quickconnect/entities/auth_login/auth_login_response.dart';

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
    print('🔍 LoginProvider: 开始登录流程');

    try {
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final authStorage = ref.read(authStorageServiceProvider);
      
      // 使用重试机制执行登录
      final result = await _executeLoginWithRetry(
        quickConnectService: quickConnectService,
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      print('🔍 LoginProvider: 登录结果 - isSuccess: ${result.isSuccess}');
      
      if (result.isSuccess) {
        final data = result.value;
        print('🔍 LoginProvider: 登录数据 - sid: ${data.sid}');
        
        if (data.sid != null) {
          // 保存登录凭证和会话ID
          print('🔍 LoginProvider: 开始保存登录凭证...');
          await authStorage.saveLoginCredentials(
            quickConnectId: quickConnectId,
            username: username,
            password: password,
            rememberPassword: rememberPassword,
          );
          await authStorage.saveSessionId(data.sid!);
          
          // 验证凭证是否已保存
          print('🔍 LoginProvider: 验证凭证是否已保存...');
          final savedCredentials = await authStorage.getLoginCredentials();
          final savedSessionId = await authStorage.getSessionId();
          
          if (savedCredentials['quickConnectId'] == quickConnectId && 
              savedSessionId == data.sid) {
            print('✅ LoginProvider: 凭证保存成功，开始跳转路由');
            
            // 登录成功
            ref.read(authStateNotifierProvider.notifier).login(data);
            NavigationService.goToHome();
            state = AsyncValue.data(data);
            print('✅ LoginProvider: 登录成功，已保存会话ID并跳转路由');
          } else {
            print('❌ LoginProvider: 凭证保存验证失败');
            state = AsyncValue.error('登录失败：凭证保存失败', StackTrace.current);
          }
        } else {
          // 登录失败 - 没有 sid
          print('❌ LoginProvider: 登录失败 - 没有会话ID');
          state = AsyncValue.error('登录失败：未获取到会话ID', StackTrace.current);
        }
      } else {
        // 登录失败 - 返回错误信息
        print('❌ LoginProvider: 登录失败 - ${result.error.message}');
        state = AsyncValue.error(result.error.message, StackTrace.current);
      }
    } catch (e, stackTrace) {
      print('❌ LoginProvider: 登录异常 - $e');
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
