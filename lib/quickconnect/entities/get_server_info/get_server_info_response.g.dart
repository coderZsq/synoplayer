// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_server_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetServerInfoResponseImpl _$$GetServerInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetServerInfoResponseImpl(
      command: json['command'] as String?,
      env: json['env'] == null
          ? null
          : Env.fromJson(json['env'] as Map<String, dynamic>),
      sites:
          (json['sites'] as List<dynamic>?)?.map((e) => e as String).toList(),
      server: json['server'] == null
          ? null
          : Server.fromJson(json['server'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      smartdns: json['smartdns'] == null
          ? null
          : SmartDns.fromJson(json['smartdns'] as Map<String, dynamic>),
      version: (json['version'] as num?)?.toInt(),
      errinfo: json['errinfo'] as String?,
      errno: (json['errno'] as num?)?.toInt(),
      suberrno: (json['suberrno'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$GetServerInfoResponseImplToJson(
        _$GetServerInfoResponseImpl instance) =>
    <String, dynamic>{
      'command': instance.command,
      'env': instance.env,
      'sites': instance.sites,
      'server': instance.server,
      'service': instance.service,
      'smartdns': instance.smartdns,
      'version': instance.version,
      'errinfo': instance.errinfo,
      'errno': instance.errno,
      'suberrno': instance.suberrno,
    };

_$EnvImpl _$$EnvImplFromJson(Map<String, dynamic> json) => _$EnvImpl(
      control_host: json['control_host'] as String?,
      relay_region: json['relay_region'] as String?,
    );

Map<String, dynamic> _$$EnvImplToJson(_$EnvImpl instance) => <String, dynamic>{
      'control_host': instance.control_host,
      'relay_region': instance.relay_region,
    };

_$ServerImpl _$$ServerImplFromJson(Map<String, dynamic> json) => _$ServerImpl(
      ddns: json['ddns'] as String?,
      ds_state: json['ds_state'] as String?,
      external: json['external'] == null
          ? null
          : External.fromJson(json['external'] as Map<String, dynamic>),
      fqdn: json['fqdn'] as String?,
      gateway: json['gateway'] as String?,
      interface: (json['interface'] as List<dynamic>?)
          ?.map((e) => Interface.fromJson(e as Map<String, dynamic>))
          .toList(),
      ipv6_tunnel: json['ipv6_tunnel'] as List<dynamic>?,
      is_bsm: json['is_bsm'] as bool?,
      pingpong_path: json['pingpong_path'] as String?,
      redirect_prefix: json['redirect_prefix'] as String?,
      serverID: json['serverID'] as String?,
      tcp_punch_port: (json['tcp_punch_port'] as num?)?.toInt(),
      udp_punch_port: (json['udp_punch_port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ServerImplToJson(_$ServerImpl instance) =>
    <String, dynamic>{
      'ddns': instance.ddns,
      'ds_state': instance.ds_state,
      'external': instance.external,
      'fqdn': instance.fqdn,
      'gateway': instance.gateway,
      'interface': instance.interface,
      'ipv6_tunnel': instance.ipv6_tunnel,
      'is_bsm': instance.is_bsm,
      'pingpong_path': instance.pingpong_path,
      'redirect_prefix': instance.redirect_prefix,
      'serverID': instance.serverID,
      'tcp_punch_port': instance.tcp_punch_port,
      'udp_punch_port': instance.udp_punch_port,
    };

_$ExternalImpl _$$ExternalImplFromJson(Map<String, dynamic> json) =>
    _$ExternalImpl(
      ip: json['ip'] as String?,
      ipv6: json['ipv6'] as String?,
    );

Map<String, dynamic> _$$ExternalImplToJson(_$ExternalImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'ipv6': instance.ipv6,
    };

_$InterfaceImpl _$$InterfaceImplFromJson(Map<String, dynamic> json) =>
    _$InterfaceImpl(
      ip: json['ip'] as String?,
      ipv6: json['ipv6'] as List<dynamic>?,
      mask: json['mask'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$InterfaceImplToJson(_$InterfaceImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'ipv6': instance.ipv6,
      'mask': instance.mask,
      'name': instance.name,
    };

_$ServiceImpl _$$ServiceImplFromJson(Map<String, dynamic> json) =>
    _$ServiceImpl(
      port: (json['port'] as num?)?.toInt(),
      ext_port: (json['ext_port'] as num?)?.toInt(),
      pingpong: json['pingpong'] as String?,
      pingpong_desc: json['pingpong_desc'] as List<dynamic>?,
      relay_ip: json['relay_ip'] as String?,
      relay_dn: json['relay_dn'] as String?,
      relay_port: (json['relay_port'] as num?)?.toInt(),
      vpn_ip: json['vpn_ip'] as String?,
      https_ip: json['https_ip'] as String?,
      https_port: (json['https_port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ServiceImplToJson(_$ServiceImpl instance) =>
    <String, dynamic>{
      'port': instance.port,
      'ext_port': instance.ext_port,
      'pingpong': instance.pingpong,
      'pingpong_desc': instance.pingpong_desc,
      'relay_ip': instance.relay_ip,
      'relay_dn': instance.relay_dn,
      'relay_port': instance.relay_port,
      'vpn_ip': instance.vpn_ip,
      'https_ip': instance.https_ip,
      'https_port': instance.https_port,
    };

_$SmartDnsImpl _$$SmartDnsImplFromJson(Map<String, dynamic> json) =>
    _$SmartDnsImpl(
      host: json['host'] as String?,
      lan: (json['lan'] as List<dynamic>?)?.map((e) => e as String).toList(),
      hole_punch: json['hole_punch'] as String?,
    );

Map<String, dynamic> _$$SmartDnsImplToJson(_$SmartDnsImpl instance) =>
    <String, dynamic>{
      'host': instance.host,
      'lan': instance.lan,
      'hole_punch': instance.hole_punch,
    };
