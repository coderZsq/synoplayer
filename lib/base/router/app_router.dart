import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../components/audio/presentation/pages/audio_list_page.dart';
import '../../components/login/presentation/pages/login_page.dart';
import '../auth/auth_state_notifier.dart';
import '../router/route_names.dart';
import 'navigation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/logger.dart';

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
        path: RouteNames.audioList,
        name: 'audio_list',
        pageBuilder: (context, state) => CupertinoPage<void>(
          key: state.pageKey,
          child: const AudioListPage(),
        ),
      ),
    ],
  );
  
  // 私有构造函数，防止实例化
  AppRouter._();
}

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({super.key});

  @override
  ConsumerState<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // 在页面初始化时触发自动登录检查
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAutoLogin();
    });
  }

  Future<void> _checkAutoLogin() async {
    Logger.info('开始检查自动登录', tag: 'LoadingPage');
    final result = await ref.read(authStateNotifierProvider.notifier).checkAutoLogin();
    Logger.info('自动登录检查完成，结果: $result', tag: 'LoadingPage');

    if (result) {
      // 自动登录成功，跳转到主页
      Logger.info('自动登录成功，跳转到主页', tag: 'LoadingPage');
      Future.delayed(const Duration(milliseconds: 100), () {
        try {
          NavigationService.replaceWithHome();
        } catch (e) {
          Logger.warning('导航到主页失败: $e', tag: 'LoadingPage');
        }
      });
    } else {
      // 自动登录失败，跳转到登录页
      Logger.info('自动登录失败，跳转到登录页', tag: 'LoadingPage');
      Future.delayed(const Duration(milliseconds: 100), () {
        try {
          NavigationService.replaceWithLogin();
        } catch (e) {
          Logger.warning('导航到登录页失败: $e', tag: 'LoadingPage');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(radius: 20),
              SizedBox(height: 20),
              Text(
                '正在检查登录状态...',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
