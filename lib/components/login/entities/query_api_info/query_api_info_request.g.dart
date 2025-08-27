// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_api_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueryApiInfoRequestImpl _$$QueryApiInfoRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$QueryApiInfoRequestImpl(
      api: json['api'] as String,
      method: json['method'] as String,
      version: json['version'] as String,
    );

Map<String, dynamic> _$$QueryApiInfoRequestImplToJson(
        _$QueryApiInfoRequestImpl instance) =>
    <String, dynamic>{
      'api': instance.api,
      'method': instance.method,
      'version': instance.version,
    };
