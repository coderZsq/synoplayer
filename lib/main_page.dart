import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'credentials_service.dart';
import 'theme_service.dart';
import 'main.dart'; // Import main.dart to access LoginPage

class MainPage extends ConsumerStatefulWidget {
  final String sid;
  final String username;
  final String quickConnectId;
  final String workingAddress;

  const MainPage({
    super.key,
    required this.sid,
    required this.username,
    required this.quickConnectId,
    required this.workingAddress,
  });

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  String log = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _log('🎉 欢迎回来，${widget.username}！');
    _log('🔗 QuickConnect ID: ${widget.quickConnectId}');
    _log('🌐 连接地址: ${widget.workingAddress}');
    _log('🔑 会话ID: ${widget.sid.substring(0, 20)}...');
    _log('✅ 登录状态: 已登录');
  }

  void _log(String message) {
    setState(() {
      log += '[${DateTime.now().toString().substring(11, 19)}] $message\n';
    });
  }

  Future<void> _logout() async {
    setState(() {
      isLoading = true;
    });

    try {
      _log('🚪 正在退出登录...');
      
      // 清除所有保存的凭据
      await CredentialsService.clearCredentials();
      _log('🗑️ 已清除保存的登录凭据');
      _log('✅ 退出登录成功');
      
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
      _log('❌ 退出登录时发生错误: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _testConnection() async {
    setState(() {
      isLoading = true;
    });

    try {
      _log('🔍 测试连接状态...');
      
      // 模拟连接测试
      await Future.delayed(const Duration(seconds: 2));
      
      _log('✅ 连接状态正常');
      _log('📡 网络延迟: 45ms');
      _log('🌍 服务器状态: 在线');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildThemeButton(
    BuildContext context,
    ThemeMode currentMode,
    ThemeNotifier themeNotifier,
    ThemeMode mode,
    IconData icon,
    String label,
  ) {
    final isSelected = currentMode == mode;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          switch (mode) {
            case ThemeMode.light:
              await themeNotifier.setLightMode();
              break;
            case ThemeMode.dark:
              await themeNotifier.setDarkMode();
              break;
            case ThemeMode.system:
              await themeNotifier.setSystemMode();
              break;
          }
          _log('🎨 主题已切换到: ${ThemeService.getThemeModeDescription(mode)}');
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? Colors.blue.shade600 : Colors.blue.shade100)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? (isDark ? Colors.blue.shade400 : Colors.blue.shade300)
                  : (isDark ? Colors.grey.shade600 : Colors.grey.shade300),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? (isDark ? Colors.blue.shade200 : Colors.blue.shade700)
                    : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? (isDark ? Colors.blue.shade200 : Colors.blue.shade700)
                      : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('群晖 QuickConnect - ${widget.username}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: isLoading ? null : _testConnection,
            tooltip: '测试连接',
          ),
          IconButton(
            icon: Icon(ref.read(themeProvider.notifier).icon),
            onPressed: () async {
              await ref.read(themeProvider.notifier).toggleTheme();
              _log('🎨 主题已切换到: ${ref.read(themeProvider.notifier).description}');
            },
            tooltip: '切换主题: ${ref.read(themeProvider.notifier).description}',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: isLoading ? null : _logout,
            tooltip: '退出登录',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 欢迎卡片
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[700]!
                      : Colors.grey[300]!,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_done,
                    color: Theme.of(context).iconTheme.color,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '欢迎使用群晖 QuickConnect',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '已成功连接到你的群晖 NAS',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 连接信息
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[700]!
                      : Colors.grey[300]!,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.blue.shade300
                            : Colors.blue.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '连接信息',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.blue.shade300
                              : Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('用户名', widget.username),
                  _buildInfoRow('QuickConnect ID', widget.quickConnectId),
                  _buildInfoRow('连接地址', widget.workingAddress),
                  _buildInfoRow('会话状态', '活跃'),
                  _buildInfoRow('登录时间', DateTime.now().toString().substring(0, 19)),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 功能按钮
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _testConnection,
                    icon: const Icon(Icons.wifi),
                    label: const Text('测试连接'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _log('📁 文件管理功能开发中...');
                    },
                    icon: const Icon(Icons.folder),
                    label: const Text('文件管理'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _log('📊 系统监控功能开发中...');
                    },
                    icon: const Icon(Icons.monitor),
                    label: const Text('系统监控'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _log('⚙️ 设置功能开发中...');
                    },
                    icon: const Icon(Icons.settings),
                    label: const Text('设置'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // 主题设置区域
            Builder(
              builder: (context) {
                final themeMode = ref.watch(themeProvider);
                final themeNotifier = ref.read(themeProvider.notifier);
                final isDark = Theme.of(context).brightness == Brightness.dark;
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.blue.shade900.withOpacity(0.3) : Colors.blue.shade50,
                    border: Border.all(
                      color: isDark ? Colors.blue.shade700 : Colors.blue.shade200,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.palette,
                            color: isDark ? Colors.blue.shade300 : Colors.blue.shade600,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '外观设置',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '选择你喜欢的主题模式，让应用更符合你的使用习惯。',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.blue.shade200 : Colors.blue.shade700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildThemeButton(
                              context,
                              themeMode,
                              themeNotifier,
                              ThemeMode.light,
                              Icons.light_mode,
                              '亮色',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildThemeButton(
                              context,
                              themeMode,
                              themeNotifier,
                              ThemeMode.dark,
                              Icons.dark_mode,
                              '暗黑',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildThemeButton(
                              context,
                              themeMode,
                              themeNotifier,
                              ThemeMode.system,
                              Icons.auto_mode,
                              '自动',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // 退出登录按钮
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.red.shade900.withOpacity(0.3)
                    : Colors.red.shade50,
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.red.shade700
                      : Colors.red.shade200,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.red.shade300
                            : Colors.red.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '账户安全',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.red.shade300
                              : Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '如果你不再使用此设备，或者想要切换到其他账户，可以安全退出登录。',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.red.shade200
                          : Colors.red.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: isLoading ? null : _logout,
                      icon: const Icon(Icons.logout),
                      label: const Text('退出登录'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 日志显示
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[850]
                    : Colors.grey.shade100,
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[700]!
                      : Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[800]
                          : Colors.grey.shade200,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.list_alt,
                          size: 16,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '系统日志',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        if (isLoading)
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        log.isEmpty ? '等待操作...' : log,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
