import 'package:freezed_annotation/freezed_annotation.dart';

part '../../entities/get_server_info/get_server_info_response.freezed.dart';
part 'get_server_info_response.g.dart';

@freezed
class GetServerInfoResponse with _$GetServerInfoResponse {
  const factory GetServerInfoResponse({
    required String? command,
    required Env? env,
    required List<String>? sites,
    required Server? server,
    required Service? service,
    required SmartDns? smartdns,
    required int? version,
    required String? errinfo,
    required int? errno,
    required int? suberrno,
  }) = _GetServerInfoResponse;

  factory GetServerInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$GetServerInfoResponseFromJson(json);
}

@freezed
class Env with _$Env {
  const factory Env({
    required String? control_host,
    required String? relay_region,
  }) = _Env;

  factory Env.fromJson(Map<String, dynamic> json) => _$EnvFromJson(json);
}

@freezed
class Server with _$Server {
  const factory Server({
    required String? ddns,
    required String? ds_state,
    required External? external,
    required String? fqdn,
    required String? gateway,
    required List<Interface>? interface,
    required List<dynamic>? ipv6_tunnel,
    required bool? is_bsm,
    required String? pingpong_path,
    required String? redirect_prefix,
    required String? serverID,
    required int? tcp_punch_port,
    required int? udp_punch_port,
  }) = _Server;

  factory Server.fromJson(Map<String, dynamic> json) => _$ServerFromJson(json);
}

@freezed
class External with _$External {
  const factory External({
    required String? ip,
    required String? ipv6,
  }) = _External;

  factory External.fromJson(Map<String, dynamic> json) => _$ExternalFromJson(json);
}

@freezed
class Interface with _$Interface {
  const factory Interface({
    required String? ip,
    required List<dynamic>? ipv6,
    required String? mask,
    required String? name,
  }) = _Interface;

  factory Interface.fromJson(Map<String, dynamic> json) => _$InterfaceFromJson(json);
}

@freezed
class Service with _$Service {
  const factory Service({
    required int? port,
    required int? ext_port,
    required String? pingpong,
    required List<dynamic>? pingpong_desc,
    required String? relay_ip,
    required String? relay_dn,
    required int? relay_port,
    required String? vpn_ip,
    required String? https_ip,
    required int? https_port,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
}

@freezed
class SmartDns with _$SmartDns {
  const factory SmartDns({
    required String? host,
    required List<String>? lan,
    required String? hole_punch,
  }) = _SmartDns;

  factory SmartDns.fromJson(Map<String, dynamic> json) => _$SmartDnsFromJson(json);
}