// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_server_info_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetServerInfoRequest _$GetServerInfoRequestFromJson(Map<String, dynamic> json) {
  return _QuickConnectRequest.fromJson(json);
}

/// @nodoc
mixin _$GetServerInfoRequest {
  String get id => throw _privateConstructorUsedError;
  String get serverID => throw _privateConstructorUsedError;
  String get command => throw _privateConstructorUsedError;

  /// Serializes this GetServerInfoRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetServerInfoRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetServerInfoRequestCopyWith<GetServerInfoRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetServerInfoRequestCopyWith<$Res> {
  factory $GetServerInfoRequestCopyWith(GetServerInfoRequest value,
          $Res Function(GetServerInfoRequest) then) =
      _$GetServerInfoRequestCopyWithImpl<$Res, GetServerInfoRequest>;
  @useResult
  $Res call({String id, String serverID, String command});
}

/// @nodoc
class _$GetServerInfoRequestCopyWithImpl<$Res,
        $Val extends GetServerInfoRequest>
    implements $GetServerInfoRequestCopyWith<$Res> {
  _$GetServerInfoRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetServerInfoRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serverID = null,
    Object? command = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serverID: null == serverID
          ? _value.serverID
          : serverID // ignore: cast_nullable_to_non_nullable
              as String,
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickConnectRequestImplCopyWith<$Res>
    implements $GetServerInfoRequestCopyWith<$Res> {
  factory _$$QuickConnectRequestImplCopyWith(_$QuickConnectRequestImpl value,
          $Res Function(_$QuickConnectRequestImpl) then) =
      __$$QuickConnectRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String serverID, String command});
}

/// @nodoc
class __$$QuickConnectRequestImplCopyWithImpl<$Res>
    extends _$GetServerInfoRequestCopyWithImpl<$Res, _$QuickConnectRequestImpl>
    implements _$$QuickConnectRequestImplCopyWith<$Res> {
  __$$QuickConnectRequestImplCopyWithImpl(_$QuickConnectRequestImpl _value,
      $Res Function(_$QuickConnectRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetServerInfoRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serverID = null,
    Object? command = null,
  }) {
    return _then(_$QuickConnectRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serverID: null == serverID
          ? _value.serverID
          : serverID // ignore: cast_nullable_to_non_nullable
              as String,
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickConnectRequestImpl implements _QuickConnectRequest {
  const _$QuickConnectRequestImpl(
      {required this.id, required this.serverID, required this.command});

  factory _$QuickConnectRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickConnectRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String serverID;
  @override
  final String command;

  @override
  String toString() {
    return 'GetServerInfoRequest(id: $id, serverID: $serverID, command: $command)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickConnectRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serverID, serverID) ||
                other.serverID == serverID) &&
            (identical(other.command, command) || other.command == command));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, serverID, command);

  /// Create a copy of GetServerInfoRequest
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

abstract class _QuickConnectRequest implements GetServerInfoRequest {
  const factory _QuickConnectRequest(
      {required final String id,
      required final String serverID,
      required final String command}) = _$QuickConnectRequestImpl;

  factory _QuickConnectRequest.fromJson(Map<String, dynamic> json) =
      _$QuickConnectRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get serverID;
  @override
  String get command;

  /// Create a copy of GetServerInfoRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickConnectRequestImplCopyWith<_$QuickConnectRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
