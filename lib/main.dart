import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/index.dart';
import 'features/dashboard/pages/main_page.dart';
import 'features/authentication/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: QuickConnectApp(),
    ),
  );
}

class QuickConnectApp extends ConsumerWidget {
  const QuickConnectApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(currentThemeModeProvider);
    
    return MaterialApp(
      title: '群晖 QuickConnect 登录',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const LoginCheckPage(),
    );
  }
}

/// 登录状态检查页面
class LoginCheckPage extends StatefulWidget {
  const LoginCheckPage({super.key});

  @override
  State<LoginCheckPage> createState() => _LoginCheckPageState();
}

class _LoginCheckPageState extends State<LoginCheckPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final credentialsService = CredentialsService();
      
      // 先检查是否有保存的凭据
      final credentials = await credentialsService.getCredentials();
      AppLogger.debug('🔍 检查保存的凭据: $credentials');
      
      if (credentials == null) {
        AppLogger.info('📝 没有找到保存的凭据，跳转到登录页面');
        _navigateToLogin();
        return;
      }

      // 检查会话状态
      final sessionStatus = await credentialsService.checkSessionStatus();
      AppLogger.debug('🔍 会话状态: $sessionStatus');
      
      // 检查是否有有效的会话
      final hasSession = await credentialsService.hasValidSession();
      AppLogger.debug('🔍 有效会话: $hasSession');
      
      if (hasSession) {
        AppLogger.debug('✅ 找到有效会话，准备自动登录');
        if (credentials.sid != null && 
            credentials.username.isNotEmpty &&
            credentials.quickConnectId.isNotEmpty) {
          // 构建工作地址
          final workingAddress = credentials.workingAddress ?? 
              'https://${credentials.quickConnectId}.quickconnect.to';
          
          // 会话有效，直接跳转到主页面
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MainPage(
                  sid: credentials.sid!,
                  username: credentials.username,
                  quickConnectId: credentials.quickConnectId,
                  workingAddress: workingAddress,
                ),
              ),
            );
            return;
          }
        }
      } else {
        AppLogger.warning('⚠️ 会话无效或已过期，跳转到登录页面');
        _navigateToLogin();
      }
    } catch (e, stackTrace) {
      AppLogger.error('🚨 检查登录状态失败', error: e, stackTrace: stackTrace);
      _navigateToLogin();
    }
  }

  /// 跳转到登录页面
  void _navigateToLogin() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  /// 调试：显示所有存储的键
  Future<void> _debugShowAllStoredKeys(CredentialsService service) async {
    try {
      // 尝试读取所有可能的键
      const keys = [
        'quickconnect_id',
        'username', 
        'password',
        'working_address',
        'session_id',
        'login_time',
        'remember_credentials',
      ];
      
      AppLogger.debug('🔑 检查所有存储的键:');
      for (final key in keys) {
        try {
          final value = await const FlutterSecureStorage().read(key: key);
          AppLogger.debug('  $key: ${value ?? "null"}');
        } catch (e) {
          AppLogger.debug('  $key: 读取失败 - $e');
        }
      }
    } catch (e) {
      AppLogger.error('调试键检查失败', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 应用图标
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (isDark ? Colors.black : Colors.grey).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.cloud_done,
                  color: theme.iconTheme.color,
                  size: 64,
                ),
              ),
              const SizedBox(height: 32),
              
              // 应用标题
              Text(
                '群晖 QuickConnect',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              Text(
                '正在检查登录状态...',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              
              // 加载指示器
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
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