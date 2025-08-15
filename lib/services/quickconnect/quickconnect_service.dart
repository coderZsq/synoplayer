import 'models/login_result.dart';
import './models/quickconnect_models.dart';
import '../../core/utils/logger.dart';
import 'address_resolver.dart';
import 'auth_service.dart';
import 'connection_service.dart';
import 'smart_login_service.dart';


/// QuickConnect 主服务
/// 
/// 提供统一的接口来访问所有 QuickConnect 相关功能：
/// - 地址解析
/// - 认证登录
/// - 连接测试
/// - 智能登录
class QuickConnectService {
  QuickConnectService({
    required this.addressResolver,
    required this.authService,
    required this.connectionService,
    required this.smartLoginService,
  });

  final QuickConnectAddressResolver addressResolver;
  final QuickConnectAuthService authService;
  final QuickConnectConnectionService connectionService;
  final QuickConnectSmartLoginService smartLoginService;
  
  static const String _tag = 'QuickConnectService';

  // ==================== 地址解析 ====================
  
  /// 解析 QuickConnect ID 获取可用地址
  Future<String?> resolveAddress(String quickConnectId) async {
    return addressResolver.resolveAddress(quickConnectId);
  }

  /// 获取所有可用地址的详细信息
  Future<List<AddressInfo>> getAllAddressesWithDetails(String quickConnectId) async {
    return addressResolver.getAllAddressesWithDetails(quickConnectId);
  }

  // ==================== 认证登录 ====================
  
  /// 登录群晖 Auth API 获取 SID
  Future<LoginResult> login({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return authService.login(
      baseUrl: baseUrl,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  /// 使用指定地址进行 OTP 登录
  Future<LoginResult> loginWithOTPAtAddress({
    required String baseUrl,
    required String username,
    required String password,
    required String otpCode,
  }) async {
    return authService.loginWithOTPAtAddress(
      baseUrl: baseUrl,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  // ==================== 连接测试 ====================
  
  /// 测试连接是否可用
  Future<ConnectionTestResult> testConnection(String baseUrl) async {
    return connectionService.testConnection(baseUrl);
  }

  /// 批量测试连接
  Future<List<ConnectionTestResult>> testMultipleConnections(List<String> urls) async {
    return connectionService.testMultipleConnections(urls);
  }

  /// 测试连接并返回最佳地址
  Future<String?> findBestConnection(List<String> urls) async {
    return connectionService.findBestConnection(urls);
  }

  /// 获取所有可用的连接地址
  Future<List<String>> getAllAvailableAddresses(String quickConnectId) async {
    return connectionService.getAllAvailableAddresses(quickConnectId);
  }

  /// 获取所有可用的连接地址详细信息
  Future<List<AddressInfo>> getAllAvailableAddressesWithDetails(String quickConnectId) async {
    return connectionService.getAllAvailableAddressesWithDetails(quickConnectId);
  }

  // ==================== 智能登录 ====================
  
  /// 智能登录 - 自动尝试所有可用地址
  Future<LoginResult> smartLogin({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return smartLoginService.smartLogin(
      quickConnectId: quickConnectId,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  /// 智能登录并返回详细结果
  Future<SmartLoginResult> smartLoginWithDetails({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return smartLoginService.smartLoginWithDetails(
      quickConnectId: quickConnectId,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  // ==================== 完整连接流程 ====================
  
  /// 完整的连接流程，包含地址解析、连接测试和登录
  Future<FullConnectionResult> performFullConnection({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      AppLogger.info('开始完整连接流程: $quickConnectId', tag: _tag);
      
      // 1. 获取所有地址详细信息
      final addresses = await getAllAddressesWithDetails(quickConnectId);
      if (addresses.isEmpty) {
        return FullConnectionResult.failure(
          error: '未找到可用的连接地址',
          quickConnectId: quickConnectId,
        );
      }
      
      // 2. 测试所有连接
      final connectionResults = await testMultipleConnections(
        addresses.map((addr) => addr.url).toList()
      );
      
      // 3. 生成连接统计
      final connectionStats = connectionService.getConnectionStats(connectionResults);
      
      // 4. 尝试智能登录
      final loginResult = await smartLogin(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      return FullConnectionResult.success(
        addresses: addresses,
        connectionResults: connectionResults,
        connectionStats: connectionStats,
        loginResult: loginResult,
        quickConnectId: quickConnectId,
      );
      
    } catch (e) {
      AppLogger.error('完整连接流程异常: $e', tag: _tag);
      return FullConnectionResult.failure(
        error: '完整连接流程异常: $e',
        quickConnectId: quickConnectId,
      );
    }
  }

  /// 获取服务状态信息
  Map<String, dynamic> getServiceInfo() {
    return {
      'serviceName': 'QuickConnect Service',
      'version': '2.0.0',
      'features': [
        'Address Resolution',
        'Connection Testing', 
        'Smart Login',
        'Authentication',
        'Network Layer Integration',
      ],
      'networkLayer': 'Dio-based',
      'dependencyInjection': 'Riverpod',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}