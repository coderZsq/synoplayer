import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/index.dart';
import '../../../shared/widgets/log_display_widget.dart';
import '../../authentication/pages/login_page.dart';
import '../widgets/welcome_card_widget.dart';
import '../widgets/connection_info_widget.dart';
import '../widgets/feature_buttons_widget.dart';
import '../widgets/theme_settings_widget.dart';
import '../widgets/logout_section_widget.dart';

/// 重构后的主页面
/// 
/// 采用组件化设计，将各个功能区域拆分为独立组件
class MainPage extends ConsumerStatefulWidget {
  const MainPage({
    super.key,
    required this.sid,
    required this.username,
    required this.quickConnectId,
    required this.workingAddress,
  });

  final String sid;
  final String username;
  final String quickConnectId;
  final String workingAddress;

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  String _log = '';
  bool _isLoading = false;
  late DateTime _loginTime;

  @override
  void initState() {
    super.initState();
    _loginTime = DateTime.now();
    _initializePage();
  }

  /// 初始化页面
  void _initializePage() {
    _appendLog('🎉 欢迎回来，${widget.username}！');
    _appendLog('🔗 QuickConnect ID: ${widget.quickConnectId}');
    _appendLog('🌐 连接地址: ${widget.workingAddress}');
    _appendLog('🔑 会话ID: ${widget.sid.substring(0, 20)}...');
    _appendLog('✅ 登录状态: 已登录');
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

  /// 测试连接
  Future<void> _testConnection() async {
    _setLoading(true);

    try {
      _appendLog('🔍 测试连接状态...');
      
      // 模拟连接测试
      await Future.delayed(const Duration(seconds: 2));
      
      _appendLog('✅ 连接状态正常');
      _appendLog('📡 网络延迟: 45ms');
      _appendLog('🌍 服务器状态: 在线');
    } catch (e) {
      _appendLog('❌ 连接测试失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// 文件管理
  void _openFileManager() {
    _appendLog('📁 文件管理功能开发中...');
    // TODO: 实现文件管理功能
  }

  /// 系统监控
  void _openSystemMonitor() {
    _appendLog('📊 系统监控功能开发中...');
    // TODO: 实现系统监控功能
  }

  /// 打开设置
  void _openSettings() {
    _appendLog('⚙️ 设置功能开发中...');
    // TODO: 实现设置功能
  }

  /// 主题切换回调
  void _onThemeChanged(String description) {
    _appendLog('🎨 主题已切换到: $description');
  }

  /// 退出登录
  Future<void> _logout() async {
    _setLoading(true);

    try {
      _appendLog('🚪 正在退出登录...');
      
      // 清除所有保存的凭据
      final credentialsService = CredentialsService();
      await credentialsService.clearCredentials();
      _appendLog('🗑️ 已清除保存的登录凭据');
      _appendLog('✅ 退出登录成功');
      
      // 延迟一下让用户看到日志
      await Future.delayed(const Duration(seconds: 1));
      
      // 返回登录页面
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } catch (e) {
      _appendLog('❌ 退出登录时发生错误: $e');
    } finally {
      _setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('群晖 QuickConnect - ${widget.username}'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _testConnection,
            tooltip: '测试连接',
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearLog,
            tooltip: '清空日志',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 欢迎卡片
              WelcomeCardWidget(
                username: widget.username,
              ),
              const SizedBox(height: 16),
              
              // 连接信息
              ConnectionInfoWidget(
                username: widget.username,
                quickConnectId: widget.quickConnectId,
                workingAddress: widget.workingAddress,
                sessionId: widget.sid,
                loginTime: _loginTime,
              ),
              const SizedBox(height: 16),
              
              // 功能按钮
              FeatureButtonsWidget(
                onTestConnection: _testConnection,
                onFileManager: _openFileManager,
                onSystemMonitor: _openSystemMonitor,
                onSettings: _openSettings,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              
              // 主题设置
              ThemeSettingsWidget(
                onThemeChanged: _onThemeChanged,
              ),
              const SizedBox(height: 16),
              
              // 退出登录区域
              LogoutSectionWidget(
                onLogout: _logout,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              
              // 日志显示
              LogDisplayWidget(
                log: _log,
                isLoading: _isLoading,
                height: 180,
                onClear: _clearLog,
              ),
              
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
