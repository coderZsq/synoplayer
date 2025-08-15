import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/quickconnect/index.dart';

/// OTP验证组件
/// 
/// 负责处理二次验证（OTP）输入和验证
class OtpVerificationWidget extends ConsumerStatefulWidget {
  const OtpVerificationWidget({
    super.key,
    required this.workingAddress,
    required this.username,
    required this.password,
    required this.onLoginSuccess,
    required this.onLog,
    required this.onCancel,
    required this.isLoading,
  });

  final String workingAddress;
  final String username;
  final String password;
  final Function(String sid) onLoginSuccess;
  final Function(String message) onLog;
  final VoidCallback onCancel;
  final bool isLoading;

  @override
  ConsumerState<OtpVerificationWidget> createState() => _OtpVerificationWidgetState();
}

class _OtpVerificationWidgetState extends ConsumerState<OtpVerificationWidget> 
    with TickerProviderStateMixin {
  final _otpCtrl = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _otpCtrl.dispose();
    _animationController.dispose();
    super.dispose();
  }

  /// 执行OTP验证登录
  Future<void> _performOtpLogin() async {
    if (_otpCtrl.text.trim().isEmpty) {
      widget.onLog('❌ 请输入 OTP 验证码');
      return;
    }

    if (_otpCtrl.text.trim().length != 6) {
      widget.onLog('❌ OTP 验证码应为6位数字');
      return;
    }

    try {
      widget.onLog('🔐 使用 OTP 验证登录...');
      
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final result = await quickConnectService.loginWithOTPAtAddress(
        baseUrl: widget.workingAddress,
        username: widget.username,
        password: widget.password,
        otpCode: _otpCtrl.text.trim(),
      );

      if (result.isSuccess) {
        widget.onLog('🎉 OTP 验证成功，登录完成!');
        widget.onLoginSuccess(result.sid!);
      } else {
        widget.onLog('❌ OTP 验证失败: ${result.errorMessage}');
        // 清空输入框让用户重新输入
        _otpCtrl.clear();
      }
    } catch (e) {
      widget.onLog('❌ OTP 验证异常: $e');
      _otpCtrl.clear();
    }
  }

  /// 取消OTP验证
  void _cancelOtpVerification() async {
    await _animationController.reverse();
    widget.onCancel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(_slideAnimation),
      child: FadeTransition(
        opacity: _slideAnimation,
        child: Card(
          elevation: 4,
          color: theme.colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 标题
                _buildHeader(theme),
                const SizedBox(height: 16),

                // 说明文字
                _buildDescription(theme),
                const SizedBox(height: 20),

                // OTP输入框
                _buildOtpTextField(theme),
                const SizedBox(height: 20),

                // 按钮组
                _buildActionButtons(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.security,
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
                '二次验证',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSecondaryContainer,
                ),
              ),
              Text(
                '需要输入 OTP 验证码',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSecondaryContainer.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: widget.isLoading ? null : _cancelOtpVerification,
          icon: const Icon(Icons.close),
          tooltip: '取消验证',
        ),
      ],
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.smartphone,
                color: theme.colorScheme.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                '获取验证码',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '• 打开您的验证器应用（如 Google Authenticator、Authy 等）\n'
            '• 找到群晖账户对应的6位数字验证码\n'
            '• 在下方输入框中输入验证码',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpTextField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OTP 验证码',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSecondaryContainer,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _otpCtrl,
          enabled: !widget.isLoading,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 6,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: theme.textTheme.headlineSmall?.copyWith(
            letterSpacing: 8,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: '000000',
            hintStyle: theme.textTheme.headlineSmall?.copyWith(
              letterSpacing: 8,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            prefixIcon: const Icon(Icons.security),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
            counterText: '', // 隐藏字符计数器
          ),
          onSubmitted: widget.isLoading ? null : (_) => _performOtpLogin(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: widget.isLoading ? null : _cancelOtpVerification,
            icon: const Icon(Icons.arrow_back),
            label: const Text('返回'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: widget.isLoading ? null : _performOtpLogin,
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
                : const Icon(Icons.verified_user),
            label: Text(widget.isLoading ? '验证中...' : '验证登录'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
