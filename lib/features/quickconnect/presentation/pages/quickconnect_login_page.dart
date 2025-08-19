import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/quickconnect_providers.dart';
import '../widgets/smart_login_form_widget.dart';
import '../widgets/otp_verification_widget.dart';
import '../../../../shared/widgets/log_display_widget.dart';
import '../../../../core/utils/logger.dart';

/// QuickConnect 登录页面 - 基于新的 Clean Architecture
/// 
/// 使用新的用例和状态管理来处理智能登录流程
class QuickConnectLoginPage extends ConsumerStatefulWidget {
  const QuickConnectLoginPage({super.key});

  @override
  ConsumerState<QuickConnectLoginPage> createState() => _QuickConnectLoginPageState();
}

class _QuickConnectLoginPageState extends ConsumerState<QuickConnectLoginPage> {
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
  bool _rememberCredentials = true;

  @override
  void initState() {
    super.initState();
    _initializeLoginPage();
  }

  /// 初始化登录页面
  void _initializeLoginPage() {
    _appendLog('🔥 欢迎使用群晖智能登录 (Clean Architecture 版)');
    _appendLog('💡 使用新的架构和状态管理');
    _appendLog('🏗️ 支持更好的错误处理和缓存策略');
  }

  /// 添加日志
  void _appendLog(String message) {
    setState(() {
      _log += '[${DateTime.now().toString().substring(11, 19)}] $message\n';
    });
    AppLogger.info('LoginPage: $message');
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
    
    // 使用 GoRouter 跳转到主页面
    context.go('/dashboard?sid=$sid&username=$_username&quickConnectId=$_quickConnectId&workingAddress=$workingAddress');
  }

  /// 需要OTP验证回调
  void _onOtpRequired(String? workingAddress, String username, String password, String quickConnectId, bool rememberCredentials) {
    setState(() {
      _showOtpVerification = true;
      _otpWorkingAddress = workingAddress;
      _username = username;
      _password = password;
      _quickConnectId = quickConnectId;
      _rememberCredentials = rememberCredentials;
    });
    _appendLog('⚠️ 需要二次验证 (OTP)');
    _appendLog('📱 请在手机上查看验证码并输入');
  }

  /// 取消OTP验证
  void _onCancelOtp() {
    setState(() {
      _showOtpVerification = false;
      _otpWorkingAddress = null;
    });
    _appendLog('❌ 已取消 OTP 验证');
  }

  @override
  Widget build(BuildContext context) {
    // 使用 Consumer 来监听状态变化，避免在 build 中直接调用 setState
    return Consumer(
      builder: (context, ref, child) {
        // 监听登录状态变化
        ref.listen<AsyncValue>(loginNotifierProvider, (previous, next) {
          next.when(
            data: (data) {
              if (data != null) {
                _appendLog('✅ 登录状态更新成功');
              }
            },
            loading: () {
              _setLoading(true);
              _appendLog('🔄 正在处理登录请求...');
            },
            error: (error, stack) {
              _setLoading(false);
              _appendLog('❌ 登录失败: $error');
            },
          );
        });

        // 监听地址解析状态
        ref.listen<AsyncValue>(addressResolutionNotifierProvider, (previous, next) {
          next.when(
            data: (data) {
              if (data != null) {
                _appendLog('🎯 地址解析成功: ${data.externalDomain}');
              }
            },
            loading: () {
              _appendLog('🔍 正在解析 QuickConnect 地址...');
            },
            error: (error, stack) {
              _appendLog('❌ 地址解析失败: $error');
            },
          );
        });

        // 监听连接测试状态
        ref.listen<AsyncValue>(connectionTestNotifierProvider, (previous, next) {
          next.when(
            data: (data) {
              if (data != null) {
                _appendLog('🔗 连接测试${data.isConnected ? '成功' : '失败'}');
                if (data.isConnected) {
                  _appendLog('⚡ 响应时间: ${data.responseTime}ms');
                }
              }
            },
            loading: () {
              _appendLog('🧪 正在测试连接...');
            },
            error: (error, stack) {
              _appendLog('❌ 连接测试失败: $error');
            },
          );
        });

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
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showArchitectureInfo(),
            tooltip: '架构信息',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 架构信息卡片
              _buildArchitectureCard(),
              const SizedBox(height: 16),

              // 智能登录表单组件 (新版本)
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

              // OTP验证组件 (新版本)
              if (_showOtpVerification && _otpWorkingAddress != null) ...[
                OtpVerificationWidget(
                  workingAddress: _otpWorkingAddress!,
                  username: _username,
                  password: _password,
                  quickConnectId: _quickConnectId,
                  rememberCredentials: _rememberCredentials,
                  onLoginSuccess: (sid) => _onLoginSuccess(sid, _otpWorkingAddress!),
                  onLog: _appendLog,
                  onCancel: _onCancelOtp,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),
              ],

              // 状态信息面板
              _buildStatusPanel(),
              const SizedBox(height: 16),

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
      },
    );
  }

  /// 构建架构信息卡片
  Widget _buildArchitectureCard() {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.architecture,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Clean Architecture',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '基于新的Clean Architecture架构，提供更好的可维护性、可测试性和性能',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建状态信息面板
  Widget _buildStatusPanel() {
    final theme = Theme.of(context);
    final loginState = ref.watch(loginNotifierProvider);
    final addressState = ref.watch(addressResolutionNotifierProvider);
    final connectionState = ref.watch(connectionTestNotifierProvider);
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '系统状态',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildStatusRow('登录状态', loginState),
            _buildStatusRow('地址解析', addressState),
            _buildStatusRow('连接测试', connectionState),
          ],
        ),
      ),
    );
  }

  /// 构建状态行
  Widget _buildStatusRow(String label, AsyncValue state) {
    final theme = Theme.of(context);
    
    Widget statusWidget;
    Color statusColor;
    
    if (state.isLoading) {
      statusWidget = const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
      statusColor = theme.colorScheme.primary;
    } else if (state.hasError) {
      statusWidget = const Icon(Icons.error, size: 16);
      statusColor = theme.colorScheme.error;
    } else if (state.hasValue) {
      statusWidget = const Icon(Icons.check_circle, size: 16);
      statusColor = Colors.green;
    } else {
      statusWidget = const Icon(Icons.radio_button_unchecked, size: 16);
      statusColor = theme.colorScheme.onSurface.withOpacity(0.5);
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: theme.textTheme.bodySmall)),
          const SizedBox(width: 8),
          statusWidget,
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _getStatusText(state),
              style: theme.textTheme.bodySmall?.copyWith(color: statusColor),
            ),
          ),
        ],
      ),
    );
  }

  /// 获取状态文本
  String _getStatusText(AsyncValue state) {
    if (state.isLoading) return '处理中...';
    if (state.hasError) return '失败';
    if (state.hasValue) return '成功';
    return '待处理';
  }

  /// 显示架构信息对话框
  void _showArchitectureInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clean Architecture 信息'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🏗️ 架构层次:'),
              Text('• Domain Layer: 业务逻辑和用例'),
              Text('• Data Layer: 数据源和仓库实现'),
              Text('• Presentation Layer: UI 和状态管理'),
              SizedBox(height: 16),
              Text('✨ 新功能:'),
              Text('• 统一的错误处理'),
              Text('• 智能缓存策略'),
              Text('• 响应式状态管理'),
              Text('• 更好的可测试性'),
              SizedBox(height: 16),
              Text('🔧 技术栈:'),
              Text('• Riverpod: 状态管理'),
              Text('• Dartz: 函数式编程'),
              Text('• Freezed: 不可变数据类'),
              Text('• Dio: 网络请求'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
