// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_stream_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudioStreamRequestImpl _$$AudioStreamRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AudioStreamRequestImpl(
      api: json['api'] as String,
      method: json['method'] as String,
      version: json['version'] as String,
      id: json['id'] as String,
      seekPosition: (json['seekPosition'] as num).toInt(),
    );

Map<String, dynamic> _$$AudioStreamRequestImplToJson(
        _$AudioStreamRequestImpl instance) =>
    <String, dynamic>{
      'api': instance.api,
      'method': instance.method,
      'version': instance.version,
      'id': instance.id,
      'seekPosition': instance.seekPosition,
    };
