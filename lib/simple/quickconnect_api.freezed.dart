// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quickconnect_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuickConnectRequest _$QuickConnectRequestFromJson(Map<String, dynamic> json) {
  return _QuickConnectRequest.fromJson(json);
}

/// @nodoc
mixin _$QuickConnectRequest {
  @JsonKey(name: 'get_ca_fingerprints')
  bool get getCaFingerprints => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'serverID')
  String get serverId => throw _privateConstructorUsedError;
  String get command => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;

  /// Serializes this QuickConnectRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickConnectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickConnectRequestCopyWith<QuickConnectRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickConnectRequestCopyWith<$Res> {
  factory $QuickConnectRequestCopyWith(
          QuickConnectRequest value, $Res Function(QuickConnectRequest) then) =
      _$QuickConnectRequestCopyWithImpl<$Res, QuickConnectRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'get_ca_fingerprints') bool getCaFingerprints,
      String id,
      @JsonKey(name: 'serverID') String serverId,
      String command,
      String version});
}

/// @nodoc
class _$QuickConnectRequestCopyWithImpl<$Res, $Val extends QuickConnectRequest>
    implements $QuickConnectRequestCopyWith<$Res> {
  _$QuickConnectRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickConnectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? getCaFingerprints = null,
    Object? id = null,
    Object? serverId = null,
    Object? command = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      getCaFingerprints: null == getCaFingerprints
          ? _value.getCaFingerprints
          : getCaFingerprints // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickConnectRequestImplCopyWith<$Res>
    implements $QuickConnectRequestCopyWith<$Res> {
  factory _$$QuickConnectRequestImplCopyWith(_$QuickConnectRequestImpl value,
          $Res Function(_$QuickConnectRequestImpl) then) =
      __$$QuickConnectRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'get_ca_fingerprints') bool getCaFingerprints,
      String id,
      @JsonKey(name: 'serverID') String serverId,
      String command,
      String version});
}

/// @nodoc
class __$$QuickConnectRequestImplCopyWithImpl<$Res>
    extends _$QuickConnectRequestCopyWithImpl<$Res, _$QuickConnectRequestImpl>
    implements _$$QuickConnectRequestImplCopyWith<$Res> {
  __$$QuickConnectRequestImplCopyWithImpl(_$QuickConnectRequestImpl _value,
      $Res Function(_$QuickConnectRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuickConnectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? getCaFingerprints = null,
    Object? id = null,
    Object? serverId = null,
    Object? command = null,
    Object? version = null,
  }) {
    return _then(_$QuickConnectRequestImpl(
      getCaFingerprints: null == getCaFingerprints
          ? _value.getCaFingerprints
          : getCaFingerprints // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String,
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickConnectRequestImpl implements _QuickConnectRequest {
  const _$QuickConnectRequestImpl(
      {@JsonKey(name: 'get_ca_fingerprints') required this.getCaFingerprints,
      required this.id,
      @JsonKey(name: 'serverID') required this.serverId,
      required this.command,
      required this.version});

  factory _$QuickConnectRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickConnectRequestImplFromJson(json);

  @override
  @JsonKey(name: 'get_ca_fingerprints')
  final bool getCaFingerprints;
  @override
  final String id;
  @override
  @JsonKey(name: 'serverID')
  final String serverId;
  @override
  final String command;
  @override
  final String version;

  @override
  String toString() {
    return 'QuickConnectRequest(getCaFingerprints: $getCaFingerprints, id: $id, serverId: $serverId, command: $command, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickConnectRequestImpl &&
            (identical(other.getCaFingerprints, getCaFingerprints) ||
                other.getCaFingerprints == getCaFingerprints) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.command, command) || other.command == command) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, getCaFingerprints, id, serverId, command, version);

  /// Create a copy of QuickConnectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickConnectRequestImplCopyWith<_$QuickConnectRequestImpl> get copyWith =>
      __$$QuickConnectRequestImplCopyWithImpl<_$QuickConnectRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickConnectRequestImplToJson(
      this,
    );
  }
}

abstract class _QuickConnectRequest implements QuickConnectRequest {
  const factory _QuickConnectRequest(
      {@JsonKey(name: 'get_ca_fingerprints')
      required final bool getCaFingerprints,
      required final String id,
      @JsonKey(name: 'serverID') required final String serverId,
      required final String command,
      required final String version}) = _$QuickConnectRequestImpl;

  factory _QuickConnectRequest.fromJson(Map<String, dynamic> json) =
      _$QuickConnectRequestImpl.fromJson;

  @override
  @JsonKey(name: 'get_ca_fingerprints')
  bool get getCaFingerprints;
  @override
  String get id;
  @override
  @JsonKey(name: 'serverID')
  String get serverId;
  @override
  String get command;
  @override
  String get version;

  /// Create a copy of QuickConnectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickConnectRequestImplCopyWith<_$QuickConnectRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuickConnectResponse _$QuickConnectResponseFromJson(Map<String, dynamic> json) {
  return _QuickConnectResponse.fromJson(json);
}

/// @nodoc
mixin _$QuickConnectResponse {
  String get command => throw _privateConstructorUsedError;
  String get errinfo => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toString)
  String get errno => throw _privateConstructorUsedError;
  List<String> get sites => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toString)
  String get suberrno => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toString)
  String get version => throw _privateConstructorUsedError;

  /// Serializes this QuickConnectResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickConnectResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickConnectResponseCopyWith<QuickConnectResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickConnectResponseCopyWith<$Res> {
  factory $QuickConnectResponseCopyWith(QuickConnectResponse value,
          $Res Function(QuickConnectResponse) then) =
      _$QuickConnectResponseCopyWithImpl<$Res, QuickConnectResponse>;
  @useResult
  $Res call(
      {String command,
      String errinfo,
      @JsonKey(fromJson: _toString) String errno,
      List<String> sites,
      @JsonKey(fromJson: _toString) String suberrno,
      @JsonKey(fromJson: _toString) String version});
}

/// @nodoc
class _$QuickConnectResponseCopyWithImpl<$Res,
        $Val extends QuickConnectResponse>
    implements $QuickConnectResponseCopyWith<$Res> {
  _$QuickConnectResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickConnectResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? errinfo = null,
    Object? errno = null,
    Object? sites = null,
    Object? suberrno = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      errinfo: null == errinfo
          ? _value.errinfo
          : errinfo // ignore: cast_nullable_to_non_nullable
              as String,
      errno: null == errno
          ? _value.errno
          : errno // ignore: cast_nullable_to_non_nullable
              as String,
      sites: null == sites
          ? _value.sites
          : sites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      suberrno: null == suberrno
          ? _value.suberrno
          : suberrno // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickConnectResponseImplCopyWith<$Res>
    implements $QuickConnectResponseCopyWith<$Res> {
  factory _$$QuickConnectResponseImplCopyWith(_$QuickConnectResponseImpl value,
          $Res Function(_$QuickConnectResponseImpl) then) =
      __$$QuickConnectResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String command,
      String errinfo,
      @JsonKey(fromJson: _toString) String errno,
      List<String> sites,
      @JsonKey(fromJson: _toString) String suberrno,
      @JsonKey(fromJson: _toString) String version});
}

/// @nodoc
class __$$QuickConnectResponseImplCopyWithImpl<$Res>
    extends _$QuickConnectResponseCopyWithImpl<$Res, _$QuickConnectResponseImpl>
    implements _$$QuickConnectResponseImplCopyWith<$Res> {
  __$$QuickConnectResponseImplCopyWithImpl(_$QuickConnectResponseImpl _value,
      $Res Function(_$QuickConnectResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuickConnectResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
    Object? errinfo = null,
    Object? errno = null,
    Object? sites = null,
    Object? suberrno = null,
    Object? version = null,
  }) {
    return _then(_$QuickConnectResponseImpl(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
      errinfo: null == errinfo
          ? _value.errinfo
          : errinfo // ignore: cast_nullable_to_non_nullable
              as String,
      errno: null == errno
          ? _value.errno
          : errno // ignore: cast_nullable_to_non_nullable
              as String,
      sites: null == sites
          ? _value._sites
          : sites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      suberrno: null == suberrno
          ? _value.suberrno
          : suberrno // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickConnectResponseImpl implements _QuickConnectResponse {
  const _$QuickConnectResponseImpl(
      {required this.command,
      required this.errinfo,
      @JsonKey(fromJson: _toString) required this.errno,
      required final List<String> sites,
      @JsonKey(fromJson: _toString) required this.suberrno,
      @JsonKey(fromJson: _toString) required this.version})
      : _sites = sites;

  factory _$QuickConnectResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickConnectResponseImplFromJson(json);

  @override
  final String command;
  @override
  final String errinfo;
  @override
  @JsonKey(fromJson: _toString)
  final String errno;
  final List<String> _sites;
  @override
  List<String> get sites {
    if (_sites is EqualUnmodifiableListView) return _sites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sites);
  }

  @override
  @JsonKey(fromJson: _toString)
  final String suberrno;
  @override
  @JsonKey(fromJson: _toString)
  final String version;

  @override
  String toString() {
    return 'QuickConnectResponse(command: $command, errinfo: $errinfo, errno: $errno, sites: $sites, suberrno: $suberrno, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickConnectResponseImpl &&
            (identical(other.command, command) || other.command == command) &&
            (identical(other.errinfo, errinfo) || other.errinfo == errinfo) &&
            (identical(other.errno, errno) || other.errno == errno) &&
            const DeepCollectionEquality().equals(other._sites, _sites) &&
            (identical(other.suberrno, suberrno) ||
                other.suberrno == suberrno) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, command, errinfo, errno,
      const DeepCollectionEquality().hash(_sites), suberrno, version);

  /// Create a copy of QuickConnectResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickConnectResponseImplCopyWith<_$QuickConnectResponseImpl>
      get copyWith =>
          __$$QuickConnectResponseImplCopyWithImpl<_$QuickConnectResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickConnectResponseImplToJson(
      this,
    );
  }
}

abstract class _QuickConnectResponse implements QuickConnectResponse {
  const factory _QuickConnectResponse(
          {required final String command,
          required final String errinfo,
          @JsonKey(fromJson: _toString) required final String errno,
          required final List<String> sites,
          @JsonKey(fromJson: _toString) required final String suberrno,
          @JsonKey(fromJson: _toString) required final String version}) =
      _$QuickConnectResponseImpl;

  factory _QuickConnectResponse.fromJson(Map<String, dynamic> json) =
      _$QuickConnectResponseImpl.fromJson;

  @override
  String get command;
  @override
  String get errinfo;
  @override
  @JsonKey(fromJson: _toString)
  String get errno;
  @override
  List<String> get sites;
  @override
  @JsonKey(fromJson: _toString)
  String get suberrno;
  @override
  @JsonKey(fromJson: _toString)
  String get version;

  /// Create a copy of QuickConnectResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickConnectResponseImplCopyWith<_$QuickConnectResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
