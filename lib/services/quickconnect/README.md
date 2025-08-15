# QuickConnect 服务

这个模块提供了完整的群晖 QuickConnect 功能，包括地址解析、连接测试、认证登录等。

## 服务组件

### 1. QuickConnectAuthService
处理群晖设备的认证登录。

```dart
final authService = ref.read(quickConnectAuthServiceProvider);

final result = await authService.login(
  baseUrl: 'https://your-synology.synology.me:5001',
  username: 'admin',
  password: 'password',
  otpCode: '123456', // 可选的 OTP 验证码
);

result.when(
  success: (sid) => print('登录成功，SID: $sid'),
  failure: (message) => print('登录失败: $message'),
  requireOTP: (message) => print('需要 OTP: $message'),
);
```

### 2. QuickConnectConnectionService
处理连接测试和地址管理。

```dart
final connectionService = ref.read(quickConnectConnectionServiceProvider);

// 测试单个连接
final result = await connectionService.testConnection(baseUrl);
if (result.isConnected) {
  print('连接成功，响应时间: ${result.responseTime.inMilliseconds}ms');
}

// 获取所有可用地址
final addresses = await connectionService.getAllAvailableAddresses('your-quickconnect-id');
```

### 3. QuickConnectAddressResolver
解析 QuickConnect ID 获取可用的连接地址。

```dart
final resolver = ref.read(quickConnectAddressResolverProvider);

// 解析单个地址
final address = await resolver.resolveAddress('your-quickconnect-id');

// 获取所有地址详情
final addressInfos = await resolver.getAllAddressesWithDetails('your-quickconnect-id');
for (final info in addressInfos) {
  print('地址: ${info.url}, 类型: ${info.type.description}, 优先级: ${info.priority}');
}
```

### 4. QuickConnectSmartLoginService
智能登录服务，自动尝试所有可用地址。

```dart
final smartLoginService = ref.read(quickConnectSmartLoginServiceProvider);

// 简单智能登录
final result = await smartLoginService.smartLogin(
  quickConnectId: 'your-quickconnect-id',
  username: 'admin',
  password: 'password',
);

// 详细智能登录（包含统计信息）
final detailedResult = await smartLoginService.smartLoginWithDetails(
  quickConnectId: 'your-quickconnect-id',
  username: 'admin',
  password: 'password',
);

detailedResult.when(
  success: (loginResult, bestAddress, attempts, stats) {
    print('登录成功！');
    print('最佳地址: $bestAddress');
    print('尝试次数: ${attempts.length}');
    print('统计信息: $stats');
  },
  failure: (error, attempts, stats) {
    print('登录失败: $error');
    print('统计信息: $stats');
  },
);
```

## 完整使用示例

### 1. 在 Widget 中使用
```dart
class QuickConnectLoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<QuickConnectLoginPage> createState() => _QuickConnectLoginPageState();
}

class _QuickConnectLoginPageState extends ConsumerState<QuickConnectLoginPage> {
  final _quickConnectIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  
  bool _showOtpField = false;
  bool _isLoading = false;
  String? _availableAddress;

  Future<void> _performLogin() async {
    setState(() => _isLoading = true);
    
    try {
      final smartLoginService = ref.read(quickConnectSmartLoginServiceProvider);
      
      final result = await smartLoginService.smartLogin(
        quickConnectId: _quickConnectIdController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        otpCode: _showOtpField ? _otpController.text : null,
      );
      
      result.when(
        success: (sid) {
          // 保存登录信息
          CredentialsService.saveCredentials(
            quickConnectId: _quickConnectIdController.text,
            username: _usernameController.text,
            password: _passwordController.text,
            sid: sid,
          );
          
          // 导航到主页面
          Navigator.pushReplacementNamed(context, '/home');
        },
        failure: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('登录失败: $message')),
          );
        },
        requireOTP: (message) {
          setState(() {
            _showOtpField = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
        requireOTPWithAddress: (message, address) {
          setState(() {
            _showOtpField = true;
            _availableAddress = address;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QuickConnect 登录')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _quickConnectIdController,
              decoration: const InputDecoration(
                labelText: 'QuickConnect ID',
                hintText: 'your-synology-id',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: '用户名'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '密码'),
              obscureText: true,
            ),
            if (_showOtpField) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _otpController,
                decoration: const InputDecoration(
                  labelText: 'OTP 验证码',
                  hintText: '6位数字验证码',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _performLogin,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('登录'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. 在 Repository 中使用
```dart
class SynologyRepository {
  SynologyRepository(this._smartLoginService, this._credentialsService);
  
  final QuickConnectSmartLoginService _smartLoginService;
  final CredentialsService _credentialsService;

  Future<Either<Failure, String>> autoLogin() async {
    try {
      final credentials = await _credentialsService.getCredentials();
      
      if (!await _credentialsService.hasSavedCredentials()) {
        return const Left(AuthFailure('没有保存的登录凭据'));
      }
      
      final result = await _smartLoginService.smartLogin(
        quickConnectId: credentials['quickConnectId']!,
        username: credentials['username']!,
        password: credentials['password']!,
      );
      
      return result.when(
        success: (sid) => Right(sid),
        failure: (message) => Left(AuthFailure(message)),
        requireOTP: (message) => Left(AuthFailure('需要二次验证')),
        requireOTPWithAddress: (message, address) => Left(AuthFailure('需要二次验证')),
      );
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
```

## 地址类型说明

QuickConnect 支持多种连接地址类型，按优先级排序：

1. **SmartDNS 直连** (优先级 1) - 最快的直连方式
2. **中继服务器** (优先级 2) - 群晖官方中继
3. **HTTPS 中继** (优先级 3) - HTTPS 协议中继
4. **外部 IP** (优先级 4) - 公网 IP 直连
5. **LAN 地址** (优先级 5) - 局域网内直连
6. **站点地址** (优先级 6+) - 其他可用站点

## 错误处理

所有服务都使用统一的错误处理机制：

```dart
// LoginResult 的错误类型
result.when(
  success: (sid) => handleSuccess(sid),
  failure: (message) => handleError(message),
  requireOTP: (message) => handleOTPRequired(message),
  requireOTPWithAddress: (message, address) => handleOTPWithAddress(message, address),
);

// ApiResponse 的错误类型
response.when(
  success: (data, statusCode, message, extra) => handleSuccess(data),
  error: (message, statusCode, errorCode, error, extra) => handleError(message),
);
```

## 最佳实践

1. **使用智能登录服务**进行自动地址选择和登录
2. **保存登录凭据**以支持自动登录
3. **处理 OTP 验证**，提供良好的用户体验
4. **记录日志**以便调试网络连接问题
5. **使用 Riverpod Providers**进行依赖注入
6. **缓存连接结果**以提高后续连接速度
