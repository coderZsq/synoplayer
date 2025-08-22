import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/login_provider.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';
import '../../core/widgets/error_display_helper.dart';
import '../../core/auth/auth_state_notifier.dart';
import '../../core/router/navigation_service.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听登录状态变化
    ref.listen<AsyncValue<dynamic>>(loginNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          // 使用 Future.microtask 避免 BuildContext 异步使用问题
          Future.microtask(() {
            if (context.mounted) {
              ErrorDisplayHelper.showError(
                context, 
                error,
                duration: const Duration(seconds: 3),
              );
            }
          });
        },
        data: (response) {
          if (response != null && previous?.value == null) {
            ref.read(authStateNotifierProvider.notifier).login(response);
            NavigationService.goToHome();
          }
        },
      );
    });
    


    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemBackground,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const LoginHeader(),
                const SizedBox(height: 32),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
