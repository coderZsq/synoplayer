import '../models/quickconnect_models.dart';
import '../models/login_result.dart';

/// QuickConnect API 抽象接口
/// 
/// 将所有 HTTP 请求接口抽象化，便于单元测试和依赖注入
abstract class QuickConnectApiInterface {
  
  // ==================== 地址解析 API ====================
  
  /// 发送隧道请求获取中继服务器信息
  /// 
  /// [quickConnectId] QuickConnect ID
  /// 
  /// Returns: 隧道响应数据
  Future<TunnelResponse?> requestTunnel(String quickConnectId);
  
  /// 发送服务器信息请求
  /// 
  /// [quickConnectId] QuickConnect ID
  /// 
  /// Returns: 服务器信息响应数据
  Future<ServerInfoResponse?> requestServerInfo(String quickConnectId);
  
  /// 发送 QuickConnect 全球服务器信息请求（基于抓包分析）
  /// 
  /// [quickConnectId] QuickConnect ID
  /// [getCaFingerprints] 是否获取 CA 指纹
  /// 
  /// Returns: QuickConnect 服务器信息响应数据
  Future<QuickConnectServerInfoResponse?> requestQuickConnectServerInfo({
    required String quickConnectId,
    bool getCaFingerprints = true,
  });
  
  // ==================== 认证登录 API ====================
  
  /// 发送登录请求到群晖 Auth API
  /// 
  /// [baseUrl] 基础URL
  /// [username] 用户名
  /// [password] 密码
  /// [otpCode] 可选的OTP验证码
  /// 
  /// Returns: 登录结果
  Future<LoginResult> requestLogin({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  });
  
  // ==================== 连接测试 API ====================
  
  /// 测试连接可用性
  /// 
  /// [baseUrl] 要测试的基础URL
  /// 
  /// Returns: 连接测试结果
  Future<ConnectionTestResult> testConnection(String baseUrl);
  
  // ==================== 批量操作 API ====================
  
  /// 批量测试多个连接
  /// 
  /// [urls] 要测试的URL列表
  /// 
  /// Returns: 连接测试结果列表
  Future<List<ConnectionTestResult>> testMultipleConnections(List<String> urls);
}
