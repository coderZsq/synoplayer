import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../login/pages/login_page.dart';
import '../../pages/home_page.dart';
import '../auth/auth_state_notifier.dart';
import 'route_names.dart';
import 'navigation_service.dart';

/// 应用路由配置
class AppRouter {
  static WidgetRef? _ref;
  
  /// 设置 Riverpod 引用
  static void setRef(WidgetRef ref) {
    _ref = ref;
  }
  
  /// 主路由配置
  static final GoRouter router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: RouteNames.login,
    redirect: (context, state) {
      // 检查登录状态
      final isLoggedIn = _ref?.read(authStateNotifierProvider).isAuthenticated ?? false;
      final isLoginPage = state.fullPath == RouteNames.login;
      
      // 如果未登录且不在登录页，重定向到登录页
      if (!isLoggedIn && !isLoginPage) {
        return RouteNames.login;
      }
      
      // 如果已登录且在登录页，重定向到主页
      if (isLoggedIn && isLoginPage) {
        return RouteNames.home;
      }
      return null; // 不需要重定向
    },
    routes: [
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        pageBuilder: (context, state) => CupertinoPage<void>(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        pageBuilder: (context, state) => CupertinoPage<void>(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
    ],
  );
  
  // 私有构造函数，防止实例化
  AppRouter._();
}
