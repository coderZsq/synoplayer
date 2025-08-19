import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/quickconnect_entity.dart';

part 'quickconnect_model.freezed.dart';
part 'quickconnect_model.g.dart';

/// QuickConnect 服务器信息数据模型
/// 
/// 这是数据层的模型，用于与外部数据源交互
/// 包含序列化和反序列化逻辑
@freezed
class QuickConnectServerInfoModel with _$QuickConnectServerInfoModel {
  const factory QuickConnectServerInfoModel({
    required String id,
    required String name,
    @JsonKey(name: 'external_domain') required String externalDomain,
    @JsonKey(name: 'internal_ip') required String internalIp,
    @JsonKey(name: 'is_online') required bool isOnline,
    int? port,
    String? protocol,
  }) = _QuickConnectServerInfoModel;

  factory QuickConnectServerInfoModel.fromJson(Map<String, dynamic> json) =>
      _$QuickConnectServerInfoModelFromJson(json);

  /// 从领域实体创建数据模型
  factory QuickConnectServerInfoModel.fromEntity(
    QuickConnectServerInfo entity,
  ) {
    return QuickConnectServerInfoModel(
      id: entity.id,
      name: entity.name,
      externalDomain: entity.externalDomain,
      internalIp: entity.internalIp,
      isOnline: entity.isOnline,
      port: entity.port,
      protocol: entity.protocol,
    );
  }
}

/// 转换为领域实体
extension QuickConnectServerInfoModelExtension on QuickConnectServerInfoModel {
  QuickConnectServerInfo toEntity() {
    return QuickConnectServerInfo(
      id: id,
      name: name,
      externalDomain: externalDomain,
      internalIp: internalIp,
      isOnline: isOnline,
      port: port,
      protocol: protocol,
    );
  }
}

/// QuickConnect 登录结果数据模型
@freezed
class QuickConnectLoginResultModel with _$QuickConnectLoginResultModel {
  const factory QuickConnectLoginResultModel({
    @JsonKey(name: 'is_success') required bool isSuccess,
    String? sid,
    @JsonKey(name: 'error_message') String? errorMessage,
    @JsonKey(name: 'redirect_url') String? redirectUrl,
  }) = _QuickConnectLoginResultModel;

  factory QuickConnectLoginResultModel.fromJson(Map<String, dynamic> json) =>
      _$QuickConnectLoginResultModelFromJson(json);

  /// 从领域实体创建数据模型
  factory QuickConnectLoginResultModel.fromEntity(
    QuickConnectLoginResult entity,
  ) {
    return QuickConnectLoginResultModel(
      isSuccess: entity.isSuccess,
      sid: entity.sid,
      errorMessage: entity.errorMessage,
      redirectUrl: entity.redirectUrl,
    );
  }
}

/// 转换为领域实体
extension QuickConnectLoginResultModelExtension on QuickConnectLoginResultModel {
  QuickConnectLoginResult toEntity() {
    return QuickConnectLoginResult(
      isSuccess: isSuccess,
      sid: sid,
      errorMessage: errorMessage,
      redirectUrl: redirectUrl,
    );
  }
}

/// QuickConnect 连接状态数据模型
@freezed
class QuickConnectConnectionStatusModel with _$QuickConnectConnectionStatusModel {
  const factory QuickConnectConnectionStatusModel({
    @JsonKey(name: 'is_connected') required bool isConnected,
    @JsonKey(name: 'response_time') required int responseTime,
    @JsonKey(name: 'error_message') String? errorMessage,
    @JsonKey(name: 'server_info') QuickConnectServerInfoModel? serverInfo,
  }) = _QuickConnectConnectionStatusModel;

  factory QuickConnectConnectionStatusModel.fromJson(Map<String, dynamic> json) =>
      _$QuickConnectConnectionStatusModelFromJson(json);

  /// 从领域实体创建数据模型
  factory QuickConnectConnectionStatusModel.fromEntity(
    QuickConnectConnectionStatus entity,
  ) {
    return QuickConnectConnectionStatusModel(
      isConnected: entity.isConnected,
      responseTime: entity.responseTime,
      errorMessage: entity.errorMessage,
      serverInfo: entity.serverInfo != null
          ? QuickConnectServerInfoModel.fromEntity(entity.serverInfo!)
          : null,
    );
  }
}

/// 转换为领域实体
extension QuickConnectConnectionStatusModelExtension
    on QuickConnectConnectionStatusModel {
  QuickConnectConnectionStatus toEntity() {
    return QuickConnectConnectionStatus(
      isConnected: isConnected,
      responseTime: responseTime,
      errorMessage: errorMessage,
      serverInfo: serverInfo?.toEntity(),
    );
  }
}

/// QuickConnect 隧道响应数据模型
@freezed
class TunnelResponseModel with _$TunnelResponseModel {
  const factory TunnelResponseModel({
    required String id,
    required String domain,
    required int port,
    required String protocol,
    @JsonKey(name: 'is_online') required bool isOnline,
    @JsonKey(name: 'response_time') required int responseTime,
  }) = _TunnelResponseModel;

  factory TunnelResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TunnelResponseModelFromJson(json);
}

/// QuickConnect 服务器信息响应数据模型
@freezed
class ServerInfoResponseModel with _$ServerInfoResponseModel {
  const factory ServerInfoResponseModel({
    required String id,
    required String name,
    @JsonKey(name: 'external_domain') required String externalDomain,
    @JsonKey(name: 'internal_ip') required String internalIp,
    @JsonKey(name: 'is_online') required bool isOnline,
    int? port,
    String? protocol,
    @JsonKey(name: 'response_time') required int responseTime,
  }) = _ServerInfoResponseModel;

  factory ServerInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ServerInfoResponseModelFromJson(json);
}

/// QuickConnect 登录请求数据模型
@freezed
class LoginRequestModel with _$LoginRequestModel {
  const factory LoginRequestModel({
    required String username,
    required String password,
    @JsonKey(name: 'otp_code') String? otpCode,
    @JsonKey(name: 'remember_me') @Default(false) bool rememberMe,
  }) = _LoginRequestModel;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
}

/// QuickConnect 登录响应数据模型
@freezed
class LoginResponseModel with _$LoginResponseModel {
  const factory LoginResponseModel({
    @JsonKey(name: 'is_success') required bool isSuccess,
    String? sid,
    @JsonKey(name: 'error_message') String? errorMessage,
    @JsonKey(name: 'redirect_url') String? redirectUrl,
    @JsonKey(name: 'response_time') required int responseTime,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}
