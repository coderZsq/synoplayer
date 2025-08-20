// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickconnect_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuickConnectResponseImpl _$$QuickConnectResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickConnectResponseImpl(
      command: json['command'] as String,
      errinfo: json['errinfo'] as String,
      errno: _toString(json['errno']),
      sites: (json['sites'] as List<dynamic>).map((e) => e as String).toList(),
      suberrno: _toString(json['suberrno']),
      version: _toString(json['version']),
    );

Map<String, dynamic> _$$QuickConnectResponseImplToJson(
        _$QuickConnectResponseImpl instance) =>
    <String, dynamic>{
      'command': instance.command,
      'errinfo': instance.errinfo,
      'errno': instance.errno,
      'sites': instance.sites,
      'suberrno': instance.suberrno,
      'version': instance.version,
    };
