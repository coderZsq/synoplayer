import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/login_provider.dart';
import 'form_fields/quick_connect_id_field.dart';
import 'form_fields/username_field.dart';
import 'form_fields/password_field.dart';
import 'form_fields/otp_field.dart';
import 'login_button.dart';
import '../../core/widgets/error_display_helper.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _quickConnectIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _quickConnectIdController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _showToast(String message) {
    if (mounted) {
      ErrorDisplayHelper.showError(
        context, 
        message,
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool _validateForm() {
    // 验证 QuickConnect ID
    if (_quickConnectIdController.text.trim().isEmpty) {
      _showToast('QuickConnect ID 不能为空');
      return false;
    } else if (_quickConnectIdController.text.trim().length < 3) {
      _showToast('QuickConnect ID 至少需要 3 个字符');
      return false;
    }

    // 验证用户名
    if (_usernameController.text.trim().isEmpty) {
      _showToast('用户名不能为空');
      return false;
    } else if (_usernameController.text.trim().length < 2) {
      _showToast('用户名至少需要 2 个字符');
      return false;
    }

    // 验证密码
    if (_passwordController.text.isEmpty) {
      _showToast('密码不能为空');
      return false;
    } else if (_passwordController.text.length < 6) {
      _showToast('密码至少需要 6 个字符');
      return false;
    }

    return true;
  }

  void _handleSubmit() {
    if (_validateForm()) {
      final loginNotifier = ref.read(loginNotifierProvider.notifier);
      loginNotifier.login(
        quickConnectId: _quickConnectIdController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        otpCode: _otpController.text.trim().isEmpty ? null : _otpController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginAsync = ref.watch(loginNotifierProvider);
    
    return Column(
      children: [
        QuickConnectIdField(
          controller: _quickConnectIdController,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        const SizedBox(height: 16),
        UsernameField(
          controller: _usernameController,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        const SizedBox(height: 16),
        PasswordField(
          controller: _passwordController,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        const SizedBox(height: 16),
        OtpField(
          controller: _otpController,
          onFieldSubmitted: (_) => _handleSubmit(),
        ),
        const SizedBox(height: 24),
        LoginButton(
          onPressed: loginAsync.isLoading ? null : _handleSubmit,
          isLoading: loginAsync.isLoading,
        ),
      ],
    );
  }
}
