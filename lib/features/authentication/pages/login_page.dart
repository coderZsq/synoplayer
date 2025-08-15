import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/pages/main_page.dart';
import '../../../shared/widgets/log_display_widget.dart';
import '../widgets/smart_login_form_widget.dart';
import '../widgets/otp_verification_widget.dart';

/// 智能登录页面
/// 
/// 简化的登录流程，主要使用智能登录功能
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // 状态管理
  String _log = '';
  bool _isLoading = false;
  
  // 登录相关
  String _username = '';
  String _password = '';
  String _quickConnectId = '';
  
  // OTP相关
  bool _showOtpVerification = false;
  String? _otpWorkingAddress;

  @override
  void initState() {
    super.initState();
    _initializeLoginPage();
  }

  /// 初始化登录页面
  void _initializeLoginPage() {
    _appendLog('🔥 欢迎使用群晖智能登录');
    _appendLog('💡 只需输入凭据，系统将自动处理连接');
  }

  /// 添加日志
  void _appendLog(String message) {
    setState(() {
      _log += '[${DateTime.now().toString().substring(11, 19)}] $message\n';
    });
  }

  /// 清空日志
  void _clearLog() {
    setState(() {
      _log = '';
    });
  }

  /// 设置加载状态
  void _setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  /// 登录成功回调
  void _onLoginSuccess(String sid, String workingAddress, [String? username, String? quickConnectId]) {
    _appendLog('✅ 登录成功，正在跳转...');
    
    // 保存用户信息
    if (username != null) _username = username;
    if (quickConnectId != null) _quickConnectId = quickConnectId;
    
    // 跳转到主页面
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MainPage(
          sid: sid,
          username: _username,
          quickConnectId: _quickConnectId,
          workingAddress: workingAddress,
        ),
      ),
    );
  }

  /// 需要OTP验证回调
  void _onOtpRequired(String? workingAddress, String username, String password) {
    setState(() {
      _showOtpVerification = true;
      _otpWorkingAddress = workingAddress;
      _username = username;
      _password = password;
    });
  }



  /// 取消OTP验证
  void _onCancelOtp() {
    setState(() {
      _showOtpVerification = false;
      _otpWorkingAddress = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('群晖智能登录'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _clearLog,
            tooltip: '清空日志',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 智能登录表单组件
              SmartLoginFormWidget(
                onLoginSuccess: (sid, workingAddress, username, quickConnectId) {
                  _onLoginSuccess(sid, workingAddress, username, quickConnectId);
                },
                onLog: _appendLog,
                onOtpRequired: _onOtpRequired,
                isLoading: _isLoading,
                onLoadingChanged: _setLoading,
              ),
              const SizedBox(height: 16),

              // OTP验证组件
              if (_showOtpVerification && _otpWorkingAddress != null) ...[
                OtpVerificationWidget(
                  workingAddress: _otpWorkingAddress!,
                  username: _username,
                  password: _password,
                  onLoginSuccess: (sid) => _onLoginSuccess(sid, _otpWorkingAddress!),
                  onLog: _appendLog,
                  onCancel: _onCancelOtp,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),
              ],

              // 日志显示组件
              LogDisplayWidget(
                log: _log,
                isLoading: _isLoading,
                height: 200,
                onClear: _clearLog,
                title: '登录日志',
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
