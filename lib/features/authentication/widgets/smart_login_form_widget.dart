import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/quickconnect/index.dart';
import '../../../core/services/index.dart';

/// 智能登录表单组件
/// 
/// 集成QuickConnect ID输入、用户凭据输入和智能登录功能
class SmartLoginFormWidget extends ConsumerStatefulWidget {
  const SmartLoginFormWidget({
    super.key,
    required this.onLoginSuccess,
    required this.onLog,
    required this.onOtpRequired,
    required this.isLoading,
    required this.onLoadingChanged,
  });

  final Function(String sid, String workingAddress, String username, String quickConnectId) onLoginSuccess;
  final Function(String message) onLog;
  final Function(String? workingAddress, String username, String password, String quickConnectId, bool rememberCredentials) onOtpRequired;
  final bool isLoading;
  final Function(bool loading) onLoadingChanged;

  @override
  ConsumerState<SmartLoginFormWidget> createState() => _SmartLoginFormWidgetState();
}

class _SmartLoginFormWidgetState extends ConsumerState<SmartLoginFormWidget> {
  final _quickConnectIdCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _rememberCredentials = true;
  bool _obscurePassword = true;
  bool _hasAutoFilledCredentials = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _quickConnectIdCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  /// 加载已保存的凭据
  Future<void> _loadSavedCredentials() async {
    try {
      final credentialsService = CredentialsService();
      final credentials = await credentialsService.getCredentials();
      if (credentials != null) {
        setState(() {
          _quickConnectIdCtrl.text = credentials.quickConnectId;
          _usernameCtrl.text = credentials.username;
          _passwordCtrl.text = credentials.password;
          _hasAutoFilledCredentials = true;
        });
        
        widget.onLog('🔄 检测到保存的登录凭据');
        widget.onLog('💡 您可以直接点击"智能登录"按钮');
      }
    } catch (e) {
      widget.onLog('❌ 加载保存凭据失败: $e');
    }
  }

  /// 执行智能登录
  Future<void> _performSmartLogin() async {
    if (_quickConnectIdCtrl.text.trim().isEmpty) {
      widget.onLog('❌ 请输入 QuickConnect ID');
      return;
    }

    if (_usernameCtrl.text.trim().isEmpty || _passwordCtrl.text.trim().isEmpty) {
      widget.onLog('❌ 请输入用户名和密码');
      return;
    }

    widget.onLoadingChanged(true);

    try {
      widget.onLog('🚀 开始智能登录流程...');
      widget.onLog('📡 系统将自动解析地址并尝试登录');
      
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final result = await quickConnectService.smartLogin(
        quickConnectId: _quickConnectIdCtrl.text.trim(),
        username: _usernameCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );

      if (result.isSuccess) {
        widget.onLog('🎉 智能登录成功! SID: ${result.sid}');
        widget.onLog('🔧 _rememberCredentials = $_rememberCredentials');
        
        // 保存登录凭据
        if (_rememberCredentials) {
          widget.onLog('💾 开始保存登录凭据...');
          await _saveCredentials(result.sid!, result.availableAddress ?? '');
          widget.onLog('💾 登录凭据保存流程完成');
        } else {
          widget.onLog('⚠️ 未选择记住凭据，不会保存登录信息');
        }
        
        widget.onLoginSuccess(
          result.sid!, 
          result.availableAddress ?? '', 
          _usernameCtrl.text.trim(),
          _quickConnectIdCtrl.text.trim(),
        );
      } else if (result.requireOTP) {
        widget.onLog('⚠️ 需要二次验证 (OTP)');
        widget.onLog('📱 请在手机上查看验证码并输入');
        widget.onOtpRequired(
          result.availableAddress, 
          _usernameCtrl.text.trim(), 
          _passwordCtrl.text.trim(),
          _quickConnectIdCtrl.text.trim(),
          _rememberCredentials,
        );
      } else {
        widget.onLog('❌ 智能登录失败: ${result.errorMessage}');
      }
    } catch (e) {
      widget.onLog('❌ 智能登录异常: $e');
    } finally {
      widget.onLoadingChanged(false);
    }
  }

  /// 保存登录凭据
  Future<void> _saveCredentials(String sid, String workingAddress) async {
    try {
      final credentialsService = CredentialsService();
      final credentials = LoginCredentials(
        quickConnectId: _quickConnectIdCtrl.text.trim(),
        username: _usernameCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
        workingAddress: workingAddress,
        sid: sid,
        loginTime: DateTime.now(),
        rememberCredentials: _rememberCredentials,
      );
      
      widget.onLog('🔧 准备保存凭据: rememberCredentials=$_rememberCredentials');
      widget.onLog('🔧 SID: $sid');
      widget.onLog('🔧 工作地址: $workingAddress');
      
      await credentialsService.saveCredentials(credentials);
      
      // 验证保存是否成功
      final savedCredentials = await credentialsService.getCredentials();
      if (savedCredentials != null) {
        widget.onLog('✅ 凭据保存成功，SID: ${savedCredentials.sid}');
      } else {
        widget.onLog('❌ 凭据保存失败：未能读取保存的凭据');
      }
    } catch (e) {
      widget.onLog('❌ 保存凭据失败: $e');
    }
  }

  /// 清除保存的凭据
  Future<void> _clearCredentials() async {
    try {
      final credentialsService = CredentialsService();
      await credentialsService.clearCredentials();
      setState(() {
        _quickConnectIdCtrl.clear();
        _usernameCtrl.clear();
        _passwordCtrl.clear();
        _hasAutoFilledCredentials = false;
      });
      widget.onLog('🗑️ 已清除保存的登录凭据');
    } catch (e) {
      widget.onLog('❌ 清除凭据失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 标题
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '群晖智能登录',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        '自动解析地址并选择最佳连接方式',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // QuickConnect ID 输入框
            TextField(
              controller: _quickConnectIdCtrl,
              enabled: !widget.isLoading,
              decoration: InputDecoration(
                labelText: 'QuickConnect ID',
                hintText: '例如: yourname',
                prefixIcon: const Icon(Icons.router),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: theme.colorScheme.surface,
                helperText: '输入您的群晖 QuickConnect ID',
              ),
            ),
            const SizedBox(height: 16),

            // 用户名输入框
            TextField(
              controller: _usernameCtrl,
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
            const SizedBox(height: 16),

            // 密码输入框
            TextField(
              controller: _passwordCtrl,
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
            const SizedBox(height: 16),

            // 选项行
            Row(
              children: [
                Checkbox(
                  value: _rememberCredentials,
                  onChanged: widget.isLoading ? null : (value) {
                    setState(() {
                      _rememberCredentials = value ?? true;
                    });
                  },
                ),
                const Text('记住登录信息'),
                const Spacer(),
                if (_hasAutoFilledCredentials)
                  TextButton.icon(
                    onPressed: widget.isLoading ? null : _clearCredentials,
                    icon: const Icon(Icons.delete, size: 16),
                    label: const Text('清除凭据'),
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.error,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // 智能登录按钮
            SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: widget.isLoading ? null : _performSmartLogin,
                icon: widget.isLoading 
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.colorScheme.onPrimary,
                        ),
                      )
                    : const Icon(Icons.auto_awesome, size: 24),
                label: Text(
                  widget.isLoading ? '智能登录中...' : '智能登录',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 功能说明
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.blue.shade900.withValues(alpha: 0.3) : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark ? Colors.blue.shade700 : Colors.blue.shade200,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: isDark ? Colors.blue.shade300 : Colors.blue.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '智能登录功能',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• 自动解析并测试所有可用连接地址\n'
                    '• 优先选择最快的直连地址进行连接\n'
                    '• 自动处理连接失败和重试逻辑\n'
                    '• 支持二次验证(OTP)和会话保持',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.blue.shade200 : Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
