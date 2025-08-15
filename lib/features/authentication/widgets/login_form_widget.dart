import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/quickconnect/index.dart';
import '../../../credentials_service.dart';

/// 登录表单组件
/// 
/// 负责处理用户名、密码输入和登录逻辑
class LoginFormWidget extends ConsumerStatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.resolvedUrl,
    required this.workingAddress,
    required this.onLoginSuccess,
    required this.onLog,
    required this.onOtpRequired,
    required this.isLoading,
  });

  final String resolvedUrl;
  final String? workingAddress;
  final Function(String sid) onLoginSuccess;
  final Function(String message) onLog;
  final Function(String? workingAddress) onOtpRequired;
  final bool isLoading;

  @override
  ConsumerState<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends ConsumerState<LoginFormWidget> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _rememberCredentials = true;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  /// 加载已保存的凭据
  Future<void> _loadSavedCredentials() async {
    try {
      final credentials = await CredentialsService.autoLogin();
      if (credentials.isNotEmpty) {
        setState(() {
          _userCtrl.text = credentials['username'] ?? '';
          _passCtrl.text = credentials['password'] ?? '';
        });
      }
    } catch (e) {
      widget.onLog('❌ 加载保存凭据失败: $e');
    }
  }

  /// 执行登录
  Future<void> _performLogin() async {
    if (_userCtrl.text.trim().isEmpty || _passCtrl.text.trim().isEmpty) {
      widget.onLog('❌ 请输入用户名和密码');
      return;
    }

    try {
      widget.onLog('🔐 开始登录流程...');
      
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final result = await quickConnectService.login(
        baseUrl: widget.resolvedUrl,
        username: _userCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );

      if (result.isSuccess) {
        widget.onLog('🎉 登录成功! SID: ${result.sid}');
        
        // 保存登录凭据
        if (_rememberCredentials) {
          await _saveCredentials(result.sid!);
          widget.onLog('💾 登录凭据已保存');
        }
        
        widget.onLoginSuccess(result.sid!);
      } else if (result.requireOTP) {
        widget.onLog('⚠️ 需要二次验证 (OTP)');
        widget.onOtpRequired(widget.workingAddress);
      } else {
        widget.onLog('❌ 登录失败: ${result.errorMessage}');
      }
    } catch (e) {
      widget.onLog('❌ 登录异常: $e');
    }
  }

  /// 保存登录凭据
  Future<void> _saveCredentials(String sid) async {
    // 这个方法由父组件处理
    // 这里不需要实现具体逻辑
  }

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 标题
            Row(
              children: [
                Icon(
                  Icons.login,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '用户登录',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 用户名输入框
            TextField(
              controller: _userCtrl,
              enabled: !widget.isLoading,
              decoration: InputDecoration(
                labelText: '用户名',
                hintText: '输入您的群晖账户用户名',
                prefixIcon: const Icon(Icons.person),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
            ),
            const SizedBox(height: 12),

            // 密码输入框
            TextField(
              controller: _passCtrl,
              enabled: !widget.isLoading,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: '密码',
                hintText: '输入您的账户密码',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
            ),
            const SizedBox(height: 12),

            // 记住密码选项
            _buildRememberCredentialsRow(theme),
            const SizedBox(height: 20),

            // 登录按钮
            _buildLoginButton(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildRememberCredentialsRow(ThemeData theme) {
    return Row(
      children: [
        Checkbox(
          value: _rememberCredentials,
          onChanged: widget.isLoading ? null : (value) {
            setState(() {
              _rememberCredentials = value ?? true;
            });
          },
        ),
        Text(
          '记住登录信息',
          style: theme.textTheme.bodyMedium,
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: widget.isLoading ? null : () async {
            await CredentialsService.clearCredentials();
            setState(() {
              _userCtrl.clear();
              _passCtrl.clear();
            });
            widget.onLog('🗑️ 已清除保存的登录凭据');
          },
          icon: const Icon(Icons.delete, size: 16),
          label: const Text('清除凭据'),
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.error,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(ThemeData theme) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: widget.isLoading ? null : _performLogin,
        icon: widget.isLoading 
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onPrimary,
                  ),
                ),
              )
            : const Icon(Icons.login),
        label: Text(widget.isLoading ? '登录中...' : '登录'),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
