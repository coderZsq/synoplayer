import 'package:freezed_annotation/freezed_annotation.dart';
import 'login_result.dart';

part 'quickconnect_models.freezed.dart';
part 'quickconnect_models.g.dart';

/// QuickConnect 服务相关的数据模型

/// 基础响应模型
@freezed
abstract class BaseResponse with _$BaseResponse {
  const factory BaseResponse({
    required bool success,
    String? error,
    int? errorCode,
  }) = _BaseResponse;

  /// 检查是否为成功响应
  bool get isSuccess => success;
  
  /// 检查是否为错误响应
  bool get isError => !success;
  
  /// 获取错误信息，如果成功则返回 null
  String? get errorMessage => isError ? (error ?? '未知错误') : null;

  const BaseResponse._();
}

/// 成功响应模型
@freezed
class SuccessResponse with _$SuccessResponse {
  const factory SuccessResponse({
    required Map<String, dynamic> data,
  }) = _SuccessResponse;

  const SuccessResponse._();

  factory SuccessResponse.fromJson(Map<String, dynamic> json) => 
      _$SuccessResponseFromJson(json);
}

/// 错误响应模型
@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    required String error,
    int? errorCode,
  }) = _ErrorResponse;

  const ErrorResponse._();

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    // 处理不同的错误格式
    final errorData = json['error'];
    String errorMessage;
    int? code;
    
    if (errorData is Map<String, dynamic>) {
      errorMessage = errorData['message'] ?? errorData['msg'] ?? '未知错误';
      code = errorData['code'];
    } else if (errorData is String) {
      errorMessage = errorData;
      code = json['code'] ?? json['errno'];
    } else {
      errorMessage = json['message'] ?? json['msg'] ?? '未知错误';
      code = json['code'] ?? json['errno'];
    }
    
    return ErrorResponse(
      error: errorMessage,
      errorCode: code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': false,
      'error': {
        'message': error,
        'code': errorCode,
      },
    };
  }
}

/// 隧道请求响应模型
@freezed
class TunnelResponse with _$TunnelResponse {
  const factory TunnelResponse({
    TunnelData? tunnelData,
    String? errorInfo,
    required bool success,
    String? error,
    int? errorCode,
  }) = _TunnelResponse;

  const TunnelResponse._();

  factory TunnelResponse.fromJson(Map<String, dynamic> json) {
    if (json['errno'] != null) {
      // 错误响应
      return TunnelResponse(
        success: false,
        tunnelData: null,
        error: json['errinfo'] ?? json['error'] ?? '隧道请求失败',
        errorCode: json['errno'],
        errorInfo: json['errinfo'] ?? json['error'],
      );
    } else {
      // 成功响应
      return TunnelResponse(
        success: true,
        tunnelData: json['data'] != null ? TunnelData.fromJson(json['data']) : null,
      );
    }
  }

  Map<String, dynamic> toJson() {
    if (success) {
      return {
        'success': true,
        'data': tunnelData?.toJson(),
      };
    } else {
      return {
        'success': false,
        'errno': errorCode,
        'errinfo': errorInfo,
      };
    }
  }
}

/// 隧道数据模型
@freezed
class TunnelData with _$TunnelData {
  const factory TunnelData({
    RelayInfo? relay,
    ExternalInfo? external,
  }) = _TunnelData;

  const TunnelData._();

  factory TunnelData.fromJson(Map<String, dynamic> json) => 
      _$TunnelDataFromJson(json);
}

/// 中继信息模型
@freezed
class RelayInfo with _$RelayInfo {
  const factory RelayInfo({
    String? fqdn,
    String? ip,
    int? port,
  }) = _RelayInfo;

  const RelayInfo._();

  factory RelayInfo.fromJson(Map<String, dynamic> json) => 
      _$RelayInfoFromJson(json);

  /// 获取有效的地址
  String? get validAddress {
    if (fqdn != null && fqdn != 'NULL') return fqdn;
    if (ip != null && ip != 'NULL') return ip;
    return null;
  }

  /// 检查是否有有效的中继信息
  bool get isValid => validAddress != null && port != null && port != 0;
}

/// 外部信息模型
@freezed
class ExternalInfo with _$ExternalInfo {
  const factory ExternalInfo({
    String? fqdn,
    String? ip,
    int? port,
  }) = _ExternalInfo;

  const ExternalInfo._();

  factory ExternalInfo.fromJson(Map<String, dynamic> json) => 
      _$ExternalInfoFromJson(json);

  /// 获取有效的地址
  String? get validAddress {
    if (fqdn != null && fqdn != 'NULL') return fqdn;
    if (ip != null && ip != 'NULL') return ip;
    return null;
  }

  /// 检查是否有有效的外部信息
  bool get isValid => validAddress != null && port != null && port != 0;
}

/// 服务器信息响应模型
@freezed
class ServerInfoResponse with _$ServerInfoResponse {
  const factory ServerInfoResponse({
    ServerInfo? serverInfo,
    List<String>? sites,
    SmartDnsInfo? smartDns,
    ServiceInfo? service,
    required bool success,
    String? error,
    int? errorCode,
  }) = _ServerInfoResponse;

  const ServerInfoResponse._();

  factory ServerInfoResponse.fromJson(Map<String, dynamic> json) {
    return ServerInfoResponse(
      success: true,
      serverInfo: json['server'] != null ? ServerInfo.fromJson(json['server']) : null,
      sites: json['sites'] != null ? List<String>.from(json['sites']) : null,
      smartDns: json['smartdns'] != null ? SmartDnsInfo.fromJson(json['smartdns']) : null,
      service: json['service'] != null ? ServiceInfo.fromJson(json['service']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': true,
      'server': serverInfo?.toJson(),
      'sites': sites,
      'smartdns': smartDns?.toJson(),
      'service': service?.toJson(),
    };
  }
}

/// QuickConnect 全球服务器信息响应模型（基于抓包分析）
@freezed
class QuickConnectServerInfoResponse with _$QuickConnectServerInfoResponse {
  const factory QuickConnectServerInfoResponse({
    required String command,
    String? errinfo,
    int? errno,
    List<String>? sites,
    int? suberrno,
    int? version,
    bool? getCaFingerprints,
    ServerInfo? server,
    SmartDnsInfo? smartdns,
    ServiceInfo? service,
  }) = _QuickConnectServerInfoResponse;

  const QuickConnectServerInfoResponse._();

  factory QuickConnectServerInfoResponse.fromJson(Map<String, dynamic> json) {
    return QuickConnectServerInfoResponse(
      command: json['command'] ?? '',
      errinfo: json['errinfo'],
      errno: json['errno'],
      sites: json['sites'] != null ? List<String>.from(json['sites']) : null,
      suberrno: json['suberrno'],
      version: json['version'],
      getCaFingerprints: json['get_ca_fingerprints'],
      server: json['server'] != null ? ServerInfo.fromJson(json['server']) : null,
      smartdns: json['smartdns'] != null ? SmartDnsInfo.fromJson(json['smartdns']) : null,
      service: json['service'] != null ? ServiceInfo.fromJson(json['service']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'command': command,
    };
    
    if (errinfo != null) data['errinfo'] = errinfo;
    if (errno != null) data['errno'] = errno;
    if (sites != null) data['sites'] = sites;
    if (suberrno != null) data['suberrno'] = suberrno;
    if (version != null) data['version'] = version;
    if (getCaFingerprints != null) data['get_ca_fingerprints'] = getCaFingerprints;
    if (server != null) data['server'] = server!.toJson();
    if (smartdns != null) data['smartdns'] = smartdns!.toJson();
    if (service != null) data['service'] = service!.toJson();
    
    return data;
  }

  /// 检查是否为成功响应
  bool get isSuccess => errno == null || errno == 0;
  
  /// 检查是否为错误响应
  bool get isError => errno != null && errno != 0;
  
  /// 获取错误信息
  String? get errorMessage => isError ? errinfo : null;
  
  /// 获取错误代码
  int? get errorCode => errno;
  
  /// 获取子错误代码
  int? get subErrorCode => suberrno;
  
  /// 是否有可用站点
  bool get hasSites => sites != null && sites!.isNotEmpty;
  
  /// 是否有服务器信息
  bool get hasServerInfo => server != null;
  
  /// 是否有 SmartDNS 信息
  bool get hasSmartDns => smartdns != null;
  
  /// 是否有服务信息
  bool get hasServiceInfo => service != null;
  
  /// 调试信息
  String get debugInfo {
    return 'QuickConnectServerInfoResponse(\n'
           '  command: $command,\n'
           '  isSuccess: $isSuccess,\n'
           '  errno: $errno,\n'
           '  errinfo: $errinfo,\n'
           '  sites: $sites,\n'
           '  hasServerInfo: $hasServerInfo,\n'
           '  hasSmartDns: $hasSmartDns,\n'
           '  hasServiceInfo: $hasServiceInfo\n'
           ')';
  }
}

/// 服务器信息模型
@freezed
class ServerInfo with _$ServerInfo {
  const factory ServerInfo({
    ExternalServerInfo? external,
    List<InterfaceInfo>? interfaces,
  }) = _ServerInfo;

  const ServerInfo._();

  factory ServerInfo.fromJson(Map<String, dynamic> json) {
    return ServerInfo(
      external: json['external'] != null ? ExternalServerInfo.fromJson(json['external']) : null,
      interfaces: json['interface'] != null 
          ? (json['interface'] as List).map((e) => InterfaceInfo.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'external': external?.toJson(),
      'interface': interfaces?.map((e) => e.toJson()).toList(),
    };
  }
}

/// 外部服务器信息模型
@freezed
class ExternalServerInfo with _$ExternalServerInfo {
  const factory ExternalServerInfo({
    String? ip,
    int? port,
  }) = _ExternalServerInfo;

  const ExternalServerInfo._();

  factory ExternalServerInfo.fromJson(Map<String, dynamic> json) => 
      _$ExternalServerInfoFromJson(json);

  /// 检查是否有有效的外部服务器信息
  bool get isValid => ip != null && ip != 'NULL' && port != null && port != 0;
}

/// 接口信息模型
@freezed
class InterfaceInfo with _$InterfaceInfo {
  const factory InterfaceInfo({
    String? ip,
    String? name,
    String? type,
  }) = _InterfaceInfo;

  const InterfaceInfo._();

  factory InterfaceInfo.fromJson(Map<String, dynamic> json) => 
      _$InterfaceInfoFromJson(json);

  /// 检查是否有有效的接口信息
  bool get isValid => ip != null && ip != 'NULL';
}

/// SmartDNS 信息模型
@freezed
class SmartDnsInfo with _$SmartDnsInfo {
  const factory SmartDnsInfo({
    String? host,
    int? port,
  }) = _SmartDnsInfo;

  const SmartDnsInfo._();

  factory SmartDnsInfo.fromJson(Map<String, dynamic> json) => 
      _$SmartDnsInfoFromJson(json);

  /// 检查是否有有效的 SmartDNS 信息
  bool get isValid => host != null && host != 'NULL' && port != null && port != 0;
  
  /// 更宽松的验证方法（用于调试）
  bool get hasValidHost => host != null && host != 'NULL' && host!.isNotEmpty;
  
  /// 检查是否有端口信息
  bool get hasPort => port != null && port != 0;
  
  /// 调试信息
  String get debugInfo => 'SmartDnsInfo(host: $host, port: $port, isValid: $isValid)';
}

/// 服务信息模型
@freezed
class ServiceInfo with _$ServiceInfo {
  const factory ServiceInfo({
    String? relayDn,
    int? relayPort,
    String? httpsIp,
    int? httpsPort,
    int? port,
  }) = _ServiceInfo;

  const ServiceInfo._();

  factory ServiceInfo.fromJson(Map<String, dynamic> json) {
    return ServiceInfo(
      relayDn: json['relay_dn'],
      relayPort: json['relay_port'],
      httpsIp: json['https_ip'],
      httpsPort: json['https_port'],
      port: json['port'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relay_dn': relayDn,
      'relay_port': relayPort,
      'https_ip': httpsIp,
      'https_port': httpsPort,
      'port': port,
    };
  }

  /// 检查是否有有效的中继服务信息
  bool get hasValidRelay => relayDn != null && relayDn != 'NULL' && relayPort != null && relayPort != 0;

  /// 检查是否有有效的 HTTPS 中继信息
  bool get hasValidHttpsRelay => httpsIp != null && httpsIp != 'NULL' && httpsPort != null && httpsPort != 0;

  /// 检查是否有有效的端口信息
  bool get hasValidPort => port != null && port != 0;
}

/// 地址信息模型
@freezed
class AddressInfo with _$AddressInfo {
  const factory AddressInfo({
    required String url,
    required AddressType type,
    required String description,
    required int priority,
  }) = _AddressInfo;

  const AddressInfo._();

  factory AddressInfo.fromUrl(String url, AddressType type, String description, int priority) {
    return AddressInfo(
      url: url,
      type: type,
        description: description,
      priority: priority,
    );
  }

  factory AddressInfo.fromJson(Map<String, dynamic> json) => 
      _$AddressInfoFromJson(json);
}

/// 地址类型枚举
@JsonEnum()
enum AddressType {
  @JsonValue('smartDns')
  smartDns('SmartDNS 直连'),
  
  @JsonValue('relay')
  relay('中继服务器'),
  
  @JsonValue('httpsRelay')
  httpsRelay('HTTPS 中继'),
  
  @JsonValue('externalIp')
  externalIp('外部IP'),
  
  @JsonValue('lan')
  lan('LAN地址'),
  
  @JsonValue('site')
  site('站点地址');

  const AddressType(this.description);
  final String description;
}

/// 连接测试结果模型
@freezed
class ConnectionTestResult with _$ConnectionTestResult {
  const factory ConnectionTestResult({
    required String url,
    required bool isConnected,
    int? statusCode,
    String? error,
    required Duration responseTime,
  }) = _ConnectionTestResult;

  const ConnectionTestResult._();

  factory ConnectionTestResult.success(String url, int statusCode, Duration responseTime) {
    return ConnectionTestResult(
      url: url,
      isConnected: true,
      statusCode: statusCode,
      responseTime: responseTime,
    );
  }

  factory ConnectionTestResult.failure(String url, String error, Duration responseTime) {
    return ConnectionTestResult(
      url: url,
      isConnected: false,
      error: error,
      responseTime: responseTime,
    );
  }

  factory ConnectionTestResult.fromJson(Map<String, dynamic> json) => 
      _$ConnectionTestResultFromJson(json);

  /// 获取响应时间（毫秒）
  int get responseTimeMs => responseTime.inMilliseconds;

  /// 检查是否为慢连接（超过1秒）
  bool get isSlowConnection => responseTimeMs > 1000;
}

/// 智能登录结果模型
@freezed
class SmartLoginResult with _$SmartLoginResult {
  const factory SmartLoginResult.success({
    required LoginResult loginResult,
    required String bestAddress,
    required List<LoginAttempt> attempts,
    required Map<String, dynamic> stats,
  }) = SmartLoginResultSuccess;

  const factory SmartLoginResult.failure({
    required String error,
    required List<LoginAttempt> attempts,
    required Map<String, dynamic> stats,
  }) = SmartLoginResultFailure;

  const SmartLoginResult._();

  factory SmartLoginResult.fromJson(Map<String, dynamic> json) => 
      _$SmartLoginResultFromJson(json);
}

/// 登录尝试记录模型
@freezed
class LoginAttempt with _$LoginAttempt {
  const factory LoginAttempt({
    required String address,
    required AddressType addressType,
    required int priority,
    required int attemptNumber,
    ConnectionTestResult? connectionResult,
    LoginResult? loginResult,
    String? error,
  }) = _LoginAttempt;

  const LoginAttempt._();

  factory LoginAttempt.fromJson(Map<String, dynamic> json) => 
      _$LoginAttemptFromJson(json);
}

/// 快速连接结果模型
@freezed
class QuickConnectResult with _$QuickConnectResult {
  const factory QuickConnectResult.success({
    required String address,
    required ConnectionTestResult connectionResult,
    required String quickConnectId,
  }) = QuickConnectResultSuccess;

  const factory QuickConnectResult.failure({
    required String error,
    required String quickConnectId,
  }) = QuickConnectResultFailure;

  const QuickConnectResult._();

  factory QuickConnectResult.fromJson(Map<String, dynamic> json) => 
      _$QuickConnectResultFromJson(json);
}

/// 完整连接结果模型
@freezed
class FullConnectionResult with _$FullConnectionResult {
  const factory FullConnectionResult.success({
    required List<AddressInfo> addresses,
    required List<ConnectionTestResult> connectionResults,
    required Map<String, dynamic> connectionStats,
    required LoginResult loginResult,
    required String quickConnectId,
  }) = FullConnectionResultSuccess;

  const factory FullConnectionResult.failure({
    required String error,
    required String quickConnectId,
  }) = FullConnectionResultFailure;

  const FullConnectionResult._();

  factory FullConnectionResult.fromJson(Map<String, dynamic> json) => 
      _$FullConnectionResultFromJson(json);
}
