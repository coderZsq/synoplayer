/// QuickConnect 服务相关常量
class QuickConnectConstants {
  // 私有构造函数，防止实例化
  QuickConnectConstants._();

  // API 端点
  static const String tunnelServiceUrl = 'https://global.quickconnect.to/Serv.php';
  static const String serverInfoUrl = 'https://cnc.quickconnect.cn/Serv.php';
  
  // 请求头
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'User-Agent': 'DSfile/12 CFNetwork/3826.600.41 Darwin/24.6.0',
    'Accept': '*/*',
    'Accept-Language': 'en-US,en;q=0.9',
    'Accept-Encoding': 'gzip, deflate, br',
  };
  
  // 超时时间
  static const Duration tunnelTimeout = Duration(seconds: 30);
  static const Duration serverInfoTimeout = Duration(seconds: 30);
  static const Duration connectionTestTimeout = Duration(seconds: 10);
  static const Duration loginTimeout = Duration(seconds: 30);
  
  // 默认端口
  static const int defaultServicePort = 5001;
  
  // 命令类型
  static const String commandRequestTunnel = 'request_tunnel';
  static const String commandGetTunnel = 'get_tunnel';
  static const String commandGetServerInfo = 'get_server_info';
  
  // 服务ID
  static const String serverIdSynologyWebAuth = 'synology_web_auth';
  static const String serverIdDsmHttps = 'dsm_https';
  
  // API 版本
  static const int apiVersion1 = 1;
  static const int apiVersion3 = 3;
  
  // 会话类型
  static const String sessionFileStation = 'FileStation';
  
  // 响应格式
  static const String formatSid = 'sid';
}
