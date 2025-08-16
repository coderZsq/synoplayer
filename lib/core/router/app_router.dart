import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/authentication/pages/login_page.dart';
import '../../features/dashboard/pages/main_page.dart';
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
        builder: (context, state) => const SplashPage(),
      ),
      
      // 登录页
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      
      // 主页面
      GoRoute(
        path: RoutePaths.dashboard,
        builder: (context, state) {
          // 从查询参数获取必要信息
          final sid = state.uri.queryParameters['sid'] ?? '';
          final username = state.uri.queryParameters['username'] ?? '';
          final quickConnectId = state.uri.queryParameters['quickConnectId'] ?? '';
          final workingAddress = state.uri.queryParameters['workingAddress'] ?? '';
          
          if (sid.isEmpty || username.isEmpty || quickConnectId.isEmpty) {
            // 参数不完整，重定向到登录页
            return const LoginPage();
          }
          
          return MainPage(
            sid: sid,
            username: username,
            quickConnectId: quickConnectId,
            workingAddress: workingAddress,
          );
        },
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
  static const String dashboard = '/dashboard';
}

/// 路由扩展方法
extension AppRouterExtension on GoRouter {
  /// 导航到启动页
  void goToSplash() => go(RoutePaths.splash);
  
  /// 导航到登录页
  void goToLogin() => go(RoutePaths.login);
  
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

class _SplashPageState extends ConsumerState<SplashPage> {
  Timer? _timeoutTimer;
  int _checkCount = 0;
  static const int _maxCheckCount = 3;
  bool _isNavigating = false; // 防止重复导航

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    
    // 设置超时定时器
    _timeoutTimer = Timer(const Duration(seconds: 5), () async {
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
    });
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

  Future<void> _checkLoginStatus() async {
    try {
      // 检查是否可以继续操作
      if (!_canContinue) {
        AppLogger.info('🛑 操作已停止，跳过检查');
        return;
      }
      
      _checkCount++;
      AppLogger.info('🔍 启动页第 $_checkCount 次检查认证状态');
      
      // 检查次数限制
      if (_checkCount > _maxCheckCount) {
        AppLogger.warning('⚠️ 检查次数超限，尝试直接检查凭据');
        await _checkCredentialsDirectly();
        return;
      }
      
      // 延迟 1 秒模拟检查过程
      await Future.delayed(const Duration(seconds: 1));
      
      // 尝试强制刷新认证状态
      if (_checkCount == 1) {
        AppLogger.info('🔄 首次检查，尝试刷新认证状态');
        try {
          final authNotifier = ref.read(authNotifierProvider.notifier);
          await authNotifier.refreshAuthStatus();
          
          // 等待状态更新
          await Future.delayed(const Duration(milliseconds: 300));
          
          // 尝试强制刷新 Provider
          AppLogger.info('🔄 尝试强制刷新 Provider 状态');
          ref.invalidate(authNotifierProvider);
          
          // 再次等待
          await Future.delayed(const Duration(milliseconds: 300));
          
          // 如果状态仍然是加载中，立即尝试直接检查
          final currentAuthState = ref.read(authNotifierProvider);
          if (currentAuthState.isLoading) {
            AppLogger.info('🔄 Provider 状态仍为加载中，立即尝试直接检查');
            await _checkCredentialsDirectly();
            return;
          }
        } catch (e) {
          AppLogger.warning('⚠️ 刷新认证状态失败: $e');
        }
      }
      
      // 使用新的认证状态管理
      final authState = ref.read(authNotifierProvider);
      
      AppLogger.debug('🔍 当前认证状态: ${authState.runtimeType}');
      
      // 如果状态仍然是加载中，尝试直接检查凭据
      if (authState.isLoading && _checkCount > 1) {
        AppLogger.warning('⚠️ 状态持续加载中，尝试直接检查凭据');
        await _checkCredentialsDirectly();
        return;
      }
      
      authState.when(
        data: (state) {
          AppLogger.info('📊 认证状态: ${state.runtimeType}');
          
          if (state.isAuthenticated) {
            // 已认证，跳转到主页面
            final credentials = state.credentials;
            if (credentials != null) {
              final dashboardUrl = '${RoutePaths.dashboard}?sid=${credentials.sid}&username=${credentials.username}&quickConnectId=${credentials.quickConnectId}&workingAddress=${credentials.workingAddress}';
              AppLogger.info('🚀 跳转到主页面: $dashboardUrl');
              if (mounted) {
                // 跳转成功后立即停止所有操作
                _stopAllOperations();
                context.go(dashboardUrl);
                return;
              }
            } else {
              AppLogger.warning('⚠️ 凭据为空，跳转到登录页');
              if (mounted) {
                _stopAllOperations();
                context.go(RoutePaths.login);
                return;
              }
            }
          } else {
            // 未认证，跳转到登录页
            AppLogger.info('📝 未认证，跳转到登录页');
            if (mounted) {
              _stopAllOperations();
              context.go(RoutePaths.login);
              return;
            }
          }
        },
        loading: () {
          // 正在加载，等待状态更新
          AppLogger.info('⏳ 认证状态加载中，等待...');
          
                // 如果是首次加载，等待更长时间
      if (_checkCount == 1) {
        AppLogger.info('⏳ 首次加载，等待状态初始化...');
        Future.delayed(const Duration(seconds: 1), () {
          if (_canContinue) {
            _checkLoginStatus();
          }
        });
      } else {
        // 延迟后再次检查
        Future.delayed(const Duration(milliseconds: 500), () {
          if (_canContinue) {
            _checkLoginStatus();
          }
        });
      }
        },
        error: (error, stackTrace) {
          // 出错时跳转到登录页
          AppLogger.error('❌ 认证状态检查失败，跳转到登录页', error: error, stackTrace: stackTrace);
          if (mounted) {
            _stopAllOperations();
            context.go(RoutePaths.login);
            return;
          }
        },
      );
    } catch (e) {
      // 出错时跳转到登录页
      AppLogger.error('🚨 状态检查异常，跳转到登录页', error: e);
      
      // 检查是否是 ref 被销毁的错误
      if (e.toString().contains('Cannot use "ref" after the widget was disposed')) {
        AppLogger.warning('⚠️ ref 已被销毁，尝试直接检查凭据');
        try {
          await _checkCredentialsDirectly();
        } catch (directError) {
          AppLogger.error('🚨 直接检查也失败，跳转到登录页', error: directError);
          if (mounted) {
            _stopAllOperations();
            context.go(RoutePaths.login);
            return;
          }
        }
      } else {
        if (mounted) {
          _stopAllOperations();
          context.go(RoutePaths.login);
          return;
        }
      }
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
