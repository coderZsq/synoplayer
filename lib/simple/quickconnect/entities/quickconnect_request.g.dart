// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quickconnect_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuickConnectRequestImpl _$$QuickConnectRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickConnectRequestImpl(
      getCaFingerprints: json['get_ca_fingerprints'] as bool,
      id: json['id'] as String,
      serverId: json['serverID'] as String,
      command: json['command'] as String,
      version: json['version'] as String,
    );

Map<String, dynamic> _$$QuickConnectRequestImplToJson(
        _$QuickConnectRequestImpl instance) =>
    <String, dynamic>{
      'get_ca_fingerprints': instance.getCaFingerprints,
      'id': instance.id,
      'serverID': instance.serverId,
      'command': instance.command,
      'version': instance.version,
    };
