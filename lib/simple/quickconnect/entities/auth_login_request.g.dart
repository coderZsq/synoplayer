// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthLoginRequestImpl _$$AuthLoginRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthLoginRequestImpl(
      api: json['api'] as String,
      method: json['method'] as String,
      account: json['account'] as String,
      passwd: json['passwd'] as String,
      session: json['session'] as String,
      format: json['format'] as String,
      otp_code: json['otp_code'] as String?,
      version: json['version'] as String,
    );

Map<String, dynamic> _$$AuthLoginRequestImplToJson(
        _$AuthLoginRequestImpl instance) =>
    <String, dynamic>{
      'api': instance.api,
      'method': instance.method,
      'account': instance.account,
      'passwd': instance.passwd,
      'session': instance.session,
      'format': instance.format,
      'otp_code': instance.otp_code,
      'version': instance.version,
    };
