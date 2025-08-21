// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_server_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetServerInfoResponseImpl _$$GetServerInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetServerInfoResponseImpl(
      command: json['command'] as String,
      errinfo: json['errinfo'] as String,
      errno: (json['errno'] as num).toInt(),
      sites: (json['sites'] as List<dynamic>).map((e) => e as String).toList(),
      suberrno: (json['suberrno'] as num).toInt(),
      version: (json['version'] as num).toInt(),
    );

Map<String, dynamic> _$$GetServerInfoResponseImplToJson(
        _$GetServerInfoResponseImpl instance) =>
    <String, dynamic>{
      'command': instance.command,
      'errinfo': instance.errinfo,
      'errno': instance.errno,
      'sites': instance.sites,
      'suberrno': instance.suberrno,
      'version': instance.version,
    };
