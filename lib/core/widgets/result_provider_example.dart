import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../error/result.dart';
import '../error/exceptions.dart';
import 'result_handler.dart';

/// 示例：使用 Result 类型的 Provider
class LoginProvider extends StateNotifier<Result<LoginData>?> {
  LoginProvider() : super(null);
  
  /// 执行登录
  Future<void> login({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    // 设置加载状态
    state = null;
    
    try {
      // 这里应该调用实际的 LoginUseCase
      // final result = await loginUseCase.call(...);
      
      // 模拟登录过程
      await Future.delayed(const Duration(seconds: 2));
      
      // 模拟成功或失败
      if (username == 'admin' && password == 'password') {
        final loginData = LoginData(
          sid: 'mock_sid_123',
          username: username,
          // 其他字段...
        );
        state = Success(loginData);
      } else {
        state = Failure(BusinessException('用户名或密码错误'));
      }
    } catch (e) {
      if (e is AppException) {
        state = Failure(e);
      } else {
        state = Failure(ServerException('登录失败: ${e.toString()}'));
      }
    }
  }
  
  /// 重置状态
  void reset() {
    state = null;
  }
}

/// 登录数据模型（示例）
class LoginData {
  final String sid;
  final String username;
  
  LoginData({
    required this.sid,
    required this.username,
  });
}

/// Provider 定义
final loginProvider = StateNotifierProvider<LoginProvider, Result<LoginData>?>((ref) {
  return LoginProvider();
});

/// 示例：使用 Result 类型的 UI
class LoginResultExample extends ConsumerWidget {
  const LoginResultExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginResult = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('登录示例'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // 登录表单
              _buildLoginForm(context, loginNotifier),
              
              const SizedBox(height: 32),
              
              // 结果显示
              Expanded(
                child: ResultListener<LoginData>(
                  result: loginResult,
                  onSuccess: (data) => _buildSuccessView(data),
                  onFailure: (error) => _buildErrorView(error, loginNotifier),
                  onLoading: _buildLoadingView(),
                  showErrorDialog: false, // 使用自定义错误显示
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildLoginForm(BuildContext context, LoginProvider loginNotifier) {
    return Column(
      children: [
        CupertinoTextField(
          placeholder: 'QuickConnect ID',
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.systemGrey),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        CupertinoTextField(
          placeholder: '用户名',
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.systemGrey),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        CupertinoTextField(
          placeholder: '密码',
          obscureText: true,
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.systemGrey),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton.filled(
            onPressed: () {
              loginNotifier.login(
                quickConnectId: 'demo',
                username: 'admin',
                password: 'password',
              );
            },
            child: const Text('登录'),
          ),
        ),
      ],
    );
  }
  
  Widget _buildSuccessView(LoginData data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.checkmark_circle_fill,
            size: 64,
            color: CupertinoColors.systemGreen,
          ),
          const SizedBox(height: 24),
          Text(
            '登录成功！',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text('欢迎回来，${data.username}'),
          const SizedBox(height: 8),
          Text('Session ID: ${data.sid}'),
        ],
      ),
    );
  }
  
  Widget _buildErrorView(AppException error, LoginProvider loginNotifier) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.exclamationmark_triangle,
            size: 64,
            color: CupertinoColors.systemRed,
          ),
          const SizedBox(height: 24),
          Text(
            '登录失败',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            error.message,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          CupertinoButton.filled(
            onPressed: () {
              loginNotifier.login(
                quickConnectId: 'demo',
                username: 'admin',
                password: 'password',
              );
            },
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLoadingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(),
          SizedBox(height: 16),
          Text('登录中...'),
        ],
      ),
    );
  }
}
