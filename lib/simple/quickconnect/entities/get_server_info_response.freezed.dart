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
  String get command => throw _privateConstructorUsedError;
  String get errinfo => throw _privateConstructorUsedError;
  int get errno => throw _privateConstructorUsedError;
  List<String> get sites => throw _privateConstructorUsedError;
  int get suberrno => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  /// Serializes this GetServerInfoResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {String command,
      String errinfo,
      int errno,
      List<String> sites,
      int suberrno,
      int version});
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

  /// Create a copy of GetServerInfoResponse
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
              as int,
      sites: null == sites
          ? _value.sites
          : sites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      suberrno: null == suberrno
          ? _value.suberrno
          : suberrno // ignore: cast_nullable_to_non_nullable
              as int,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
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
      {String command,
      String errinfo,
      int errno,
      List<String> sites,
      int suberrno,
      int version});
}

/// @nodoc
class __$$GetServerInfoResponseImplCopyWithImpl<$Res>
    extends _$GetServerInfoResponseCopyWithImpl<$Res,
        _$GetServerInfoResponseImpl>
    implements _$$GetServerInfoResponseImplCopyWith<$Res> {
  __$$GetServerInfoResponseImplCopyWithImpl(_$GetServerInfoResponseImpl _value,
      $Res Function(_$GetServerInfoResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetServerInfoResponse
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
    return _then(_$GetServerInfoResponseImpl(
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
              as int,
      sites: null == sites
          ? _value._sites
          : sites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      suberrno: null == suberrno
          ? _value.suberrno
          : suberrno // ignore: cast_nullable_to_non_nullable
              as int,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetServerInfoResponseImpl implements _GetServerInfoResponse {
  const _$GetServerInfoResponseImpl(
      {required this.command,
      required this.errinfo,
      required this.errno,
      required final List<String> sites,
      required this.suberrno,
      required this.version})
      : _sites = sites;

  factory _$GetServerInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetServerInfoResponseImplFromJson(json);

  @override
  final String command;
  @override
  final String errinfo;
  @override
  final int errno;
  final List<String> _sites;
  @override
  List<String> get sites {
    if (_sites is EqualUnmodifiableListView) return _sites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sites);
  }

  @override
  final int suberrno;
  @override
  final int version;

  @override
  String toString() {
    return 'GetServerInfoResponse(command: $command, errinfo: $errinfo, errno: $errno, sites: $sites, suberrno: $suberrno, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetServerInfoResponseImpl &&
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

  /// Create a copy of GetServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {required final String command,
      required final String errinfo,
      required final int errno,
      required final List<String> sites,
      required final int suberrno,
      required final int version}) = _$GetServerInfoResponseImpl;

  factory _GetServerInfoResponse.fromJson(Map<String, dynamic> json) =
      _$GetServerInfoResponseImpl.fromJson;

  @override
  String get command;
  @override
  String get errinfo;
  @override
  int get errno;
  @override
  List<String> get sites;
  @override
  int get suberrno;
  @override
  int get version;

  /// Create a copy of GetServerInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetServerInfoResponseImplCopyWith<_$GetServerInfoResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
