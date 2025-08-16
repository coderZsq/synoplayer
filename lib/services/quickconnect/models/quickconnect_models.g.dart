// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickconnect_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SuccessResponseImpl _$$SuccessResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SuccessResponseImpl(
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$SuccessResponseImplToJson(
        _$SuccessResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$TunnelDataImpl _$$TunnelDataImplFromJson(Map<String, dynamic> json) =>
    _$TunnelDataImpl(
      relay: json['relay'] == null
          ? null
          : RelayInfo.fromJson(json['relay'] as Map<String, dynamic>),
      external: json['external'] == null
          ? null
          : ExternalInfo.fromJson(json['external'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TunnelDataImplToJson(_$TunnelDataImpl instance) =>
    <String, dynamic>{
      'relay': instance.relay,
      'external': instance.external,
    };

_$RelayInfoImpl _$$RelayInfoImplFromJson(Map<String, dynamic> json) =>
    _$RelayInfoImpl(
      fqdn: json['fqdn'] as String?,
      ip: json['ip'] as String?,
      port: (json['port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RelayInfoImplToJson(_$RelayInfoImpl instance) =>
    <String, dynamic>{
      'fqdn': instance.fqdn,
      'ip': instance.ip,
      'port': instance.port,
    };

_$ExternalInfoImpl _$$ExternalInfoImplFromJson(Map<String, dynamic> json) =>
    _$ExternalInfoImpl(
      fqdn: json['fqdn'] as String?,
      ip: json['ip'] as String?,
      port: (json['port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ExternalInfoImplToJson(_$ExternalInfoImpl instance) =>
    <String, dynamic>{
      'fqdn': instance.fqdn,
      'ip': instance.ip,
      'port': instance.port,
    };

_$ExternalServerInfoImpl _$$ExternalServerInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$ExternalServerInfoImpl(
      ip: json['ip'] as String?,
      port: (json['port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ExternalServerInfoImplToJson(
        _$ExternalServerInfoImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'port': instance.port,
    };

_$InterfaceInfoImpl _$$InterfaceInfoImplFromJson(Map<String, dynamic> json) =>
    _$InterfaceInfoImpl(
      ip: json['ip'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$InterfaceInfoImplToJson(_$InterfaceInfoImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'name': instance.name,
      'type': instance.type,
    };

_$SmartDnsInfoImpl _$$SmartDnsInfoImplFromJson(Map<String, dynamic> json) =>
    _$SmartDnsInfoImpl(
      host: json['host'] as String?,
      port: (json['port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SmartDnsInfoImplToJson(_$SmartDnsInfoImpl instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
    };

_$AddressInfoImpl _$$AddressInfoImplFromJson(Map<String, dynamic> json) =>
    _$AddressInfoImpl(
      url: json['url'] as String,
      type: $enumDecode(_$AddressTypeEnumMap, json['type']),
      description: json['description'] as String,
      priority: (json['priority'] as num).toInt(),
    );

Map<String, dynamic> _$$AddressInfoImplToJson(_$AddressInfoImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': _$AddressTypeEnumMap[instance.type]!,
      'description': instance.description,
      'priority': instance.priority,
    };

const _$AddressTypeEnumMap = {
  AddressType.smartDns: 'smartDns',
  AddressType.relay: 'relay',
  AddressType.httpsRelay: 'httpsRelay',
  AddressType.externalIp: 'externalIp',
  AddressType.lan: 'lan',
  AddressType.site: 'site',
};

_$ConnectionTestResultImpl _$$ConnectionTestResultImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionTestResultImpl(
      url: json['url'] as String,
      isConnected: json['isConnected'] as bool,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      error: json['error'] as String?,
      responseTime:
          Duration(microseconds: (json['responseTime'] as num).toInt()),
    );

Map<String, dynamic> _$$ConnectionTestResultImplToJson(
        _$ConnectionTestResultImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'isConnected': instance.isConnected,
      'statusCode': instance.statusCode,
      'error': instance.error,
      'responseTime': instance.responseTime.inMicroseconds,
    };

_$SmartLoginResultSuccessImpl _$$SmartLoginResultSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$SmartLoginResultSuccessImpl(
      loginResult:
          LoginResult.fromJson(json['loginResult'] as Map<String, dynamic>),
      bestAddress: json['bestAddress'] as String,
      attempts: (json['attempts'] as List<dynamic>)
          .map((e) => LoginAttempt.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: json['stats'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SmartLoginResultSuccessImplToJson(
        _$SmartLoginResultSuccessImpl instance) =>
    <String, dynamic>{
      'loginResult': instance.loginResult,
      'bestAddress': instance.bestAddress,
      'attempts': instance.attempts,
      'stats': instance.stats,
      'runtimeType': instance.$type,
    };

_$SmartLoginResultFailureImpl _$$SmartLoginResultFailureImplFromJson(
        Map<String, dynamic> json) =>
    _$SmartLoginResultFailureImpl(
      error: json['error'] as String,
      attempts: (json['attempts'] as List<dynamic>)
          .map((e) => LoginAttempt.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: json['stats'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SmartLoginResultFailureImplToJson(
        _$SmartLoginResultFailureImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'attempts': instance.attempts,
      'stats': instance.stats,
      'runtimeType': instance.$type,
    };

_$LoginAttemptImpl _$$LoginAttemptImplFromJson(Map<String, dynamic> json) =>
    _$LoginAttemptImpl(
      address: json['address'] as String,
      addressType: $enumDecode(_$AddressTypeEnumMap, json['addressType']),
      priority: (json['priority'] as num).toInt(),
      attemptNumber: (json['attemptNumber'] as num).toInt(),
      connectionResult: json['connectionResult'] == null
          ? null
          : ConnectionTestResult.fromJson(
              json['connectionResult'] as Map<String, dynamic>),
      loginResult: json['loginResult'] == null
          ? null
          : LoginResult.fromJson(json['loginResult'] as Map<String, dynamic>),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$LoginAttemptImplToJson(_$LoginAttemptImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'addressType': _$AddressTypeEnumMap[instance.addressType]!,
      'priority': instance.priority,
      'attemptNumber': instance.attemptNumber,
      'connectionResult': instance.connectionResult,
      'loginResult': instance.loginResult,
      'error': instance.error,
    };

_$QuickConnectResultSuccessImpl _$$QuickConnectResultSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickConnectResultSuccessImpl(
      address: json['address'] as String,
      connectionResult: ConnectionTestResult.fromJson(
          json['connectionResult'] as Map<String, dynamic>),
      quickConnectId: json['quickConnectId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuickConnectResultSuccessImplToJson(
        _$QuickConnectResultSuccessImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'connectionResult': instance.connectionResult,
      'quickConnectId': instance.quickConnectId,
      'runtimeType': instance.$type,
    };

_$QuickConnectResultFailureImpl _$$QuickConnectResultFailureImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickConnectResultFailureImpl(
      error: json['error'] as String,
      quickConnectId: json['quickConnectId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuickConnectResultFailureImplToJson(
        _$QuickConnectResultFailureImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'quickConnectId': instance.quickConnectId,
      'runtimeType': instance.$type,
    };

_$FullConnectionResultSuccessImpl _$$FullConnectionResultSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$FullConnectionResultSuccessImpl(
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => AddressInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      connectionResults: (json['connectionResults'] as List<dynamic>)
          .map((e) => ConnectionTestResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      connectionStats: json['connectionStats'] as Map<String, dynamic>,
      loginResult:
          LoginResult.fromJson(json['loginResult'] as Map<String, dynamic>),
      quickConnectId: json['quickConnectId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FullConnectionResultSuccessImplToJson(
        _$FullConnectionResultSuccessImpl instance) =>
    <String, dynamic>{
      'addresses': instance.addresses,
      'connectionResults': instance.connectionResults,
      'connectionStats': instance.connectionStats,
      'loginResult': instance.loginResult,
      'quickConnectId': instance.quickConnectId,
      'runtimeType': instance.$type,
    };

_$FullConnectionResultFailureImpl _$$FullConnectionResultFailureImplFromJson(
        Map<String, dynamic> json) =>
    _$FullConnectionResultFailureImpl(
      error: json['error'] as String,
      quickConnectId: json['quickConnectId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FullConnectionResultFailureImplToJson(
        _$FullConnectionResultFailureImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'quickConnectId': instance.quickConnectId,
      'runtimeType': instance.$type,
    };
