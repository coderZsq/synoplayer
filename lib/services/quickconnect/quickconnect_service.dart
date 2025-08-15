import 'models/login_result.dart';
import './models/quickconnect_models.dart';
import 'utils/logger.dart';
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
  static const String _tag = 'QuickConnectService';

  /// 设置日志回调函数
  static void setLogCallback(Function(String) callback) {
    AppLogger.setLogCallback(callback);
  }

  // ==================== 地址解析 ====================
  
  /// 解析 QuickConnect ID 获取可用地址
  static Future<String?> resolveAddress(String quickConnectId) async {
    return QuickConnectAddressResolver.resolveAddress(quickConnectId);
  }

  /// 获取所有可用地址的详细信息
  static Future<List<AddressInfo>> getAllAddressesWithDetails(String quickConnectId) async {
    return QuickConnectAddressResolver.getAllAddressesWithDetails(quickConnectId);
  }

  // ==================== 认证登录 ====================
  
  /// 登录群晖 Auth API 获取 SID
  static Future<LoginResult> login({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return QuickConnectAuthService.login(
      baseUrl: baseUrl,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  /// 使用指定地址进行 OTP 登录
  static Future<LoginResult> loginWithOTPAtAddress({
    required String baseUrl,
    required String username,
    required String password,
    required String otpCode,
  }) async {
    return QuickConnectAuthService.loginWithOTPAtAddress(
      baseUrl: baseUrl,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  // ==================== 连接测试 ====================
  
  /// 测试连接是否可用
  static Future<ConnectionTestResult> testConnection(String baseUrl) async {
    return QuickConnectConnectionService.testConnection(baseUrl);
  }

  /// 批量测试连接
  static Future<List<ConnectionTestResult>> testMultipleConnections(List<String> urls) async {
    return QuickConnectConnectionService.testMultipleConnections(urls);
  }

  /// 寻找最佳连接
  static Future<String?> findBestConnection(List<String> urls) async {
    return QuickConnectConnectionService.findBestConnection(urls);
  }

  /// 获取所有可用的连接地址
  static Future<List<String>> getAllAvailableAddresses(String quickConnectId) async {
    return QuickConnectConnectionService.getAllAvailableAddresses(quickConnectId);
  }

  /// 获取所有可用的连接地址详细信息
  static Future<List<AddressInfo>> getAllAvailableAddressesWithDetails(String quickConnectId) async {
    return QuickConnectConnectionService.getAllAvailableAddressesWithDetails(quickConnectId);
  }

  // ==================== 智能登录 ====================
  
  /// 智能登录 - 自动尝试所有可用地址
  static Future<LoginResult> smartLogin({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return QuickConnectSmartLoginService.smartLogin(
      quickConnectId: quickConnectId,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  /// 智能登录并返回详细结果
  static Future<SmartLoginResult> smartLoginWithDetails({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return QuickConnectSmartLoginService.smartLoginWithDetails(
      quickConnectId: quickConnectId,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  // ==================== 便捷方法 ====================
  
  /// 快速连接 - 解析地址并测试连接
  static Future<QuickConnectResult> quickConnect(String quickConnectId) async {
    try {
      AppLogger.info('开始快速连接流程: $quickConnectId', tag: _tag);
      
      // 1. 解析地址
      final address = await resolveAddress(quickConnectId);
      if (address == null) {
        return QuickConnectResult.failure(
          error: '无法解析 QuickConnect ID',
          quickConnectId: quickConnectId,
        );
      }
      
      // 2. 测试连接
      final connectionResult = await testConnection(address);
      
      return QuickConnectResult.success(
        address: address,
        connectionResult: connectionResult,
        quickConnectId: quickConnectId,
      );
      
    } catch (e) {
      AppLogger.error('快速连接异常: $e', tag: _tag);
      return QuickConnectResult.failure(
        error: '快速连接异常: $e',
        quickConnectId: quickConnectId,
      );
    }
  }

  /// 完整连接流程 - 包含地址解析、连接测试和登录
  static Future<FullConnectionResult> fullConnection({
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
      final connectionStats = QuickConnectConnectionService.getConnectionStats(connectionResults);
      
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
  static Map<String, dynamic> getServiceInfo() {
    return {
      'service': 'QuickConnect Service',
      'version': '2.0.0',
      'components': [
        'AddressResolver',
        'AuthService', 
        'ConnectionService',
        'SmartLoginService',
      ],
      'features': [
        '地址解析',
        '认证登录',
        '连接测试',
        '智能登录',
        '二次验证支持',
        '数据模型序列化',
        '连接统计',
        '最佳连接选择',
      ],
      'models': [
        'AddressInfo',
        'ConnectionTestResult',
        'TunnelResponse',
        'ServerInfoResponse',
        'SmartLoginResult',
        'LoginAttempt',
      ],
    };
  }
}
