// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_server_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuickConnectRequestImpl _$$QuickConnectRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickConnectRequestImpl(
      id: json['id'] as String,
      serverID: json['serverID'] as String,
      command: json['command'] as String,
    );

Map<String, dynamic> _$$QuickConnectRequestImplToJson(
        _$QuickConnectRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serverID': instance.serverID,
      'command': instance.command,
    };
