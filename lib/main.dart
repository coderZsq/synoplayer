import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/quickconnect/index.dart';
import 'credentials_service.dart';
import 'main_page.dart';
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

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final idCtrl = TextEditingController();
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final otpCtrl = TextEditingController();

  String log = '';
  bool isLoading = false;
  bool isConnected = false;
  String? resolvedUrl;
  bool showOtpField = false;
  List<String> allAddresses = [];
  bool showAllAddresses = false;
  String? workingAddress; // 新增：存储已经验证可用的地址
  bool rememberCredentials = true; // 新增：记住密码选项
  bool hasAutoLogin = false; // 新增：是否已自动登录

  @override
  void initState() {
    super.initState();
    // 自动登录
    _autoLogin();
  }
  
  /// 自动登录
  Future<void> _autoLogin() async {
    try {
      final credentials = await CredentialsService.autoLogin();
      if (credentials.isNotEmpty) {
        setState(() {
          idCtrl.text = credentials['quickConnectId'] ?? '';
          userCtrl.text = credentials['username'] ?? '';
          passCtrl.text = credentials['password'] ?? '';
          workingAddress = credentials['workingAddress'];
          hasAutoLogin = true;
        });
        
        appendLog('🔄 检测到保存的登录凭据');
        appendLog('💡 可以直接点击"智能登录"进行登录');
        
        // 如果有保存的地址，自动解析
        if (credentials['quickConnectId'] != null) {
          await resolveAddress();
        }
      }
    } catch (e) {
      appendLog('❌ 自动登录失败: $e');
    }
  }

  void appendLog(String text) {
    setState(() {
      log += '[${DateTime.now().toString().substring(11, 19)}] $text\n';
    });
  }

  void clearLog() {
    setState(() {
      log = '';
    });
  }

  Future<void> testConnection() async {
    if (resolvedUrl == null) {
      appendLog('❌ 请先解析 QuickConnect 地址');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final result = await quickConnectService.testConnection(resolvedUrl!);
      final isConnected = result.isConnected;
      setState(() {
        this.isConnected = isConnected;
      });
      
      if (isConnected) {
        appendLog('✅ 连接测试成功，可以继续登录');
      } else {
        appendLog('❌ 连接测试失败，请检查网络或 QuickConnect ID');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> resolveAddress() async {
    if (idCtrl.text.trim().isEmpty) {
      appendLog('❌ 请输入 QuickConnect ID');
      return;
    }

    setState(() {
      isLoading = true;
      resolvedUrl = null;
      isConnected = false;
      allAddresses = [];
      showAllAddresses = false;
    });

    try {
      appendLog('🔍 开始解析 QuickConnect 地址...');
      
      // 获取所有可用地址
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final addresses = await quickConnectService.getAllAvailableAddresses(idCtrl.text.trim());
      
      if (addresses.isNotEmpty) {
        setState(() {
          allAddresses = addresses;
          resolvedUrl = addresses.first; // 使用第一个地址作为默认
          showAllAddresses = true;
        });
        
        appendLog('✅ 地址解析成功，找到 ${addresses.length} 个可用地址');
        appendLog('📋 默认使用地址: ${addresses.first}');
        
        // 自动测试第一个地址的连接
        await testConnection();
      } else {
        appendLog('❌ 地址解析失败');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> login() async {
    if (resolvedUrl == null) {
      appendLog('❌ 请先解析 QuickConnect 地址');
      return;
    }

    if (userCtrl.text.trim().isEmpty || passCtrl.text.trim().isEmpty) {
      appendLog('❌ 请输入用户名和密码');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      appendLog('🔐 开始登录流程...');
      
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final result = await quickConnectService.login(
        baseUrl: resolvedUrl!,
        username: userCtrl.text.trim(),
        password: passCtrl.text.trim(),
        otpCode: otpCtrl.text.trim().isEmpty ? null : otpCtrl.text.trim(),
      );

      if (result.isSuccess) {
        appendLog('🎉 登录成功! SID: ${result.sid}');
        appendLog('✅ 现在可以使用 SID 访问群晖服务了');
        
        // 保存登录凭据
        if (rememberCredentials) {
          await CredentialsService.saveCredentials(
            quickConnectId: idCtrl.text.trim(),
            username: userCtrl.text.trim(),
            password: passCtrl.text.trim(),
            workingAddress: workingAddress,
            sid: result.sid, // 新增：保存SID
            rememberCredentials: rememberCredentials,
          );
          appendLog('💾 登录凭据已保存，下次启动将自动填充');
        }
        
        // 登录成功后跳转到主页面
        _navigateToMainPage(result.sid!);
        
        // 隐藏 OTP 字段
        setState(() {
          showOtpField = false;
        });
      } else if (result.requireOTP) {
        appendLog('⚠️ 需要二次验证 (OTP)');
        appendLog('📱 请在手机上查看验证码并输入');
        
        // 显示 OTP 字段
        setState(() {
          showOtpField = true;
        });
      } else {
        appendLog('❌ 登录失败: ${result.errorMessage}');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loginWithOTP() async {
    if (otpCtrl.text.trim().isEmpty) {
      appendLog('❌ 请输入 OTP 验证码');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      appendLog('🔐 使用 OTP 重新登录...');
      
      // 使用已经验证可用的地址，如果没有则使用默认地址
      final targetAddress = workingAddress ?? resolvedUrl;
      if (targetAddress == null) {
        appendLog('❌ 未找到可用的连接地址');
        return;
      }
      
      appendLog('📍 使用已验证的地址: $targetAddress');
      
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final result = await quickConnectService.loginWithOTPAtAddress(
        baseUrl: targetAddress,
        username: userCtrl.text.trim(),
        password: passCtrl.text.trim(),
        otpCode: otpCtrl.text.trim(),
      );

      if (result.isSuccess) {
        appendLog('🎉 登录成功! SID: ${result.sid}');
        appendLog('✅ 现在可以使用 SID 访问群晖服务了');
        
        // 保存登录凭据
        if (rememberCredentials) {
          await CredentialsService.saveCredentials(
            quickConnectId: idCtrl.text.trim(),
            username: userCtrl.text.trim(),
            password: passCtrl.text.trim(),
            workingAddress: workingAddress,
            sid: result.sid, // 新增：保存SID
            rememberCredentials: rememberCredentials,
          );
          appendLog('💾 登录凭据已保存，下次启动将自动填充');
        }
        
        // 登录成功后跳转到主页面
        _navigateToMainPage(result.sid!);
        
        // 隐藏 OTP 字段
        setState(() {
          showOtpField = false;
        });
      } else {
        appendLog('❌ 登录失败: ${result.errorMessage}');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> smartLogin() async {
    if (idCtrl.text.trim().isEmpty) {
      appendLog('❌ 请输入 QuickConnect ID');
      return;
    }

    if (userCtrl.text.trim().isEmpty || passCtrl.text.trim().isEmpty) {
      appendLog('❌ 请输入用户名和密码');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      appendLog('🚀 开始智能登录流程...');
      appendLog('系统将自动尝试所有可用地址进行登录');
      
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final result = await quickConnectService.smartLogin(
        quickConnectId: idCtrl.text.trim(),
        username: userCtrl.text.trim(),
        password: passCtrl.text.trim(),
        otpCode: otpCtrl.text.trim().isEmpty ? null : otpCtrl.text.trim(),
      );

      if (result.isSuccess) {
        appendLog('🎉 智能登录成功! SID: ${result.sid}');
        appendLog('✅ 现在可以使用 SID 访问群晖服务了');
        
        // 保存登录凭据
        if (rememberCredentials) {
          await CredentialsService.saveCredentials(
            quickConnectId: idCtrl.text.trim(),
            username: userCtrl.text.trim(),
            password: passCtrl.text.trim(),
            workingAddress: workingAddress,
            sid: result.sid, // 新增：保存SID
            rememberCredentials: rememberCredentials,
          );
          appendLog('💾 登录凭据已保存，下次启动将自动填充');
        }
        
        // 登录成功后跳转到主页面
        _navigateToMainPage(result.sid!);
        
        // 隐藏 OTP 字段
        setState(() {
          showOtpField = false;
        });
      } else if (result.requireOTP) {
        appendLog('⚠️ 需要二次验证 (OTP)');
        appendLog('📱 请在手机上查看验证码并输入');
        
        // 保存可用的地址信息
        if (result.availableAddress != null) {
          setState(() {
            workingAddress = result.availableAddress;
            showOtpField = true;
          });
          appendLog('💡 系统已找到可用地址: ${result.availableAddress}');
          appendLog('🔐 输入 OTP 后将使用此地址进行登录');
        } else {
          setState(() {
            showOtpField = true;
          });
        }
      } else {
        appendLog('❌ 智能登录失败: ${result.errorMessage}');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  
  /// 跳转到主页面
  void _navigateToMainPage(String sid) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MainPage(
          sid: sid,
          username: userCtrl.text.trim(),
          quickConnectId: idCtrl.text.trim(),
          workingAddress: workingAddress ?? resolvedUrl ?? '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('群晖 QuickConnect 登录'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: isLoading ? null : clearLog,
            tooltip: '清空日志',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // QuickConnect ID 输入
            TextField(
              controller: idCtrl,
              decoration: const InputDecoration(
                labelText: 'QuickConnect ID',
                hintText: '例如: yourname 或 yourname.synology.me',
                prefixIcon: Icon(Icons.link),
                border: OutlineInputBorder(),
                helperText: '输入你的群晖 QuickConnect ID，不包含域名部分',
              ),
            ),
            const SizedBox(height: 8),

            // 帮助信息
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.blue.shade900.withOpacity(0.3)
                    : Colors.blue.shade50,
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.blue.shade700
                      : Colors.blue.shade200,
                ),
                borderRadius: BorderRadius.circular(8),
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
                        'QuickConnect ID 说明',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.blue.shade300
                              : Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• 这是你在群晖 DSM 中设置的 QuickConnect ID\n'
                    '• 不包含 ".synology.me" 等域名后缀\n'
                    '• 如果不知道 ID，可以：\n'
                    '  - 在 DSM 控制面板 > 外部访问 > QuickConnect 中查看\n'
                    '  - 或者直接使用 NAS 的 IP 地址',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.blue.shade200
                          : Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // 解析地址按钮
            ElevatedButton.icon(
              onPressed: isLoading ? null : resolveAddress,
              icon: const Icon(Icons.search),
              label: const Text('解析地址'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),

            if (resolvedUrl != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.green.shade900.withOpacity(0.3)
                      : Colors.green.shade50,
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.green.shade700
                        : Colors.green.shade200,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.green.shade300
                              : Colors.green.shade600,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '已解析地址',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.green.shade300
                                : Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      resolvedUrl!,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          isConnected ? Icons.wifi : Icons.wifi_off,
                          color: isConnected 
                              ? (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.green.shade300
                                  : Colors.green)
                              : (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.red.shade300
                                  : Colors.red),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isConnected ? '连接正常' : '连接异常',
                          style: TextStyle(
                            color: isConnected 
                                ? (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.green.shade300
                                    : Colors.green)
                                : (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.red.shade300
                                    : Colors.red),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: isLoading ? null : testConnection,
                          child: const Text('测试连接'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // 显示所有可用地址
                    if (showAllAddresses && allAddresses.length > 1) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.blue.shade900.withOpacity(0.2)
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.list,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.blue.shade300
                                      : Colors.blue.shade600,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '所有可用地址 (${allAddresses.length})',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.blue.shade300
                                        : Colors.blue.shade700,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            ...allAddresses.asMap().entries.map((entry) {
                              final index = entry.key;
                              final address = entry.value;
                              final isCurrent = address == resolvedUrl;
                              final isDark = Theme.of(context).brightness == Brightness.dark;
                              return Container(
                                margin: const EdgeInsets.only(top: 2),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isCurrent 
                                      ? (isDark ? Colors.blue.shade800.withOpacity(0.5) : Colors.blue.shade100)
                                      : (isDark ? Colors.grey[800] : Colors.white),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: isCurrent 
                                        ? (isDark ? Colors.blue.shade400 : Colors.blue.shade300)
                                        : (isDark ? Colors.grey.shade600 : Colors.grey.shade300),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '${index + 1}.',
                                      style: TextStyle(
                                        color: isDark 
                                            ? Colors.blue.shade300
                                            : Colors.blue.shade700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        address,
                                        style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 11,
                                          color: isCurrent 
                                              ? (isDark ? Colors.blue.shade200 : Colors.blue.shade700)
                                              : (isDark ? Colors.grey.shade300 : Colors.grey.shade700),
                                        ),
                                      ),
                                    ),
                                    if (isCurrent)
                                      Icon(
                                        Icons.check_circle,
                                        color: isDark 
                                            ? Colors.blue.shade300
                                            : Colors.blue.shade600,
                                        size: 16,
                                      ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.blue.shade900.withOpacity(0.3)
                            : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '💡 提示: 现在使用 SmartDNS 直连地址，连接更稳定！\n'
                        '• 连接测试失败是正常的（需要认证信息）\n'
                        '• 地址解析成功即可直接尝试登录\n'
                        '• 如果登录失败，可能需要使用中继服务器地址\n'
                        '• 建议使用"智能登录"功能，自动尝试所有地址',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.blue.shade200
                              : Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),

            // 登录表单
            if (resolvedUrl != null) ...[
              TextField(
                controller: userCtrl,
                decoration: const InputDecoration(
                  labelText: '用户名',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: passCtrl,
                decoration: const InputDecoration(
                  labelText: '密码',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              
              // 记住密码选项
              Row(
                children: [
                  Checkbox(
                    value: rememberCredentials,
                    onChanged: (value) {
                      setState(() {
                        rememberCredentials = value ?? true;
                      });
                    },
                  ),
                  const Text('记住密码'),
                  const Spacer(),
                  if (hasAutoLogin)
                    TextButton.icon(
                      onPressed: () async {
                        await CredentialsService.clearCredentials();
                        setState(() {
                          hasAutoLogin = false;
                          idCtrl.clear();
                          userCtrl.clear();
                          passCtrl.clear();
                          workingAddress = null;
                        });
                        appendLog('🗑️ 已清除保存的登录凭据');
                      },
                      icon: const Icon(Icons.delete, size: 16),
                      label: const Text('清除凭据'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // OTP 字段（条件显示）
              if (showOtpField) ...[
                TextField(
                  controller: otpCtrl,
                  decoration: const InputDecoration(
                    labelText: 'OTP 验证码',
                    hintText: '6位数字验证码',
                    prefixIcon: Icon(Icons.security),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),

                ElevatedButton.icon(
                  onPressed: isLoading ? null : loginWithOTP,
                  icon: const Icon(Icons.login),
                  label: const Text('使用 OTP 登录'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: isLoading ? null : login,
                        icon: const Icon(Icons.login),
                        label: const Text('登录'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: isLoading ? null : smartLogin,
                        icon: const Icon(Icons.lightbulb_outline),
                        label: const Text('智能登录'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],

            const SizedBox(height: 16),

            // 日志显示
            Container(
              height: 300, // 固定高度，避免无限扩展
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
                          '操作日志',
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
            
            const SizedBox(height: 20), // 底部留白
          ],
        ),
      ),
    );
  }
}