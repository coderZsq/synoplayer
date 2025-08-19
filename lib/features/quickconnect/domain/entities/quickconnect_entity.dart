import 'package:equatable/equatable.dart';

/// QuickConnect 业务实体
/// 
/// 这是领域层的核心实体，不包含任何外部依赖
/// 只包含业务逻辑和验证规则
abstract class QuickConnectEntity extends Equatable {
  const QuickConnectEntity();
}

/// QuickConnect 服务器信息实体
class QuickConnectServerInfo extends QuickConnectEntity {
  const QuickConnectServerInfo({
    required this.id,
    required this.name,
    required this.externalDomain,
    required this.internalIp,
    required this.isOnline,
    this.port,
    this.protocol,
  });

  final String id;
  final String name;
  final String externalDomain;
  final String internalIp;
  final bool isOnline;
  final int? port;
  final String? protocol;

  @override
  List<Object?> get props => [
        id,
        name,
        externalDomain,
        internalIp,
        isOnline,
        port,
        protocol,
      ];

  /// 获取完整的服务器地址
  String get fullAddress {
    if (port != null && protocol != null) {
      return '$protocol://$externalDomain:$port';
    }
    return externalDomain;
  }

  /// 验证服务器信息是否有效
  bool get isValid {
    return id.isNotEmpty &&
        name.isNotEmpty &&
        externalDomain.isNotEmpty &&
        internalIp.isNotEmpty;
  }

  /// 创建副本
  QuickConnectServerInfo copyWith({
    String? id,
    String? name,
    String? externalDomain,
    String? internalIp,
    bool? isOnline,
    int? port,
    String? protocol,
  }) {
    return QuickConnectServerInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      externalDomain: externalDomain ?? this.externalDomain,
      internalIp: internalIp ?? this.internalIp,
      isOnline: isOnline ?? this.isOnline,
      port: port ?? this.port,
      protocol: protocol ?? this.protocol,
    );
  }
}

/// QuickConnect 登录结果实体
class QuickConnectLoginResult extends QuickConnectEntity {
  const QuickConnectLoginResult({
    required this.isSuccess,
    this.sid,
    this.errorMessage,
    this.redirectUrl,
  });

  final bool isSuccess;
  final String? sid;
  final String? errorMessage;
  final String? redirectUrl;

  @override
  List<Object?> get props => [
        isSuccess,
        sid,
        errorMessage,
        redirectUrl,
      ];

  /// 验证登录结果
  bool get isValid {
    if (isSuccess) {
      return sid != null && sid!.isNotEmpty;
    }
    return errorMessage != null && errorMessage!.isNotEmpty;
  }

  /// 创建成功结果
  factory QuickConnectLoginResult.success({
    required String sid,
    String? redirectUrl,
  }) {
    return QuickConnectLoginResult(
      isSuccess: true,
      sid: sid,
      redirectUrl: redirectUrl,
    );
  }

  /// 创建失败结果
  factory QuickConnectLoginResult.failure({
    required String errorMessage,
  }) {
    return QuickConnectLoginResult(
      isSuccess: false,
      errorMessage: errorMessage,
    );
  }
}

/// QuickConnect 连接状态实体
class QuickConnectConnectionStatus extends QuickConnectEntity {
  const QuickConnectConnectionStatus({
    required this.isConnected,
    required this.responseTime,
    this.errorMessage,
    this.serverInfo,
  });

  final bool isConnected;
  final int responseTime; // 毫秒
  final String? errorMessage;
  final QuickConnectServerInfo? serverInfo;

  @override
  List<Object?> get props => [
        isConnected,
        responseTime,
        errorMessage,
        serverInfo,
      ];

  /// 判断连接质量
  String get connectionQuality {
    if (!isConnected) return 'disconnected';
    if (responseTime < 100) return 'excellent';
    if (responseTime < 300) return 'good';
    if (responseTime < 1000) return 'fair';
    return 'poor';
  }

  /// 创建连接成功状态
  factory QuickConnectConnectionStatus.success({
    required int responseTime,
    QuickConnectServerInfo? serverInfo,
  }) {
    return QuickConnectConnectionStatus(
      isConnected: true,
      responseTime: responseTime,
      serverInfo: serverInfo,
    );
  }

  /// 创建连接失败状态
  factory QuickConnectConnectionStatus.failure({
    required String errorMessage,
    int responseTime = 0,
  }) {
    return QuickConnectConnectionStatus(
      isConnected: false,
      responseTime: responseTime,
      errorMessage: errorMessage,
    );
  }
}
