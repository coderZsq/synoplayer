import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../simple/login/pages/login_page.dart';
import '../providers/auth_providers.dart';
import '../providers/app_providers.dart';
import '../utils/logger.dart';

part 'app_router.g.dart';

/// 应用路由配置
/// 
/// 使用 GoRouter 进行声明式路由管理
/// 支持类型安全的路由参数和嵌套路由
@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // 获取认证状态
      final authState = ref.read(authNotifierProvider);
      
      // 如果正在加载，不进行重定向
      if (authState.isLoading) return null;
      
      // 检查认证状态
      final isAuthenticated = authState.when(
        data: (state) => state.isAuthenticated,
        loading: () => false,
        error: (_, __) => false,
      );
      
      AppLogger.debug('🔄 路由重定向检查: path=${state.uri.path}, isAuthenticated=$isAuthenticated');
      
      // 如果未认证且不在登录页，重定向到登录页
      if (!isAuthenticated && state.uri.path != RoutePaths.login) {
        AppLogger.info('🔒 未认证用户，重定向到登录页');
        return RoutePaths.login;
      }
      
      // 如果已认证且在登录页，重定向到主页面
      if (isAuthenticated && state.uri.path == RoutePaths.login) {
        final credentials = authState.when(
          data: (state) => state.credentials,
          loading: () => null,
          error: (_, __) => null,
        );
        
        if (credentials != null) {
          final dashboardUrl = '${RoutePaths.dashboard}?sid=${credentials.sid}&username=${credentials.username}&quickConnectId=${credentials.quickConnectId}&workingAddress=${credentials.workingAddress}';
          AppLogger.info('✅ 已认证用户，重定向到主页面: $dashboardUrl');
          return dashboardUrl;
        }
      }
      
      // 如果已认证且在启动页，重定向到主页面
      if (isAuthenticated && state.uri.path == RoutePaths.splash) {
        final credentials = authState.when(
          data: (state) => state.credentials,
          loading: () => null,
          error: (_, __) => null,
        );
        
        if (credentials != null) {
          final dashboardUrl = '${RoutePaths.dashboard}?sid=${credentials.sid}&username=${credentials.username}&quickConnectId=${credentials.quickConnectId}&workingAddress=${credentials.workingAddress}';
          AppLogger.info('🚀 启动页重定向到主页面: $dashboardUrl');
          return dashboardUrl;
        }
      }
      
      return null;
    },
    routes: [
      // 启动页
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const LoginPage(),
      ),
    ],
    
    // 错误页面
    errorBuilder: (context, state) => _ErrorPage(error: state.error),
  );
}

/// 路由路径常量
abstract class RoutePaths {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String quickconnectLogin = '/quickconnect-login';
  static const String dashboard = '/dashboard';
}

/// 路由扩展方法
extension AppRouterExtension on GoRouter {
  /// 导航到启动页
  void goToSplash() => go(RoutePaths.splash);
  
  /// 导航到登录页
  void goToLogin() => go(RoutePaths.login);
  
  /// 导航到 QuickConnect 登录页
  void goToQuickConnectLogin() => go(RoutePaths.quickconnectLogin);
  
  /// 导航到主页面
  void goToDashboard({
    required String sid,
    required String username,
    required String quickConnectId,
    required String workingAddress,
  }) {
    final uri = Uri(
      path: RoutePaths.dashboard,
      queryParameters: {
        'sid': sid,
        'username': username,
        'quickConnectId': quickConnectId,
        'workingAddress': workingAddress,
      },
    );
    go(uri.toString());
  }
}

/// 启动页
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

/// 启动页面状态管理
class _SplashPageState extends ConsumerState<SplashPage> {
  // ==== 私有字段 ====
  
  /// 超时定时器
  Timer? _timeoutTimer;
  
  /// 检查次数计数器
  int _checkCount = 0;
  
  /// 最大检查次数限制
  static const int _maxCheckCount = 3;
  
  /// 导航状态标志，防止重复导航
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    
    _setupTimeoutTimer();
    _startLoginCheck();
  }

  /// 设置超时定时器
  void _setupTimeoutTimer() {
    _timeoutTimer = Timer(const Duration(seconds: 5), _handleTimeout);
  }

  /// 处理超时情况
  Future<void> _handleTimeout() async {
    if (mounted) {
      AppLogger.warning('⏰ 启动页即将超时，尝试直接检查凭据');
      try {
        await _checkCredentialsDirectly();
      } catch (e) {
        AppLogger.error('🚨 直接检查失败，强制跳转到登录页', error: e);
        if (mounted) {
          _stopAllOperations();
          context.go(RoutePaths.login);
          return;
        }
      }
    }
  }

  /// 开始登录检查
  void _startLoginCheck() {
    _checkLoginStatus();
  }

  @override
  void dispose() {
    _stopAllOperations();
    super.dispose();
  }

  /// 停止所有操作
  void _stopAllOperations() {
    AppLogger.info('🛑 停止所有操作');
    _timeoutTimer?.cancel();
    _timeoutTimer = null;
    _isNavigating = true; // 标记正在导航
  }

  /// 检查是否可以继续操作
  bool get _canContinue => mounted && !_isNavigating;

    /// 检查登录状态的核心逻辑
  Future<void> _checkLoginStatus() async {
    try {
      if (!_canContinue) {
        AppLogger.info('🛑 操作已停止，跳过检查');
        return;
      }
      
      _checkCount++;
      AppLogger.info('🔍 启动页第 $_checkCount 次检查认证状态');
      
      if (_checkCount > _maxCheckCount) {
        await _handleMaxCheckCountReached();
        return;
      }
      
      await _performLoginCheck();
    } catch (e) {
      await _handleCheckError(e);
    }
  }

  /// 处理达到最大检查次数的情况
  Future<void> _handleMaxCheckCountReached() async {
    AppLogger.warning('⚠️ 检查次数超限，尝试直接检查凭据');
    await _checkCredentialsDirectly();
  }

  /// 执行登录检查
  Future<void> _performLoginCheck() async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (_checkCount == 1) {
      await _handleFirstCheck();
    }
    
    await _checkAuthState();
  }

  /// 处理首次检查
  Future<void> _handleFirstCheck() async {
    AppLogger.info('🔄 首次检查，尝试刷新认证状态');
    
    try {
      await _refreshAuthStatus();
      await _forceRefreshProvider();
      await _checkProviderState();
    } catch (e) {
      AppLogger.warning('⚠️ 刷新认证状态失败: $e');
    }
  }

  /// 刷新认证状态
  Future<void> _refreshAuthStatus() async {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.refreshAuthStatus();
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// 强制刷新 Provider
  Future<void> _forceRefreshProvider() async {
    AppLogger.info('🔄 尝试强制刷新 Provider 状态');
    ref.invalidate(authNotifierProvider);
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// 检查 Provider 状态
  Future<void> _checkProviderState() async {
    final currentAuthState = ref.read(authNotifierProvider);
    if (currentAuthState.isLoading) {
      AppLogger.info('🔄 Provider 状态仍为加载中，立即尝试直接检查');
      await _checkCredentialsDirectly();
    }
  }

  /// 检查认证状态
  Future<void> _checkAuthState() async {
    final authState = ref.read(authNotifierProvider);
    AppLogger.debug('🔍 当前认证状态: ${authState.runtimeType}');
    
    if (_shouldUseDirectCheck(authState)) {
      await _checkCredentialsDirectly();
      return;
    }
    
    await _handleAuthStateResult(authState);
  }

  /// 判断是否应该使用直接检查
  bool _shouldUseDirectCheck(AsyncValue<AuthState> authState) {
    return authState.isLoading && _checkCount > 1;
  }

  /// 处理认证状态结果
  Future<void> _handleAuthStateResult(AsyncValue<AuthState> authState) async {
    authState.when(
      data: _handleAuthenticatedState,
      loading: _handleLoadingState,
      error: _handleErrorState,
    );
  }

  /// 处理已认证状态
  Future<void> _handleAuthenticatedState(AuthState state) async {
    AppLogger.info('📊 认证状态: ${state.runtimeType}');
    
    if (state.isAuthenticated) {
      await _navigateToDashboard(state.credentials);
    } else {
      await _navigateToLogin();
    }
  }

  /// 导航到主页面
  Future<void> _navigateToDashboard(dynamic credentials) async {
    if (credentials != null) {
      final dashboardUrl = _buildDashboardUrl(credentials);
      AppLogger.info('🚀 跳转到主页面: $dashboardUrl');
      
      if (mounted) {
        _stopAllOperations();
        context.go(dashboardUrl);
        return;
      }
    } else {
      AppLogger.warning('⚠️ 凭据为空，跳转到登录页');
      await _navigateToLogin();
    }
  }

  /// 构建主页面 URL
  String _buildDashboardUrl(dynamic credentials) {
    return '${RoutePaths.dashboard}?sid=${credentials.sid}&username=${credentials.username}&quickConnectId=${credentials.quickConnectId}&workingAddress=${credentials.workingAddress}';
  }

  /// 导航到登录页
  Future<void> _navigateToLogin() async {
    AppLogger.info('📝 未认证，跳转到登录页');
    if (mounted) {
      _stopAllOperations();
      context.go(RoutePaths.login);
      return;
    }
  }

  /// 处理加载状态
  void _handleLoadingState() {
    AppLogger.info('⏳ 认证状态加载中，等待...');
    
    if (_checkCount == 1) {
      _scheduleDelayedCheck(const Duration(seconds: 1));
    } else {
      _scheduleDelayedCheck(const Duration(milliseconds: 500));
    }
  }

  /// 安排延迟检查
  void _scheduleDelayedCheck(Duration delay) {
    Future.delayed(delay, () {
      if (_canContinue) {
        _checkLoginStatus();
      }
    });
  }

  /// 处理错误状态
  Future<void> _handleErrorState(Object error, StackTrace stackTrace) async {
    AppLogger.error('❌ 认证状态检查失败，跳转到登录页', error: error, stackTrace: stackTrace);
    if (mounted) {
      _stopAllOperations();
      context.go(RoutePaths.login);
      return;
    }
  }

  /// 处理检查错误
  Future<void> _handleCheckError(Object error) async {
    AppLogger.error('🚨 状态检查异常，跳转到登录页', error: error);
    
    if (_isRefDisposedError(error)) {
      await _handleRefDisposedError();
    } else {
      await _navigateToLogin();
    }
  }

  /// 检查是否是 ref 被销毁的错误
  bool _isRefDisposedError(Object error) {
    return error.toString().contains('Cannot use "ref" after the widget was disposed');
  }

  /// 处理 ref 被销毁的错误
  Future<void> _handleRefDisposedError() async {
    AppLogger.warning('⚠️ ref 已被销毁，尝试直接检查凭据');
    try {
      await _checkCredentialsDirectly();
    } catch (directError) {
      AppLogger.error('🚨 直接检查也失败，跳转到登录页', error: directError);
      await _navigateToLogin();
    }
  }

  /// 直接检查凭据（备用方案）
  Future<void> _checkCredentialsDirectly() async {
    try {
      AppLogger.info('🔍 直接检查凭据（备用方案）');
      
      final credentialsService = ref.read(credentialsServiceProvider);
      final credentials = await credentialsService.getCredentials();
      
      if (credentials != null) {
        final hasValidSession = await credentialsService.hasValidSession();
        if (hasValidSession) {
          final dashboardUrl = '${RoutePaths.dashboard}?sid=${credentials.sid}&username=${credentials.username}&quickConnectId=${credentials.quickConnectId}&workingAddress=${credentials.workingAddress}';
          AppLogger.info('🚀 直接检查成功，跳转到主页面: $dashboardUrl');
          if (mounted) {
            // 跳转成功后立即停止所有操作
            _stopAllOperations();
            context.go(dashboardUrl);
            return;
          }
        }
      }
      
      AppLogger.warning('⚠️ 直接检查失败，跳转到登录页');
      if (mounted) {
        _stopAllOperations();
        context.go(RoutePaths.login);
      }
    } catch (e) {
      AppLogger.error('🚨 直接检查凭据失败', error: e);
      if (mounted) {
        _stopAllOperations();
        context.go(RoutePaths.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 应用图标
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (isDark ? Colors.black : Colors.grey).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.cloud_done,
                  color: theme.iconTheme.color,
                  size: 64,
                ),
              ),
              const SizedBox(height: 32),
              
              // 应用标题
              Text(
                '群晖 QuickConnect',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              Text(
                '正在检查登录状态...',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              
              // 加载指示器
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 错误页面
class _ErrorPage extends StatelessWidget {
  const _ErrorPage({this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('页面错误'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              '页面加载失败',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(RoutePaths.splash),
              child: const Text('返回首页'),
            ),
          ],
        ),
      ),
    );
  }
}
