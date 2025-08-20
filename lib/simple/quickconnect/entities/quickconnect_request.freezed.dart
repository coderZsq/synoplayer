// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quickconnect_request.dart';

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
