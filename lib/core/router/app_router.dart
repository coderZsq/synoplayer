import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../login/pages/login_page.dart';
import '../../pages/home_page.dart';
import '../../pages/loading_page.dart';
import 'route_names.dart';
import 'navigation_service.dart';

/// 应用路由配置
class AppRouter {
  /// 主路由配置
  static final GoRouter router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: '/loading',
    routes: [
      GoRoute(
        path: '/loading',
        name: 'loading',
        pageBuilder: (context, state) => CupertinoPage<void>(
          key: state.pageKey,
          child: const LoadingPage(),
        ),
      ),
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
