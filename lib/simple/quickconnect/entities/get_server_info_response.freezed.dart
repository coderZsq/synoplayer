// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_server_info_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetServerInfoResponse _$GetServerInfoResponseFromJson(
    Map<String, dynamic> json) {
  return _GetServerInfoResponse.fromJson(json);
}

/// @nodoc
mixin _$GetServerInfoResponse {
  String? get command => throw _privateConstructorUsedError;
  Env? get env => throw _privateConstructorUsedError;
  List<String>? get sites => throw _privateConstructorUsedError;
  Server? get server => throw _privateConstructorUsedError;
  Service? get service => throw _privateConstructorUsedError;
  SmartDns? get smartdns => throw _privateConstructorUsedError;
  int? get version => throw _privateConstructorUsedError;
  String? get errinfo => throw _privateConstructorUsedError;
  int? get errno => throw _privateConstructorUsedError;
  int? get suberrno => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetServerInfoResponseCopyWith<GetServerInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetServerInfoResponseCopyWith<$Res> {
  factory $GetServerInfoResponseCopyWith(GetServerInfoResponse value,
          $Res Function(GetServerInfoResponse) then) =
      _$GetServerInfoResponseCopyWithImpl<$Res, GetServerInfoResponse>;
  @useResult
  $Res call(
      {String? command,
      Env? env,
      List<String>? sites,
      Server? server,
      Service? service,
      SmartDns? smartdns,
      int? version,
      String? errinfo,
      int? errno,
      int? suberrno});

  $EnvCopyWith<$Res>? get env;
  $ServerCopyWith<$Res>? get server;
  $ServiceCopyWith<$Res>? get service;
  $SmartDnsCopyWith<$Res>? get smartdns;
}

/// @nodoc
class _$GetServerInfoResponseCopyWithImpl<$Res,
        $Val extends GetServerInfoResponse>
    implements $GetServerInfoResponseCopyWith<$Res> {
  _$GetServerInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = freezed,
    Object? env = freezed,
    Object? sites = freezed,
    Object? server = freezed,
    Object? service = freezed,
    Object? smartdns = freezed,
    Object? version = freezed,
    Object? errinfo = freezed,
    Object? errno = freezed,
    Object? suberrno = freezed,
  }) {
    return _then(_value.copyWith(
      command: freezed == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String?,
      env: freezed == env
          ? _value.env
          : env // ignore: cast_nullable_to_non_nullable
              as Env?,
      sites: freezed == sites
          ? _value.sites
          : sites // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      server: freezed == server
          ? _value.server
          : server // ignore: cast_nullable_to_non_nullable
              as Server?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as Service?,
      smartdns: freezed == smartdns
          ? _value.smartdns
          : smartdns // ignore: cast_nullable_to_non_nullable
              as SmartDns?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
      errinfo: freezed == errinfo
          ? _value.errinfo
          : errinfo // ignore: cast_nullable_to_non_nullable
              as String?,
      errno: freezed == errno
          ? _value.errno
          : errno // ignore: cast_nullable_to_non_nullable
              as int?,
      suberrno: freezed == suberrno
          ? _value.suberrno
          : suberrno // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EnvCopyWith<$Res>? get env {
    if (_value.env == null) {
      return null;
    }

    return $EnvCopyWith<$Res>(_value.env!, (value) {
      return _then(_value.copyWith(env: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ServerCopyWith<$Res>? get server {
    if (_value.server == null) {
      return null;
    }

    return $ServerCopyWith<$Res>(_value.server!, (value) {
      return _then(_value.copyWith(server: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ServiceCopyWith<$Res>? get service {
    if (_value.service == null) {
      return null;
    }

    return $ServiceCopyWith<$Res>(_value.service!, (value) {
      return _then(_value.copyWith(service: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SmartDnsCopyWith<$Res>? get smartdns {
    if (_value.smartdns == null) {
      return null;
    }

    return $SmartDnsCopyWith<$Res>(_value.smartdns!, (value) {
      return _then(_value.copyWith(smartdns: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetServerInfoResponseImplCopyWith<$Res>
    implements $GetServerInfoResponseCopyWith<$Res> {
  factory _$$GetServerInfoResponseImplCopyWith(
          _$GetServerInfoResponseImpl value,
          $Res Function(_$GetServerInfoResponseImpl) then) =
      __$$GetServerInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? command,
      Env? env,
      List<String>? sites,
      Server? server,
      Service? service,
      SmartDns? smartdns,
      int? version,
      String? errinfo,
      int? errno,
      int? suberrno});

  @override
  $EnvCopyWith<$Res>? get env;
  @override
  $ServerCopyWith<$Res>? get server;
  @override
  $ServiceCopyWith<$Res>? get service;
  @override
  $SmartDnsCopyWith<$Res>? get smartdns;
}

/// @nodoc
class __$$GetServerInfoResponseImplCopyWithImpl<$Res>
    extends _$GetServerInfoResponseCopyWithImpl<$Res,
        _$GetServerInfoResponseImpl>
    implements _$$GetServerInfoResponseImplCopyWith<$Res> {
  __$$GetServerInfoResponseImplCopyWithImpl(_$GetServerInfoResponseImpl _value,
      $Res Function(_$GetServerInfoResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = freezed,
    Object? env = freezed,
    Object? sites = freezed,
    Object? server = freezed,
    Object? service = freezed,
    Object? smartdns = freezed,
    Object? version = freezed,
    Object? errinfo = freezed,
    Object? errno = freezed,
    Object? suberrno = freezed,
  }) {
    return _then(_$GetServerInfoResponseImpl(
      command: freezed == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String?,
      env: freezed == env
          ? _value.env
          : env // ignore: cast_nullable_to_non_nullable
              as Env?,
      sites: freezed == sites
          ? _value._sites
          : sites // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      server: freezed == server
          ? _value.server
          : server // ignore: cast_nullable_to_non_nullable
              as Server?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as Service?,
      smartdns: freezed == smartdns
          ? _value.smartdns
          : smartdns // ignore: cast_nullable_to_non_nullable
              as SmartDns?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
      errinfo: freezed == errinfo
          ? _value.errinfo
          : errinfo // ignore: cast_nullable_to_non_nullable
              as String?,
      errno: freezed == errno
          ? _value.errno
          : errno // ignore: cast_nullable_to_non_nullable
              as int?,
      suberrno: freezed == suberrno
          ? _value.suberrno
          : suberrno // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetServerInfoResponseImpl implements _GetServerInfoResponse {
  const _$GetServerInfoResponseImpl(
      {required this.command,
      required this.env,
      required final List<String>? sites,
      required this.server,
      required this.service,
      required this.smartdns,
      required this.version,
      required this.errinfo,
      required this.errno,
      required this.suberrno})
      : _sites = sites;

  factory _$GetServerInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetServerInfoResponseImplFromJson(json);

  @override
  final String? command;
  @override
  final Env? env;
  final List<String>? _sites;
  @override
  List<String>? get sites {
    final value = _sites;
    if (value == null) return null;
    if (_sites is EqualUnmodifiableListView) return _sites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Server? server;
  @override
  final Service? service;
  @override
  final SmartDns? smartdns;
  @override
  final int? version;
  @override
  final String? errinfo;
  @override
  final int? errno;
  @override
  final int? suberrno;

  @override
  String toString() {
    return 'GetServerInfoResponse(command: $command, env: $env, sites: $sites, server: $server, service: $service, smartdns: $smartdns, version: $version, errinfo: $errinfo, errno: $errno, suberrno: $suberrno)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetServerInfoResponseImpl &&
            (identical(other.command, command) || other.command == command) &&
            (identical(other.env, env) || other.env == env) &&
            const DeepCollectionEquality().equals(other._sites, _sites) &&
            (identical(other.server, server) || other.server == server) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.smartdns, smartdns) ||
                other.smartdns == smartdns) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.errinfo, errinfo) || other.errinfo == errinfo) &&
            (identical(other.errno, errno) || other.errno == errno) &&
            (identical(other.suberrno, suberrno) ||
                other.suberrno == suberrno));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      command,
      env,
      const DeepCollectionEquality().hash(_sites),
      server,
      service,
      smartdns,
      version,
      errinfo,
      errno,
      suberrno);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetServerInfoResponseImplCopyWith<_$GetServerInfoResponseImpl>
      get copyWith => __$$GetServerInfoResponseImplCopyWithImpl<
          _$GetServerInfoResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetServerInfoResponseImplToJson(
      this,
    );
  }
}

abstract class _GetServerInfoResponse implements GetServerInfoResponse {
  const factory _GetServerInfoResponse(
      {required final String? command,
      required final Env? env,
      required final List<String>? sites,
      required final Server? server,
      required final Service? service,
      required final SmartDns? smartdns,
      required final int? version,
      required final String? errinfo,
      required final int? errno,
      required final int? suberrno}) = _$GetServerInfoResponseImpl;

  factory _GetServerInfoResponse.fromJson(Map<String, dynamic> json) =
      _$GetServerInfoResponseImpl.fromJson;

  @override
  String? get command;
  @override
  Env? get env;
  @override
  List<String>? get sites;
  @override
  Server? get server;
  @override
  Service? get service;
  @override
  SmartDns? get smartdns;
  @override
  int? get version;
  @override
  String? get errinfo;
  @override
  int? get errno;
  @override
  int? get suberrno;
  @override
  @JsonKey(ignore: true)
  _$$GetServerInfoResponseImplCopyWith<_$GetServerInfoResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Env _$EnvFromJson(Map<String, dynamic> json) {
  return _Env.fromJson(json);
}

/// @nodoc
mixin _$Env {
  String? get control_host => throw _privateConstructorUsedError;
  String? get relay_region => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EnvCopyWith<Env> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnvCopyWith<$Res> {
  factory $EnvCopyWith(Env value, $Res Function(Env) then) =
      _$EnvCopyWithImpl<$Res, Env>;
  @useResult
  $Res call({String? control_host, String? relay_region});
}

/// @nodoc
class _$EnvCopyWithImpl<$Res, $Val extends Env> implements $EnvCopyWith<$Res> {
  _$EnvCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? control_host = freezed,
    Object? relay_region = freezed,
  }) {
    return _then(_value.copyWith(
      control_host: freezed == control_host
          ? _value.control_host
          : control_host // ignore: cast_nullable_to_non_nullable
              as String?,
      relay_region: freezed == relay_region
          ? _value.relay_region
          : relay_region // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnvImplCopyWith<$Res> implements $EnvCopyWith<$Res> {
  factory _$$EnvImplCopyWith(_$EnvImpl value, $Res Function(_$EnvImpl) then) =
      __$$EnvImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? control_host, String? relay_region});
}

/// @nodoc
class __$$EnvImplCopyWithImpl<$Res> extends _$EnvCopyWithImpl<$Res, _$EnvImpl>
    implements _$$EnvImplCopyWith<$Res> {
  __$$EnvImplCopyWithImpl(_$EnvImpl _value, $Res Function(_$EnvImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? control_host = freezed,
    Object? relay_region = freezed,
  }) {
    return _then(_$EnvImpl(
      control_host: freezed == control_host
          ? _value.control_host
          : control_host // ignore: cast_nullable_to_non_nullable
              as String?,
      relay_region: freezed == relay_region
          ? _value.relay_region
          : relay_region // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnvImpl implements _Env {
  const _$EnvImpl({required this.control_host, required this.relay_region});

  factory _$EnvImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnvImplFromJson(json);

  @override
  final String? control_host;
  @override
  final String? relay_region;

  @override
  String toString() {
    return 'Env(control_host: $control_host, relay_region: $relay_region)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnvImpl &&
            (identical(other.control_host, control_host) ||
                other.control_host == control_host) &&
            (identical(other.relay_region, relay_region) ||
                other.relay_region == relay_region));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, control_host, relay_region);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnvImplCopyWith<_$EnvImpl> get copyWith =>
      __$$EnvImplCopyWithImpl<_$EnvImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnvImplToJson(
      this,
    );
  }
}

abstract class _Env implements Env {
  const factory _Env(
      {required final String? control_host,
      required final String? relay_region}) = _$EnvImpl;

  factory _Env.fromJson(Map<String, dynamic> json) = _$EnvImpl.fromJson;

  @override
  String? get control_host;
  @override
  String? get relay_region;
  @override
  @JsonKey(ignore: true)
  _$$EnvImplCopyWith<_$EnvImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Server _$ServerFromJson(Map<String, dynamic> json) {
  return _Server.fromJson(json);
}

/// @nodoc
mixin _$Server {
  String? get ddns => throw _privateConstructorUsedError;
  String? get ds_state => throw _privateConstructorUsedError;
  External? get external => throw _privateConstructorUsedError;
  String? get fqdn => throw _privateConstructorUsedError;
  String? get gateway => throw _privateConstructorUsedError;
  List<Interface>? get interface => throw _privateConstructorUsedError;
  List<dynamic>? get ipv6_tunnel => throw _privateConstructorUsedError;
  bool? get is_bsm => throw _privateConstructorUsedError;
  String? get pingpong_path => throw _privateConstructorUsedError;
  String? get redirect_prefix => throw _privateConstructorUsedError;
  String? get serverID => throw _privateConstructorUsedError;
  int? get tcp_punch_port => throw _privateConstructorUsedError;
  int? get udp_punch_port => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServerCopyWith<Server> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerCopyWith<$Res> {
  factory $ServerCopyWith(Server value, $Res Function(Server) then) =
      _$ServerCopyWithImpl<$Res, Server>;
  @useResult
  $Res call(
      {String? ddns,
      String? ds_state,
      External? external,
      String? fqdn,
      String? gateway,
      List<Interface>? interface,
      List<dynamic>? ipv6_tunnel,
      bool? is_bsm,
      String? pingpong_path,
      String? redirect_prefix,
      String? serverID,
      int? tcp_punch_port,
      int? udp_punch_port});

  $ExternalCopyWith<$Res>? get external;
}

/// @nodoc
class _$ServerCopyWithImpl<$Res, $Val extends Server>
    implements $ServerCopyWith<$Res> {
  _$ServerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ddns = freezed,
    Object? ds_state = freezed,
    Object? external = freezed,
    Object? fqdn = freezed,
    Object? gateway = freezed,
    Object? interface = freezed,
    Object? ipv6_tunnel = freezed,
    Object? is_bsm = freezed,
    Object? pingpong_path = freezed,
    Object? redirect_prefix = freezed,
    Object? serverID = freezed,
    Object? tcp_punch_port = freezed,
    Object? udp_punch_port = freezed,
  }) {
    return _then(_value.copyWith(
      ddns: freezed == ddns
          ? _value.ddns
          : ddns // ignore: cast_nullable_to_non_nullable
              as String?,
      ds_state: freezed == ds_state
          ? _value.ds_state
          : ds_state // ignore: cast_nullable_to_non_nullable
              as String?,
      external: freezed == external
          ? _value.external
          : external // ignore: cast_nullable_to_non_nullable
              as External?,
      fqdn: freezed == fqdn
          ? _value.fqdn
          : fqdn // ignore: cast_nullable_to_non_nullable
              as String?,
      gateway: freezed == gateway
          ? _value.gateway
          : gateway // ignore: cast_nullable_to_non_nullable
              as String?,
      interface: freezed == interface
          ? _value.interface
          : interface // ignore: cast_nullable_to_non_nullable
              as List<Interface>?,
      ipv6_tunnel: freezed == ipv6_tunnel
          ? _value.ipv6_tunnel
          : ipv6_tunnel // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      is_bsm: freezed == is_bsm
          ? _value.is_bsm
          : is_bsm // ignore: cast_nullable_to_non_nullable
              as bool?,
      pingpong_path: freezed == pingpong_path
          ? _value.pingpong_path
          : pingpong_path // ignore: cast_nullable_to_non_nullable
              as String?,
      redirect_prefix: freezed == redirect_prefix
          ? _value.redirect_prefix
          : redirect_prefix // ignore: cast_nullable_to_non_nullable
              as String?,
      serverID: freezed == serverID
          ? _value.serverID
          : serverID // ignore: cast_nullable_to_non_nullable
              as String?,
      tcp_punch_port: freezed == tcp_punch_port
          ? _value.tcp_punch_port
          : tcp_punch_port // ignore: cast_nullable_to_non_nullable
              as int?,
      udp_punch_port: freezed == udp_punch_port
          ? _value.udp_punch_port
          : udp_punch_port // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExternalCopyWith<$Res>? get external {
    if (_value.external == null) {
      return null;
    }

    return $ExternalCopyWith<$Res>(_value.external!, (value) {
      return _then(_value.copyWith(external: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ServerImplCopyWith<$Res> implements $ServerCopyWith<$Res> {
  factory _$$ServerImplCopyWith(
          _$ServerImpl value, $Res Function(_$ServerImpl) then) =
      __$$ServerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? ddns,
      String? ds_state,
      External? external,
      String? fqdn,
      String? gateway,
      List<Interface>? interface,
      List<dynamic>? ipv6_tunnel,
      bool? is_bsm,
      String? pingpong_path,
      String? redirect_prefix,
      String? serverID,
      int? tcp_punch_port,
      int? udp_punch_port});

  @override
  $ExternalCopyWith<$Res>? get external;
}

/// @nodoc
class __$$ServerImplCopyWithImpl<$Res>
    extends _$ServerCopyWithImpl<$Res, _$ServerImpl>
    implements _$$ServerImplCopyWith<$Res> {
  __$$ServerImplCopyWithImpl(
      _$ServerImpl _value, $Res Function(_$ServerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ddns = freezed,
    Object? ds_state = freezed,
    Object? external = freezed,
    Object? fqdn = freezed,
    Object? gateway = freezed,
    Object? interface = freezed,
    Object? ipv6_tunnel = freezed,
    Object? is_bsm = freezed,
    Object? pingpong_path = freezed,
    Object? redirect_prefix = freezed,
    Object? serverID = freezed,
    Object? tcp_punch_port = freezed,
    Object? udp_punch_port = freezed,
  }) {
    return _then(_$ServerImpl(
      ddns: freezed == ddns
          ? _value.ddns
          : ddns // ignore: cast_nullable_to_non_nullable
              as String?,
      ds_state: freezed == ds_state
          ? _value.ds_state
          : ds_state // ignore: cast_nullable_to_non_nullable
              as String?,
      external: freezed == external
          ? _value.external
          : external // ignore: cast_nullable_to_non_nullable
              as External?,
      fqdn: freezed == fqdn
          ? _value.fqdn
          : fqdn // ignore: cast_nullable_to_non_nullable
              as String?,
      gateway: freezed == gateway
          ? _value.gateway
          : gateway // ignore: cast_nullable_to_non_nullable
              as String?,
      interface: freezed == interface
          ? _value._interface
          : interface // ignore: cast_nullable_to_non_nullable
              as List<Interface>?,
      ipv6_tunnel: freezed == ipv6_tunnel
          ? _value._ipv6_tunnel
          : ipv6_tunnel // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      is_bsm: freezed == is_bsm
          ? _value.is_bsm
          : is_bsm // ignore: cast_nullable_to_non_nullable
              as bool?,
      pingpong_path: freezed == pingpong_path
          ? _value.pingpong_path
          : pingpong_path // ignore: cast_nullable_to_non_nullable
              as String?,
      redirect_prefix: freezed == redirect_prefix
          ? _value.redirect_prefix
          : redirect_prefix // ignore: cast_nullable_to_non_nullable
              as String?,
      serverID: freezed == serverID
          ? _value.serverID
          : serverID // ignore: cast_nullable_to_non_nullable
              as String?,
      tcp_punch_port: freezed == tcp_punch_port
          ? _value.tcp_punch_port
          : tcp_punch_port // ignore: cast_nullable_to_non_nullable
              as int?,
      udp_punch_port: freezed == udp_punch_port
          ? _value.udp_punch_port
          : udp_punch_port // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerImpl implements _Server {
  const _$ServerImpl(
      {required this.ddns,
      required this.ds_state,
      required this.external,
      required this.fqdn,
      required this.gateway,
      required final List<Interface>? interface,
      required final List<dynamic>? ipv6_tunnel,
      required this.is_bsm,
      required this.pingpong_path,
      required this.redirect_prefix,
      required this.serverID,
      required this.tcp_punch_port,
      required this.udp_punch_port})
      : _interface = interface,
        _ipv6_tunnel = ipv6_tunnel;

  factory _$ServerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerImplFromJson(json);

  @override
  final String? ddns;
  @override
  final String? ds_state;
  @override
  final External? external;
  @override
  final String? fqdn;
  @override
  final String? gateway;
  final List<Interface>? _interface;
  @override
  List<Interface>? get interface {
    final value = _interface;
    if (value == null) return null;
    if (_interface is EqualUnmodifiableListView) return _interface;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _ipv6_tunnel;
  @override
  List<dynamic>? get ipv6_tunnel {
    final value = _ipv6_tunnel;
    if (value == null) return null;
    if (_ipv6_tunnel is EqualUnmodifiableListView) return _ipv6_tunnel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? is_bsm;
  @override
  final String? pingpong_path;
  @override
  final String? redirect_prefix;
  @override
  final String? serverID;
  @override
  final int? tcp_punch_port;
  @override
  final int? udp_punch_port;

  @override
  String toString() {
    return 'Server(ddns: $ddns, ds_state: $ds_state, external: $external, fqdn: $fqdn, gateway: $gateway, interface: $interface, ipv6_tunnel: $ipv6_tunnel, is_bsm: $is_bsm, pingpong_path: $pingpong_path, redirect_prefix: $redirect_prefix, serverID: $serverID, tcp_punch_port: $tcp_punch_port, udp_punch_port: $udp_punch_port)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerImpl &&
            (identical(other.ddns, ddns) || other.ddns == ddns) &&
            (identical(other.ds_state, ds_state) ||
                other.ds_state == ds_state) &&
            (identical(other.external, external) ||
                other.external == external) &&
            (identical(other.fqdn, fqdn) || other.fqdn == fqdn) &&
            (identical(other.gateway, gateway) || other.gateway == gateway) &&
            const DeepCollectionEquality()
                .equals(other._interface, _interface) &&
            const DeepCollectionEquality()
                .equals(other._ipv6_tunnel, _ipv6_tunnel) &&
            (identical(other.is_bsm, is_bsm) || other.is_bsm == is_bsm) &&
            (identical(other.pingpong_path, pingpong_path) ||
                other.pingpong_path == pingpong_path) &&
            (identical(other.redirect_prefix, redirect_prefix) ||
                other.redirect_prefix == redirect_prefix) &&
            (identical(other.serverID, serverID) ||
                other.serverID == serverID) &&
            (identical(other.tcp_punch_port, tcp_punch_port) ||
                other.tcp_punch_port == tcp_punch_port) &&
            (identical(other.udp_punch_port, udp_punch_port) ||
                other.udp_punch_port == udp_punch_port));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ddns,
      ds_state,
      external,
      fqdn,
      gateway,
      const DeepCollectionEquality().hash(_interface),
      const DeepCollectionEquality().hash(_ipv6_tunnel),
      is_bsm,
      pingpong_path,
      redirect_prefix,
      serverID,
      tcp_punch_port,
      udp_punch_port);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerImplCopyWith<_$ServerImpl> get copyWith =>
      __$$ServerImplCopyWithImpl<_$ServerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerImplToJson(
      this,
    );
  }
}

abstract class _Server implements Server {
  const factory _Server(
      {required final String? ddns,
      required final String? ds_state,
      required final External? external,
      required final String? fqdn,
      required final String? gateway,
      required final List<Interface>? interface,
      required final List<dynamic>? ipv6_tunnel,
      required final bool? is_bsm,
      required final String? pingpong_path,
      required final String? redirect_prefix,
      required final String? serverID,
      required final int? tcp_punch_port,
      required final int? udp_punch_port}) = _$ServerImpl;

  factory _Server.fromJson(Map<String, dynamic> json) = _$ServerImpl.fromJson;

  @override
  String? get ddns;
  @override
  String? get ds_state;
  @override
  External? get external;
  @override
  String? get fqdn;
  @override
  String? get gateway;
  @override
  List<Interface>? get interface;
  @override
  List<dynamic>? get ipv6_tunnel;
  @override
  bool? get is_bsm;
  @override
  String? get pingpong_path;
  @override
  String? get redirect_prefix;
  @override
  String? get serverID;
  @override
  int? get tcp_punch_port;
  @override
  int? get udp_punch_port;
  @override
  @JsonKey(ignore: true)
  _$$ServerImplCopyWith<_$ServerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

External _$ExternalFromJson(Map<String, dynamic> json) {
  return _External.fromJson(json);
}

/// @nodoc
mixin _$External {
  String? get ip => throw _privateConstructorUsedError;
  String? get ipv6 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExternalCopyWith<External> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalCopyWith<$Res> {
  factory $ExternalCopyWith(External value, $Res Function(External) then) =
      _$ExternalCopyWithImpl<$Res, External>;
  @useResult
  $Res call({String? ip, String? ipv6});
}

/// @nodoc
class _$ExternalCopyWithImpl<$Res, $Val extends External>
    implements $ExternalCopyWith<$Res> {
  _$ExternalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = freezed,
    Object? ipv6 = freezed,
  }) {
    return _then(_value.copyWith(
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      ipv6: freezed == ipv6
          ? _value.ipv6
          : ipv6 // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExternalImplCopyWith<$Res>
    implements $ExternalCopyWith<$Res> {
  factory _$$ExternalImplCopyWith(
          _$ExternalImpl value, $Res Function(_$ExternalImpl) then) =
      __$$ExternalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? ip, String? ipv6});
}

/// @nodoc
class __$$ExternalImplCopyWithImpl<$Res>
    extends _$ExternalCopyWithImpl<$Res, _$ExternalImpl>
    implements _$$ExternalImplCopyWith<$Res> {
  __$$ExternalImplCopyWithImpl(
      _$ExternalImpl _value, $Res Function(_$ExternalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = freezed,
    Object? ipv6 = freezed,
  }) {
    return _then(_$ExternalImpl(
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      ipv6: freezed == ipv6
          ? _value.ipv6
          : ipv6 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExternalImpl implements _External {
  const _$ExternalImpl({required this.ip, required this.ipv6});

  factory _$ExternalImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExternalImplFromJson(json);

  @override
  final String? ip;
  @override
  final String? ipv6;

  @override
  String toString() {
    return 'External(ip: $ip, ipv6: $ipv6)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.ipv6, ipv6) || other.ipv6 == ipv6));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ip, ipv6);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalImplCopyWith<_$ExternalImpl> get copyWith =>
      __$$ExternalImplCopyWithImpl<_$ExternalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExternalImplToJson(
      this,
    );
  }
}

abstract class _External implements External {
  const factory _External(
      {required final String? ip,
      required final String? ipv6}) = _$ExternalImpl;

  factory _External.fromJson(Map<String, dynamic> json) =
      _$ExternalImpl.fromJson;

  @override
  String? get ip;
  @override
  String? get ipv6;
  @override
  @JsonKey(ignore: true)
  _$$ExternalImplCopyWith<_$ExternalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Interface _$InterfaceFromJson(Map<String, dynamic> json) {
  return _Interface.fromJson(json);
}

/// @nodoc
mixin _$Interface {
  String? get ip => throw _privateConstructorUsedError;
  List<dynamic>? get ipv6 => throw _privateConstructorUsedError;
  String? get mask => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InterfaceCopyWith<Interface> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterfaceCopyWith<$Res> {
  factory $InterfaceCopyWith(Interface value, $Res Function(Interface) then) =
      _$InterfaceCopyWithImpl<$Res, Interface>;
  @useResult
  $Res call({String? ip, List<dynamic>? ipv6, String? mask, String? name});
}

/// @nodoc
class _$InterfaceCopyWithImpl<$Res, $Val extends Interface>
    implements $InterfaceCopyWith<$Res> {
  _$InterfaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = freezed,
    Object? ipv6 = freezed,
    Object? mask = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      ipv6: freezed == ipv6
          ? _value.ipv6
          : ipv6 // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      mask: freezed == mask
          ? _value.mask
          : mask // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterfaceImplCopyWith<$Res>
    implements $InterfaceCopyWith<$Res> {
  factory _$$InterfaceImplCopyWith(
          _$InterfaceImpl value, $Res Function(_$InterfaceImpl) then) =
      __$$InterfaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? ip, List<dynamic>? ipv6, String? mask, String? name});
}

/// @nodoc
class __$$InterfaceImplCopyWithImpl<$Res>
    extends _$InterfaceCopyWithImpl<$Res, _$InterfaceImpl>
    implements _$$InterfaceImplCopyWith<$Res> {
  __$$InterfaceImplCopyWithImpl(
      _$InterfaceImpl _value, $Res Function(_$InterfaceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = freezed,
    Object? ipv6 = freezed,
    Object? mask = freezed,
    Object? name = freezed,
  }) {
    return _then(_$InterfaceImpl(
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      ipv6: freezed == ipv6
          ? _value._ipv6
          : ipv6 // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      mask: freezed == mask
          ? _value.mask
          : mask // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InterfaceImpl implements _Interface {
  const _$InterfaceImpl(
      {required this.ip,
      required final List<dynamic>? ipv6,
      required this.mask,
      required this.name})
      : _ipv6 = ipv6;

  factory _$InterfaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterfaceImplFromJson(json);

  @override
  final String? ip;
  final List<dynamic>? _ipv6;
  @override
  List<dynamic>? get ipv6 {
    final value = _ipv6;
    if (value == null) return null;
    if (_ipv6 is EqualUnmodifiableListView) return _ipv6;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? mask;
  @override
  final String? name;

  @override
  String toString() {
    return 'Interface(ip: $ip, ipv6: $ipv6, mask: $mask, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterfaceImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            const DeepCollectionEquality().equals(other._ipv6, _ipv6) &&
            (identical(other.mask, mask) || other.mask == mask) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, ip, const DeepCollectionEquality().hash(_ipv6), mask, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InterfaceImplCopyWith<_$InterfaceImpl> get copyWith =>
      __$$InterfaceImplCopyWithImpl<_$InterfaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterfaceImplToJson(
      this,
    );
  }
}

abstract class _Interface implements Interface {
  const factory _Interface(
      {required final String? ip,
      required final List<dynamic>? ipv6,
      required final String? mask,
      required final String? name}) = _$InterfaceImpl;

  factory _Interface.fromJson(Map<String, dynamic> json) =
      _$InterfaceImpl.fromJson;

  @override
  String? get ip;
  @override
  List<dynamic>? get ipv6;
  @override
  String? get mask;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$InterfaceImplCopyWith<_$InterfaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return _Service.fromJson(json);
}

/// @nodoc
mixin _$Service {
  int? get port => throw _privateConstructorUsedError;
  int? get ext_port => throw _privateConstructorUsedError;
  String? get pingpong => throw _privateConstructorUsedError;
  List<dynamic>? get pingpong_desc => throw _privateConstructorUsedError;
  String? get relay_ip => throw _privateConstructorUsedError;
  String? get relay_dn => throw _privateConstructorUsedError;
  int? get relay_port => throw _privateConstructorUsedError;
  String? get vpn_ip => throw _privateConstructorUsedError;
  String? get https_ip => throw _privateConstructorUsedError;
  int? get https_port => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceCopyWith<Service> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceCopyWith<$Res> {
  factory $ServiceCopyWith(Service value, $Res Function(Service) then) =
      _$ServiceCopyWithImpl<$Res, Service>;
  @useResult
  $Res call(
      {int? port,
      int? ext_port,
      String? pingpong,
      List<dynamic>? pingpong_desc,
      String? relay_ip,
      String? relay_dn,
      int? relay_port,
      String? vpn_ip,
      String? https_ip,
      int? https_port});
}

/// @nodoc
class _$ServiceCopyWithImpl<$Res, $Val extends Service>
    implements $ServiceCopyWith<$Res> {
  _$ServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? port = freezed,
    Object? ext_port = freezed,
    Object? pingpong = freezed,
    Object? pingpong_desc = freezed,
    Object? relay_ip = freezed,
    Object? relay_dn = freezed,
    Object? relay_port = freezed,
    Object? vpn_ip = freezed,
    Object? https_ip = freezed,
    Object? https_port = freezed,
  }) {
    return _then(_value.copyWith(
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      ext_port: freezed == ext_port
          ? _value.ext_port
          : ext_port // ignore: cast_nullable_to_non_nullable
              as int?,
      pingpong: freezed == pingpong
          ? _value.pingpong
          : pingpong // ignore: cast_nullable_to_non_nullable
              as String?,
      pingpong_desc: freezed == pingpong_desc
          ? _value.pingpong_desc
          : pingpong_desc // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      relay_ip: freezed == relay_ip
          ? _value.relay_ip
          : relay_ip // ignore: cast_nullable_to_non_nullable
              as String?,
      relay_dn: freezed == relay_dn
          ? _value.relay_dn
          : relay_dn // ignore: cast_nullable_to_non_nullable
              as String?,
      relay_port: freezed == relay_port
          ? _value.relay_port
          : relay_port // ignore: cast_nullable_to_non_nullable
              as int?,
      vpn_ip: freezed == vpn_ip
          ? _value.vpn_ip
          : vpn_ip // ignore: cast_nullable_to_non_nullable
              as String?,
      https_ip: freezed == https_ip
          ? _value.https_ip
          : https_ip // ignore: cast_nullable_to_non_nullable
              as String?,
      https_port: freezed == https_port
          ? _value.https_port
          : https_port // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceImplCopyWith<$Res> implements $ServiceCopyWith<$Res> {
  factory _$$ServiceImplCopyWith(
          _$ServiceImpl value, $Res Function(_$ServiceImpl) then) =
      __$$ServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? port,
      int? ext_port,
      String? pingpong,
      List<dynamic>? pingpong_desc,
      String? relay_ip,
      String? relay_dn,
      int? relay_port,
      String? vpn_ip,
      String? https_ip,
      int? https_port});
}

/// @nodoc
class __$$ServiceImplCopyWithImpl<$Res>
    extends _$ServiceCopyWithImpl<$Res, _$ServiceImpl>
    implements _$$ServiceImplCopyWith<$Res> {
  __$$ServiceImplCopyWithImpl(
      _$ServiceImpl _value, $Res Function(_$ServiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? port = freezed,
    Object? ext_port = freezed,
    Object? pingpong = freezed,
    Object? pingpong_desc = freezed,
    Object? relay_ip = freezed,
    Object? relay_dn = freezed,
    Object? relay_port = freezed,
    Object? vpn_ip = freezed,
    Object? https_ip = freezed,
    Object? https_port = freezed,
  }) {
    return _then(_$ServiceImpl(
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      ext_port: freezed == ext_port
          ? _value.ext_port
          : ext_port // ignore: cast_nullable_to_non_nullable
              as int?,
      pingpong: freezed == pingpong
          ? _value.pingpong
          : pingpong // ignore: cast_nullable_to_non_nullable
              as String?,
      pingpong_desc: freezed == pingpong_desc
          ? _value._pingpong_desc
          : pingpong_desc // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      relay_ip: freezed == relay_ip
          ? _value.relay_ip
          : relay_ip // ignore: cast_nullable_to_non_nullable
              as String?,
      relay_dn: freezed == relay_dn
          ? _value.relay_dn
          : relay_dn // ignore: cast_nullable_to_non_nullable
              as String?,
      relay_port: freezed == relay_port
          ? _value.relay_port
          : relay_port // ignore: cast_nullable_to_non_nullable
              as int?,
      vpn_ip: freezed == vpn_ip
          ? _value.vpn_ip
          : vpn_ip // ignore: cast_nullable_to_non_nullable
              as String?,
      https_ip: freezed == https_ip
          ? _value.https_ip
          : https_ip // ignore: cast_nullable_to_non_nullable
              as String?,
      https_port: freezed == https_port
          ? _value.https_port
          : https_port // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceImpl implements _Service {
  const _$ServiceImpl(
      {required this.port,
      required this.ext_port,
      required this.pingpong,
      required final List<dynamic>? pingpong_desc,
      required this.relay_ip,
      required this.relay_dn,
      required this.relay_port,
      required this.vpn_ip,
      required this.https_ip,
      required this.https_port})
      : _pingpong_desc = pingpong_desc;

  factory _$ServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceImplFromJson(json);

  @override
  final int? port;
  @override
  final int? ext_port;
  @override
  final String? pingpong;
  final List<dynamic>? _pingpong_desc;
  @override
  List<dynamic>? get pingpong_desc {
    final value = _pingpong_desc;
    if (value == null) return null;
    if (_pingpong_desc is EqualUnmodifiableListView) return _pingpong_desc;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? relay_ip;
  @override
  final String? relay_dn;
  @override
  final int? relay_port;
  @override
  final String? vpn_ip;
  @override
  final String? https_ip;
  @override
  final int? https_port;

  @override
  String toString() {
    return 'Service(port: $port, ext_port: $ext_port, pingpong: $pingpong, pingpong_desc: $pingpong_desc, relay_ip: $relay_ip, relay_dn: $relay_dn, relay_port: $relay_port, vpn_ip: $vpn_ip, https_ip: $https_ip, https_port: $https_port)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceImpl &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.ext_port, ext_port) ||
                other.ext_port == ext_port) &&
            (identical(other.pingpong, pingpong) ||
                other.pingpong == pingpong) &&
            const DeepCollectionEquality()
                .equals(other._pingpong_desc, _pingpong_desc) &&
            (identical(other.relay_ip, relay_ip) ||
                other.relay_ip == relay_ip) &&
            (identical(other.relay_dn, relay_dn) ||
                other.relay_dn == relay_dn) &&
            (identical(other.relay_port, relay_port) ||
                other.relay_port == relay_port) &&
            (identical(other.vpn_ip, vpn_ip) || other.vpn_ip == vpn_ip) &&
            (identical(other.https_ip, https_ip) ||
                other.https_ip == https_ip) &&
            (identical(other.https_port, https_port) ||
                other.https_port == https_port));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      port,
      ext_port,
      pingpong,
      const DeepCollectionEquality().hash(_pingpong_desc),
      relay_ip,
      relay_dn,
      relay_port,
      vpn_ip,
      https_ip,
      https_port);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceImplCopyWith<_$ServiceImpl> get copyWith =>
      __$$ServiceImplCopyWithImpl<_$ServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceImplToJson(
      this,
    );
  }
}

abstract class _Service implements Service {
  const factory _Service(
      {required final int? port,
      required final int? ext_port,
      required final String? pingpong,
      required final List<dynamic>? pingpong_desc,
      required final String? relay_ip,
      required final String? relay_dn,
      required final int? relay_port,
      required final String? vpn_ip,
      required final String? https_ip,
      required final int? https_port}) = _$ServiceImpl;

  factory _Service.fromJson(Map<String, dynamic> json) = _$ServiceImpl.fromJson;

  @override
  int? get port;
  @override
  int? get ext_port;
  @override
  String? get pingpong;
  @override
  List<dynamic>? get pingpong_desc;
  @override
  String? get relay_ip;
  @override
  String? get relay_dn;
  @override
  int? get relay_port;
  @override
  String? get vpn_ip;
  @override
  String? get https_ip;
  @override
  int? get https_port;
  @override
  @JsonKey(ignore: true)
  _$$ServiceImplCopyWith<_$ServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmartDns _$SmartDnsFromJson(Map<String, dynamic> json) {
  return _SmartDns.fromJson(json);
}

/// @nodoc
mixin _$SmartDns {
  String? get host => throw _privateConstructorUsedError;
  List<String>? get lan => throw _privateConstructorUsedError;
  String? get hole_punch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmartDnsCopyWith<SmartDns> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartDnsCopyWith<$Res> {
  factory $SmartDnsCopyWith(SmartDns value, $Res Function(SmartDns) then) =
      _$SmartDnsCopyWithImpl<$Res, SmartDns>;
  @useResult
  $Res call({String? host, List<String>? lan, String? hole_punch});
}

/// @nodoc
class _$SmartDnsCopyWithImpl<$Res, $Val extends SmartDns>
    implements $SmartDnsCopyWith<$Res> {
  _$SmartDnsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = freezed,
    Object? lan = freezed,
    Object? hole_punch = freezed,
  }) {
    return _then(_value.copyWith(
      host: freezed == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      lan: freezed == lan
          ? _value.lan
          : lan // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      hole_punch: freezed == hole_punch
          ? _value.hole_punch
          : hole_punch // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmartDnsImplCopyWith<$Res>
    implements $SmartDnsCopyWith<$Res> {
  factory _$$SmartDnsImplCopyWith(
          _$SmartDnsImpl value, $Res Function(_$SmartDnsImpl) then) =
      __$$SmartDnsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? host, List<String>? lan, String? hole_punch});
}

/// @nodoc
class __$$SmartDnsImplCopyWithImpl<$Res>
    extends _$SmartDnsCopyWithImpl<$Res, _$SmartDnsImpl>
    implements _$$SmartDnsImplCopyWith<$Res> {
  __$$SmartDnsImplCopyWithImpl(
      _$SmartDnsImpl _value, $Res Function(_$SmartDnsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = freezed,
    Object? lan = freezed,
    Object? hole_punch = freezed,
  }) {
    return _then(_$SmartDnsImpl(
      host: freezed == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      lan: freezed == lan
          ? _value._lan
          : lan // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      hole_punch: freezed == hole_punch
          ? _value.hole_punch
          : hole_punch // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmartDnsImpl implements _SmartDns {
  const _$SmartDnsImpl(
      {required this.host,
      required final List<String>? lan,
      required this.hole_punch})
      : _lan = lan;

  factory _$SmartDnsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmartDnsImplFromJson(json);

  @override
  final String? host;
  final List<String>? _lan;
  @override
  List<String>? get lan {
    final value = _lan;
    if (value == null) return null;
    if (_lan is EqualUnmodifiableListView) return _lan;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? hole_punch;

  @override
  String toString() {
    return 'SmartDns(host: $host, lan: $lan, hole_punch: $hole_punch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartDnsImpl &&
            (identical(other.host, host) || other.host == host) &&
            const DeepCollectionEquality().equals(other._lan, _lan) &&
            (identical(other.hole_punch, hole_punch) ||
                other.hole_punch == hole_punch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, host, const DeepCollectionEquality().hash(_lan), hole_punch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartDnsImplCopyWith<_$SmartDnsImpl> get copyWith =>
      __$$SmartDnsImplCopyWithImpl<_$SmartDnsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmartDnsImplToJson(
      this,
    );
  }
}

abstract class _SmartDns implements SmartDns {
  const factory _SmartDns(
      {required final String? host,
      required final List<String>? lan,
      required final String? hole_punch}) = _$SmartDnsImpl;

  factory _SmartDns.fromJson(Map<String, dynamic> json) =
      _$SmartDnsImpl.fromJson;

  @override
  String? get host;
  @override
  List<String>? get lan;
  @override
  String? get hole_punch;
  @override
  @JsonKey(ignore: true)
  _$$SmartDnsImplCopyWith<_$SmartDnsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
