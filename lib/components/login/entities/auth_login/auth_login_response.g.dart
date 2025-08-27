// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthLoginResponseImpl _$$AuthLoginResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthLoginResponseImpl(
      error: json['error'] == null
          ? null
          : ErrorInfo.fromJson(json['error'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthLoginResponseImplToJson(
        _$AuthLoginResponseImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };

_$ErrorInfoImpl _$$ErrorInfoImplFromJson(Map<String, dynamic> json) =>
    _$ErrorInfoImpl(
      code: (json['code'] as num?)?.toInt(),
      errors: json['errors'] == null
          ? null
          : ErrorDetails.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ErrorInfoImplToJson(_$ErrorInfoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'errors': instance.errors,
    };

_$ErrorDetailsImpl _$$ErrorDetailsImplFromJson(Map<String, dynamic> json) =>
    _$ErrorDetailsImpl(
      token: json['token'] as String?,
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => ErrorType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ErrorDetailsImplToJson(_$ErrorDetailsImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'types': instance.types,
    };

_$ErrorTypeImpl _$$ErrorTypeImplFromJson(Map<String, dynamic> json) =>
    _$ErrorTypeImpl(
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$ErrorTypeImplToJson(_$ErrorTypeImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

_$LoginDataImpl _$$LoginDataImplFromJson(Map<String, dynamic> json) =>
    _$LoginDataImpl(
      account: json['account'] as String?,
      deviceId: json['deviceId'] as String?,
      ikMessage: json['ikMessage'] as String?,
      isPortalPort: json['isPortalPort'] as bool?,
      sid: json['sid'] as String?,
      synotoken: json['synotoken'] as String?,
    );

Map<String, dynamic> _$$LoginDataImplToJson(_$LoginDataImpl instance) =>
    <String, dynamic>{
      'account': instance.account,
      'deviceId': instance.deviceId,
      'ikMessage': instance.ikMessage,
      'isPortalPort': instance.isPortalPort,
      'sid': instance.sid,
      'synotoken': instance.synotoken,
    };
