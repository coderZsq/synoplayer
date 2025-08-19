import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import '../providers/quickconnect_providers.dart';
import '../../../../core/utils/logger.dart';

/// OTP 验证组件 - 基于新的 Clean Architecture
/// 
/// 使用新的用例和状态管理来处理二次验证功能
class OtpVerificationWidget extends ConsumerStatefulWidget {
  const OtpVerificationWidget({
    super.key,
    required this.workingAddress,
    required this.username,
    required this.password,
    required this.quickConnectId,
    required this.rememberCredentials,
    required this.onLoginSuccess,
    required this.onLog,
    required this.onCancel,
    required this.isLoading,
  });

  final String workingAddress;
  final String username;
  final String password;
  final String quickConnectId;
  final bool rememberCredentials;
  final Function(String sid) onLoginSuccess;
  final Function(String message) onLog;
  final VoidCallback onCancel;
  final bool isLoading;

  @override
  ConsumerState<OtpVerificationWidget> createState() => _OtpVerificationWidgetState();
}

class _OtpVerificationWidgetState extends ConsumerState<OtpVerificationWidget>
    with TickerProviderStateMixin {
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isSubmitting = false;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
    
    // 自动聚焦到 OTP 输入框并显示日志
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      widget.onLog('📱 请输入手机上收到的验证码');
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  /// 提交 OTP 验证
  Future<void> _submitOtp() async {
    if (_otpController.text.trim().isEmpty) {
      widget.onLog('❌ 请输入验证码');
      return;
    }

    if (_otpController.text.trim().length < 6) {
      widget.onLog('❌ 验证码长度不正确');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      widget.onLog('🔐 正在验证 OTP 码...');
      
      // 使用新的架构进行 OTP 登录
      final loginNotifier = ref.read(loginNotifierProvider.notifier);
      
      await loginNotifier.login(
        address: widget.workingAddress,
        username: widget.username,
        password: widget.password,
        otpCode: _otpController.text.trim(),
        rememberMe: widget.rememberCredentials,
      );
      
      final loginState = ref.read(loginNotifierProvider);
      if (loginState.hasError) {
        widget.onLog('❌ OTP 验证失败: ${loginState.error}');
        
        // 清空 OTP 输入框以便重新输入
        _otpController.clear();
        _focusNode.requestFocus();
        return;
      }
      
      final loginResult = loginState.valueOrNull;
      if (loginResult == null) {
        widget.onLog('❌ 无法获取登录结果');
        return;
      }
      
      if (loginResult.isSuccess && loginResult.sid != null) {
        widget.onLog('✅ OTP 验证成功! SID: ${loginResult.sid}');
        widget.onLoginSuccess(loginResult.sid!);
      } else {
        widget.onLog('❌ OTP 验证失败: ${loginResult.errorMessage ?? '未知错误'}');
        
        // 清空 OTP 输入框以便重新输入
        _otpController.clear();
        _focusNode.requestFocus();
      }
    } catch (e) {
      widget.onLog('❌ OTP 验证异常: $e');
      AppLogger.error('OTP verification failed', error: e);
      
      // 清空 OTP 输入框以便重新输入
      _otpController.clear();
      _focusNode.requestFocus();
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  /// 取消 OTP 验证
  void _cancelOtp() {
    _animationController.reverse().then((_) {
      if (mounted) {
        widget.onCancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Card(
          elevation: 8,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: theme.colorScheme.primary.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.surface,
                  theme.colorScheme.surface.withOpacity(0.8),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 标题和图标
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.security,
                          color: theme.colorScheme.primary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '二次验证',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '请输入手机上收到的验证码',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 账户信息显示
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark 
                          ? Colors.grey.shade800.withOpacity(0.5)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '登录信息',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow('QuickConnect ID', widget.quickConnectId),
                        _buildInfoRow('用户名', widget.username),
                        _buildInfoRow('服务器地址', widget.workingAddress),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // OTP 输入框
                  TextField(
                    controller: _otpController,
                    focusNode: _focusNode,
                    enabled: !_isSubmitting && !widget.isLoading,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8.0,
                    ),
                    decoration: InputDecoration(
                      labelText: '验证码',
                      hintText: '000000',
                      prefixIcon: const Icon(Icons.pin),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      counterText: '',
                      helperText: '通常为6位数字',
                    ),
                    onSubmitted: (_) => _submitOtp(),
                  ),
                  const SizedBox(height: 24),

                  // 按钮行
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: (_isSubmitting || widget.isLoading) ? null : _cancelOtp,
                          icon: const Icon(Icons.close, size: 20),
                          label: const Text('取消'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: (_isSubmitting || widget.isLoading) ? null : _submitOtp,
                          icon: (_isSubmitting || widget.isLoading)
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                )
                              : const Icon(Icons.check, size: 20),
                          label: Text(
                            (_isSubmitting || widget.isLoading) ? '验证中...' : '验证',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 帮助信息
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark 
                          ? Colors.orange.shade900.withOpacity(0.3) 
                          : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark ? Colors.orange.shade700 : Colors.orange.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.help_outline,
                          size: 20,
                          color: isDark ? Colors.orange.shade300 : Colors.orange.shade600,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '验证码通常在 SMS 短信或认证应用中显示，有效期通常为 30 秒到 5 分钟',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.orange.shade200 : Colors.orange.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 构建信息行
  Widget _buildInfoRow(String label, String value) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
