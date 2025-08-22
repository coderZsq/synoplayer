import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form.dart';
import '../widgets/login_status.dart';
import '../widgets/error_display.dart';
import '../../quickconnect/presentation/services/quickconnect_service.dart';
import '../../quickconnect/entities/auth_login/auth_login_response.dart';

class SimpleLoginPage extends StatefulWidget {
  const SimpleLoginPage({super.key});

  @override
  State<SimpleLoginPage> createState() => _SimpleLoginPageState();
}

class _SimpleLoginPageState extends State<SimpleLoginPage> {
  final _quickConnectService = QuickConnectService2();
  
  LoginState _loginState = LoginState.idle;
  String? _errorMessage;
  AuthLoginResponse? _loginResponse;

  void _handleLogin({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    setState(() {
      _loginState = LoginState.loading;
      _errorMessage = null;
    });

    try {
      final response = await _quickConnectService.login(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );

      setState(() {
        _loginState = LoginState.success;
        _loginResponse = response;
      });
    } catch (e) {
      setState(() {
        _loginState = LoginState.error;
        _errorMessage = e.toString();
      });
    }
  }

  void _resetLogin() {
    setState(() {
      _loginState = LoginState.idle;
      _errorMessage = null;
      _loginResponse = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('登录'),
        backgroundColor: CupertinoColors.systemBackground,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const LoginHeader(),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LoginForm(
                        onLogin: _handleLogin,
                        onReset: _resetLogin,
                      ),
                      const SizedBox(height: 24),
                      if (_loginState == LoginState.error)
                        ErrorDisplay(
                          message: _errorMessage ?? '登录失败',
                          onRetry: _resetLogin,
                        ),
                      if (_loginState == LoginState.success)
                        LoginStatus(
                          response: _loginResponse!,
                          onBack: _resetLogin,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum LoginState { idle, loading, success, error }
