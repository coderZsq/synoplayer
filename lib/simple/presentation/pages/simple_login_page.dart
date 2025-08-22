import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form.dart';
import '../providers/login_provider.dart';

class SimpleLoginPage extends ConsumerWidget {
  const SimpleLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginData = ref.watch(loginNotifierProvider);
    final loginNotifier = ref.read(loginNotifierProvider.notifier);

    void handleLogin({
      required String quickConnectId,
      required String username,
      required String password,
      String? otpCode,
    }) {
      loginNotifier.login(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
    }

    void resetLogin() {
      loginNotifier.reset();
    }

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
                LoginForm(
                  onLogin: handleLogin,
                  onReset: resetLogin,
                  isLoading: loginData.state == LoginState.loading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
