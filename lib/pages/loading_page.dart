import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/auth/auth_state_notifier.dart';
import '../core/router/navigation_service.dart';

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
    print('🔍 LoadingPage: 开始检查自动登录');
    final result = await ref.read(authStateNotifierProvider.notifier).checkAutoLogin();
    print('🔍 LoadingPage: 自动登录检查完成，结果: $result');
    
    if (result) {
      // 自动登录成功，跳转到主页
      print('🔍 LoadingPage: 自动登录成功，跳转到主页');
      Future.delayed(const Duration(milliseconds: 100), () {
        try {
          NavigationService.replaceWithHome();
        } catch (e) {
          print('⚠️ LoadingPage: 导航到主页失败: $e');
        }
      });
    } else {
      // 自动登录失败，跳转到登录页
      print('🔍 LoadingPage: 自动登录失败，跳转到登录页');
      Future.delayed(const Duration(milliseconds: 100), () {
        try {
          NavigationService.replaceWithLogin();
        } catch (e) {
          print('⚠️ LoadingPage: 导航到登录页失败: $e');
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
