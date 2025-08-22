// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_api_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueryApiInfoResponseImpl _$$QueryApiInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$QueryApiInfoResponseImpl(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ApiInfo.fromJson(e as Map<String, dynamic>)),
      ),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$$QueryApiInfoResponseImplToJson(
        _$QueryApiInfoResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
    };

_$ApiInfoImpl _$$ApiInfoImplFromJson(Map<String, dynamic> json) =>
    _$ApiInfoImpl(
      maxVersion: (json['maxVersion'] as num?)?.toInt(),
      minVersion: (json['minVersion'] as num?)?.toInt(),
      path: json['path'] as String?,
      requestFormat: json['requestFormat'] as String?,
    );

Map<String, dynamic> _$$ApiInfoImplToJson(_$ApiInfoImpl instance) =>
    <String, dynamic>{
      'maxVersion': instance.maxVersion,
      'minVersion': instance.minVersion,
      'path': instance.path,
      'requestFormat': instance.requestFormat,
    };
