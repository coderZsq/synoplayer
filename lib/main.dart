import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'credentials_service.dart';
import 'features/dashboard/pages/main_page.dart';
import 'features/authentication/pages/login_page.dart';
import 'theme_service.dart';

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
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      title: '群晖 QuickConnect 登录',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
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
  bool isLoading = true;
  Map<String, String?>? credentials;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      // 检查是否有有效的会话
      final hasSession = await CredentialsService.hasValidSession();
      
      if (hasSession) {
        // 获取保存的凭据
        credentials = await CredentialsService.getCredentials();
        
        if (credentials != null && 
            credentials!['sid'] != null && 
            credentials!['workingAddress'] != null) {
          // 验证会话是否有效
          final isValid = await CredentialsService.validateSession(
            credentials!['workingAddress']!
          );
          
          if (isValid) {
            // 会话有效，直接跳转到主页面
            if (mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    sid: credentials!['sid']!,
                    username: credentials!['username']!,
                    quickConnectId: credentials!['quickConnectId']!,
                    workingAddress: credentials!['workingAddress']!,
                  ),
                ),
              );
              return;
            }
          }
        }
      }
      
      // 没有有效会话，跳转到登录页面
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } catch (e) {
      // 出错时跳转到登录页面
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
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
                      color: (isDark ? Colors.black : Colors.grey).withOpacity(0.3),
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