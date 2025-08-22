import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'form_fields/quick_connect_id_field.dart';
import 'form_fields/username_field.dart';
import 'form_fields/password_field.dart';
import 'form_fields/otp_field.dart';
import 'login_button.dart';

class LoginForm extends StatefulWidget {
  final Function({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) onLogin;
  final VoidCallback onReset;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.onLogin,
    required this.onReset,
    this.isLoading = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
        return CupertinoAlertDialog(
          content: Text(message),
          actions: [],
        );
      },
    );
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
      widget.onLogin(
        quickConnectId: _quickConnectIdController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        otpCode: _otpController.text.trim().isEmpty ? null : _otpController.text.trim(),
      );
    }
  }

  void _resetForm() {
    _quickConnectIdController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _otpController.clear();
    widget.onReset();
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: widget.isLoading ? null : _handleSubmit,
          isLoading: widget.isLoading,
        ),
      ],
    );
  }
}
