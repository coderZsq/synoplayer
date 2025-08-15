import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/quickconnect/index.dart';

/// 智能登录组件
/// 
/// 提供一键智能登录功能，自动尝试所有可用地址
class SmartLoginWidget extends ConsumerWidget {
  const SmartLoginWidget({
    super.key,
    required this.quickConnectId,
    required this.username,
    required this.password,
    required this.otpCode,
    required this.onLoginSuccess,
    required this.onLog,
    required this.onOtpRequired,
    required this.isLoading,
  });

  final String quickConnectId;
  final String username;
  final String password;
  final String? otpCode;
  final Function(String sid, String workingAddress) onLoginSuccess;
  final Function(String message) onLog;
  final Function(String? workingAddress) onOtpRequired;
  final bool isLoading;

  /// 执行智能登录
  Future<void> _performSmartLogin(WidgetRef ref) async {
    if (quickConnectId.trim().isEmpty) {
      onLog('❌ 请输入 QuickConnect ID');
      return;
    }

    if (username.trim().isEmpty || password.trim().isEmpty) {
      onLog('❌ 请输入用户名和密码');
      return;
    }

    try {
      onLog('🚀 开始智能登录流程...');
      onLog('📡 系统将自动尝试所有可用地址进行登录');
      
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final result = await quickConnectService.smartLogin(
        quickConnectId: quickConnectId.trim(),
        username: username.trim(),
        password: password.trim(),
        otpCode: otpCode?.trim(),
      );

      if (result.isSuccess) {
        onLog('🎉 智能登录成功! SID: ${result.sid}');
        onLoginSuccess(result.sid!, result.availableAddress ?? '');
      } else if (result.requireOTP) {
        onLog('⚠️ 需要二次验证 (OTP)');
        onLog('📱 请在手机上查看验证码并输入');
        onOtpRequired(result.availableAddress);
      } else {
        onLog('❌ 智能登录失败: ${result.errorMessage}');
      }
    } catch (e) {
      onLog('❌ 智能登录异常: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Card(
      elevation: 2,
      color: isDark ? Colors.purple.shade900.withOpacity(0.3) : Colors.purple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 标题
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.purple,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '智能登录',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.purple.shade300 : Colors.purple.shade700,
                        ),
                      ),
                      Text(
                        '自动尝试所有可用地址',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.purple.shade200 : Colors.purple.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 功能说明
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.purple.shade800.withOpacity(0.3) : Colors.purple.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark ? Colors.purple.shade600 : Colors.purple.shade300,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: 16,
                        color: isDark ? Colors.purple.shade300 : Colors.purple.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '智能登录优势',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: isDark ? Colors.purple.shade300 : Colors.purple.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• 自动解析并测试所有可用连接地址\n'
                    '• 优先选择最快的直连地址\n'
                    '• 自动处理连接失败重试逻辑\n'
                    '• 一键完成整个登录流程',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.purple.shade200 : Colors.purple.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 智能登录按钮
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : () => _performSmartLogin(ref),
                icon: isLoading 
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
                    : const Icon(Icons.auto_awesome),
                label: Text(isLoading ? '智能登录中...' : '开始智能登录'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}