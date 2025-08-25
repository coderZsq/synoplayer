import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/auth/auth_state_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('🏠 主页'),
        backgroundColor: CupertinoColors.systemBackground,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            ref.read(authStateNotifierProvider.notifier).logout();
            context.go('/login');
          },
          child: const Text('登出'),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.home,
                size: 100,
                color: CupertinoColors.systemBlue,
              ),
              const SizedBox(height: 20),
              const Text(
                '🎉 登录成功！',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '欢迎来到主页',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const SizedBox(height: 40),
              CupertinoButton.filled(
                onPressed: () => context.go('/test'),
                child: const Text('测试存储功能'),
              ),
              const SizedBox(height: 16),
              CupertinoButton.filled(
                onPressed: () {
                  ref.read(authStateNotifierProvider.notifier).logout();
                  context.go('/login');
                },
                child: const Text('登出'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
