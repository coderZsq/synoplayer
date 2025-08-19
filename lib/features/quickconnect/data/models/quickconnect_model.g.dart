// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickconnect_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuickConnectServerInfoModelImpl _$$QuickConnectServerInfoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickConnectServerInfoModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      externalDomain: json['external_domain'] as String,
      internalIp: json['internal_ip'] as String,
      isOnline: json['is_online'] as bool,
      port: (json['port'] as num?)?.toInt(),
      protocol: json['protocol'] as String?,
    );

Map<String, dynamic> _$$QuickConnectServerInfoModelImplToJson(
        _$QuickConnectServerInfoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'external_domain': instance.externalDomain,
      'internal_ip': instance.internalIp,
      'is_online': instance.isOnline,
      'port': instance.port,
      'protocol': instance.protocol,
    };

_$QuickConnectLoginResultModelImpl _$$QuickConnectLoginResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickConnectLoginResultModelImpl(
      isSuccess: json['is_success'] as bool,
      sid: json['sid'] as String?,
      errorMessage: json['error_message'] as String?,
      redirectUrl: json['redirect_url'] as String?,
    );

Map<String, dynamic> _$$QuickConnectLoginResultModelImplToJson(
        _$QuickConnectLoginResultModelImpl instance) =>
    <String, dynamic>{
      'is_success': instance.isSuccess,
      'sid': instance.sid,
      'error_message': instance.errorMessage,
      'redirect_url': instance.redirectUrl,
    };

_$QuickConnectConnectionStatusModelImpl
    _$$QuickConnectConnectionStatusModelImplFromJson(
            Map<String, dynamic> json) =>
        _$QuickConnectConnectionStatusModelImpl(
          isConnected: json['is_connected'] as bool,
          responseTime: (json['response_time'] as num).toInt(),
          errorMessage: json['error_message'] as String?,
          serverInfo: json['server_info'] == null
              ? null
              : QuickConnectServerInfoModel.fromJson(
                  json['server_info'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$QuickConnectConnectionStatusModelImplToJson(
        _$QuickConnectConnectionStatusModelImpl instance) =>
    <String, dynamic>{
      'is_connected': instance.isConnected,
      'response_time': instance.responseTime,
      'error_message': instance.errorMessage,
      'server_info': instance.serverInfo,
    };

_$TunnelResponseModelImpl _$$TunnelResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TunnelResponseModelImpl(
      id: json['id'] as String,
      domain: json['domain'] as String,
      port: (json['port'] as num).toInt(),
      protocol: json['protocol'] as String,
      isOnline: json['is_online'] as bool,
      responseTime: (json['response_time'] as num).toInt(),
    );

Map<String, dynamic> _$$TunnelResponseModelImplToJson(
        _$TunnelResponseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'domain': instance.domain,
      'port': instance.port,
      'protocol': instance.protocol,
      'is_online': instance.isOnline,
      'response_time': instance.responseTime,
    };

_$ServerInfoResponseModelImpl _$$ServerInfoResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ServerInfoResponseModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      externalDomain: json['external_domain'] as String,
      internalIp: json['internal_ip'] as String,
      isOnline: json['is_online'] as bool,
      port: (json['port'] as num?)?.toInt(),
      protocol: json['protocol'] as String?,
      responseTime: (json['response_time'] as num).toInt(),
    );

Map<String, dynamic> _$$ServerInfoResponseModelImplToJson(
        _$ServerInfoResponseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'external_domain': instance.externalDomain,
      'internal_ip': instance.internalIp,
      'is_online': instance.isOnline,
      'port': instance.port,
      'protocol': instance.protocol,
      'response_time': instance.responseTime,
    };

_$LoginRequestModelImpl _$$LoginRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginRequestModelImpl(
      username: json['username'] as String,
      password: json['password'] as String,
      otpCode: json['otp_code'] as String?,
      rememberMe: json['remember_me'] as bool? ?? false,
    );

Map<String, dynamic> _$$LoginRequestModelImplToJson(
        _$LoginRequestModelImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'otp_code': instance.otpCode,
      'remember_me': instance.rememberMe,
    };

_$LoginResponseModelImpl _$$LoginResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginResponseModelImpl(
      isSuccess: json['is_success'] as bool,
      sid: json['sid'] as String?,
      errorMessage: json['error_message'] as String?,
      redirectUrl: json['redirect_url'] as String?,
      responseTime: (json['response_time'] as num).toInt(),
    );

Map<String, dynamic> _$$LoginResponseModelImplToJson(
        _$LoginResponseModelImpl instance) =>
    <String, dynamic>{
      'is_success': instance.isSuccess,
      'sid': instance.sid,
      'error_message': instance.errorMessage,
      'redirect_url': instance.redirectUrl,
      'response_time': instance.responseTime,
    };
