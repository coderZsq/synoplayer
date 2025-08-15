// 导入新的结构化服务
import 'services/quickconnect/quickconnect_service.dart' as new_service;

// 为了保持向后兼容性，重新导出新的结构化服务
// 建议在新代码中直接使用 lib/services/quickconnect/ 下的服务

export 'services/quickconnect/index.dart';

// 保持原有的类名以兼容现有代码
class QuickConnectService {
  // 这个类现在只是一个兼容性包装器
  // 实际功能已经迁移到 lib/services/quickconnect/ 目录下
  
  /// 设置日志回调函数
  static void setLogCallback(Function(String) callback) {
    // 委托给新的日志系统
    new_service.QuickConnectService.setLogCallback(callback);
  }

  /// 解析 QuickConnect ID 获取可用地址
  static Future<String?> resolveAddress(String quickConnectId) async {
    return new_service.QuickConnectService.resolveAddress(quickConnectId);
  }

  /// 登录群晖 Auth API 获取 SID
  static Future<dynamic> login({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return new_service.QuickConnectService.login(
      baseUrl: baseUrl,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  /// 测试连接是否可用 (保持向后兼容，返回 bool)
  static Future<bool> testConnection(String baseUrl) async {
    final result = await new_service.QuickConnectService.testConnection(baseUrl);
    return result.isConnected;
  }

  /// 获取所有可用的连接地址
  static Future<List<String>> getAllAvailableAddresses(String quickConnectId) async {
    return new_service.QuickConnectService.getAllAvailableAddresses(quickConnectId);
  }

  /// 智能登录 - 自动尝试所有可用地址
  static Future<dynamic> smartLogin({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return new_service.QuickConnectService.smartLogin(
      quickConnectId: quickConnectId,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  /// 使用指定地址进行 OTP 登录
  static Future<dynamic> loginWithOTPAtAddress({
    required String baseUrl,
    required String username,
    required String password,
    required String otpCode,
  }) async {
    return new_service.QuickConnectService.loginWithOTPAtAddress(
      baseUrl: baseUrl,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  // ==================== 新增功能（向后兼容） ====================
  
  /// 获取所有可用地址的详细信息
  static Future<List<dynamic>> getAllAddressesWithDetails(String quickConnectId) async {
    return new_service.QuickConnectService.getAllAddressesWithDetails(quickConnectId);
  }

  /// 批量测试连接
  static Future<List<dynamic>> testMultipleConnections(List<String> urls) async {
    return new_service.QuickConnectService.testMultipleConnections(urls);
  }

  /// 寻找最佳连接
  static Future<String?> findBestConnection(List<String> urls) async {
    return new_service.QuickConnectService.findBestConnection(urls);
  }

  /// 智能登录并返回详细结果
  static Future<dynamic> smartLoginWithDetails({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return new_service.QuickConnectService.smartLoginWithDetails(
      quickConnectId: quickConnectId,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  /// 快速连接 - 解析地址并测试连接
  static Future<Map<String, dynamic>> quickConnect(String quickConnectId) async {
    final result = await new_service.QuickConnectService.quickConnect(quickConnectId);
    
    // 转换为原有的 Map 格式以保持向后兼容
    return result.when(
      success: (address, connectionResult, quickConnectId) => {
        'success': true,
        'error': null,
        'address': address,
        'isConnected': connectionResult.isConnected,
        'responseTime': connectionResult.responseTime.inMilliseconds,
        'quickConnectId': quickConnectId,
      },
      failure: (error, quickConnectId) => {
        'success': false,
        'error': error,
        'address': null,
        'isConnected': false,
        'responseTime': null,
        'quickConnectId': quickConnectId,
      },
    );
  }

  /// 完整连接流程
  static Future<Map<String, dynamic>> fullConnection({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    final result = await new_service.QuickConnectService.fullConnection(
      quickConnectId: quickConnectId,
      username: username,
      password: password,
      otpCode: otpCode,
    );
    
    // 转换为原有的 Map 格式以保持向后兼容
    return result.when(
      success: (addresses, connectionResults, connectionStats, loginResult, quickConnectId) => {
        'success': true,
        'error': null,
        'addresses': addresses.map((addr) => addr.url).toList(),
        'connectionStats': connectionStats,
        'loginSuccess': loginResult.isSuccess,
        'requireOTP': loginResult.requireOTP,
        'quickConnectId': quickConnectId,
      },
      failure: (error, quickConnectId) => {
        'success': false,
        'error': error,
        'addresses': null,
        'connectionStats': null,
        'loginSuccess': false,
        'requireOTP': false,
        'quickConnectId': quickConnectId,
      },
    );
  }
}

// 保持原有的 LoginResult 类以兼容现有代码
class LoginResult {
  final bool isSuccess;
  final String? sid;
  final String? errorMessage;
  final bool requireOTP;
  final String? availableAddress;

  LoginResult._({
    required this.isSuccess,
    this.sid,
    this.errorMessage,
    this.requireOTP = false,
    this.availableAddress,
  });

  /// 登录成功
  factory LoginResult.success(String sid) {
    return LoginResult._(isSuccess: true, sid: sid);
  }

  /// 登录失败
  factory LoginResult.failure(String errorMessage) {
    return LoginResult._(isSuccess: false, errorMessage: errorMessage);
  }

  /// 需要二次验证
  factory LoginResult.requireOTP(String message) {
    return LoginResult._(isSuccess: false, errorMessage: message, requireOTP: true);
  }

  /// 需要二次验证，并提供可用地址
  factory LoginResult.requireOTPWithAddress(String message, String address) {
    return LoginResult._(
      isSuccess: false, 
      errorMessage: message, 
      requireOTP: true, 
      availableAddress: address
    );
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'LoginResult.success(sid: $sid)';
    } else if (requireOTP) {
      return 'LoginResult.requireOTP(message: $errorMessage)';
    } else {
      return 'LoginResult.failure(error: $errorMessage)';
    }
  }
}