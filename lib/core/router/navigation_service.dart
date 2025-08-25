import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

/// 全局导航服务（统一的路由导航工具）
class NavigationService {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  
  /// 获取全局导航键
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  
  /// 获取当前上下文
  static BuildContext? get currentContext => _navigatorKey.currentContext;
  
  /// 跳转到主页
  static void goToHome({Map<String, dynamic>? extra}) {
    final context = currentContext;
    if (context != null) {
      context.go(RouteNames.audioList, extra: extra);
    }
  }
  
  /// 跳转到登录页
  static void goToLogin({Map<String, dynamic>? extra}) {
    final context = currentContext;
    if (context != null) {
      context.go(RouteNames.login, extra: extra);
    }
  }
  
  /// 替换当前路由到主页
  static void replaceWithHome({Map<String, dynamic>? extra}) {
    final context = currentContext;
    if (context != null) {
      context.pushReplacement(RouteNames.audioList, extra: extra);
    }
  }
  
  /// 替换当前路由到登录页
  static void replaceWithLogin({Map<String, dynamic>? extra}) {
    final context = currentContext;
    if (context != null) {
      context.pushReplacement(RouteNames.login, extra: extra);
    }
  }
  
  /// 返回上一页
  static void goBack() {
    final context = currentContext;
    if (context != null && context.canPop()) {
      context.pop();
    }
  }
  
  /// 检查是否可以返回
  static bool canGoBack() {
    final context = currentContext;
    return context?.canPop() ?? false;
  }
  
  /// 获取路由参数
  static Map<String, dynamic>? getRouteExtra(GoRouterState state) {
    return state.extra as Map<String, dynamic>?;
  }
  
  /// 获取路由查询参数
  static Map<String, String> getQueryParams(GoRouterState state) {
    return state.uri.queryParameters;
  }
  
  // 私有构造函数，防止实例化
  NavigationService._();
}
