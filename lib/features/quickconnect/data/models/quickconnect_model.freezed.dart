// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quickconnect_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuickConnectServerInfoModel _$QuickConnectServerInfoModelFromJson(
    Map<String, dynamic> json) {
  return _QuickConnectServerInfoModel.fromJson(json);
}

/// @nodoc
mixin _$QuickConnectServerInfoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'external_domain')
  String get externalDomain => throw _privateConstructorUsedError;
  @JsonKey(name: 'internal_ip')
  String get internalIp => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_online')
  bool get isOnline => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;
  String? get protocol => throw _privateConstructorUsedError;

  /// Serializes this QuickConnectServerInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickConnectServerInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickConnectServerInfoModelCopyWith<QuickConnectServerInfoModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickConnectServerInfoModelCopyWith<$Res> {
  factory $QuickConnectServerInfoModelCopyWith(
          QuickConnectServerInfoModel value,
          $Res Function(QuickConnectServerInfoModel) then) =
      _$QuickConnectServerInfoModelCopyWithImpl<$Res,
          QuickConnectServerInfoModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'external_domain') String externalDomain,
      @JsonKey(name: 'internal_ip') String internalIp,
      @JsonKey(name: 'is_online') bool isOnline,
      int? port,
      String? protocol});
}

/// @nodoc
class _$QuickConnectServerInfoModelCopyWithImpl<$Res,
        $Val extends QuickConnectServerInfoModel>
    implements $QuickConnectServerInfoModelCopyWith<$Res> {
  _$QuickConnectServerInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickConnectServerInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? externalDomain = null,
    Object? internalIp = null,
    Object? isOnline = null,
    Object? port = freezed,
    Object? protocol = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      externalDomain: null == externalDomain
          ? _value.externalDomain
          : externalDomain // ignore: cast_nullable_to_non_nullable
              as String,
      internalIp: null == internalIp
          ? _value.internalIp
          : internalIp // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickConnectServerInfoModelImplCopyWith<$Res>
    implements $QuickConnectServerInfoModelCopyWith<$Res> {
  factory _$$QuickConnectServerInfoModelImplCopyWith(
          _$QuickConnectServerInfoModelImpl value,
          $Res Function(_$QuickConnectServerInfoModelImpl) then) =
      __$$QuickConnectServerInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'external_domain') String externalDomain,
      @JsonKey(name: 'internal_ip') String internalIp,
      @JsonKey(name: 'is_online') bool isOnline,
      int? port,
      String? protocol});
}

/// @nodoc
class __$$QuickConnectServerInfoModelImplCopyWithImpl<$Res>
    extends _$QuickConnectServerInfoModelCopyWithImpl<$Res,
        _$QuickConnectServerInfoModelImpl>
    implements _$$QuickConnectServerInfoModelImplCopyWith<$Res> {
  __$$QuickConnectServerInfoModelImplCopyWithImpl(
      _$QuickConnectServerInfoModelImpl _value,
      $Res Function(_$QuickConnectServerInfoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuickConnectServerInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? externalDomain = null,
    Object? internalIp = null,
    Object? isOnline = null,
    Object? port = freezed,
    Object? protocol = freezed,
  }) {
    return _then(_$QuickConnectServerInfoModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      externalDomain: null == externalDomain
          ? _value.externalDomain
          : externalDomain // ignore: cast_nullable_to_non_nullable
              as String,
      internalIp: null == internalIp
          ? _value.internalIp
          : internalIp // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickConnectServerInfoModelImpl
    implements _QuickConnectServerInfoModel {
  const _$QuickConnectServerInfoModelImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'external_domain') required this.externalDomain,
      @JsonKey(name: 'internal_ip') required this.internalIp,
      @JsonKey(name: 'is_online') required this.isOnline,
      this.port,
      this.protocol});

  factory _$QuickConnectServerInfoModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$QuickConnectServerInfoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'external_domain')
  final String externalDomain;
  @override
  @JsonKey(name: 'internal_ip')
  final String internalIp;
  @override
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @override
  final int? port;
  @override
  final String? protocol;

  @override
  String toString() {
    return 'QuickConnectServerInfoModel(id: $id, name: $name, externalDomain: $externalDomain, internalIp: $internalIp, isOnline: $isOnline, port: $port, protocol: $protocol)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickConnectServerInfoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.externalDomain, externalDomain) ||
                other.externalDomain == externalDomain) &&
            (identical(other.internalIp, internalIp) ||
                other.internalIp == internalIp) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, externalDomain,
      internalIp, isOnline, port, protocol);

  /// Create a copy of QuickConnectServerInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickConnectServerInfoModelImplCopyWith<_$QuickConnectServerInfoModelImpl>
      get copyWith => __$$QuickConnectServerInfoModelImplCopyWithImpl<
          _$QuickConnectServerInfoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickConnectServerInfoModelImplToJson(
      this,
    );
  }
}

abstract class _QuickConnectServerInfoModel
    implements QuickConnectServerInfoModel {
  const factory _QuickConnectServerInfoModel(
      {required final String id,
      required final String name,
      @JsonKey(name: 'external_domain') required final String externalDomain,
      @JsonKey(name: 'internal_ip') required final String internalIp,
      @JsonKey(name: 'is_online') required final bool isOnline,
      final int? port,
      final String? protocol}) = _$QuickConnectServerInfoModelImpl;

  factory _QuickConnectServerInfoModel.fromJson(Map<String, dynamic> json) =
      _$QuickConnectServerInfoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'external_domain')
  String get externalDomain;
  @override
  @JsonKey(name: 'internal_ip')
  String get internalIp;
  @override
  @JsonKey(name: 'is_online')
  bool get isOnline;
  @override
  int? get port;
  @override
  String? get protocol;

  /// Create a copy of QuickConnectServerInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickConnectServerInfoModelImplCopyWith<_$QuickConnectServerInfoModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

QuickConnectLoginResultModel _$QuickConnectLoginResultModelFromJson(
    Map<String, dynamic> json) {
  return _QuickConnectLoginResultModel.fromJson(json);
}

/// @nodoc
mixin _$QuickConnectLoginResultModel {
  @JsonKey(name: 'is_success')
  bool get isSuccess => throw _privateConstructorUsedError;
  String? get sid => throw _privateConstructorUsedError;
  @JsonKey(name: 'error_message')
  String? get errorMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'redirect_url')
  String? get redirectUrl => throw _privateConstructorUsedError;

  /// Serializes this QuickConnectLoginResultModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickConnectLoginResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickConnectLoginResultModelCopyWith<QuickConnectLoginResultModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickConnectLoginResultModelCopyWith<$Res> {
  factory $QuickConnectLoginResultModelCopyWith(
          QuickConnectLoginResultModel value,
          $Res Function(QuickConnectLoginResultModel) then) =
      _$QuickConnectLoginResultModelCopyWithImpl<$Res,
          QuickConnectLoginResultModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'is_success') bool isSuccess,
      String? sid,
      @JsonKey(name: 'error_message') String? errorMessage,
      @JsonKey(name: 'redirect_url') String? redirectUrl});
}

/// @nodoc
class _$QuickConnectLoginResultModelCopyWithImpl<$Res,
        $Val extends QuickConnectLoginResultModel>
    implements $QuickConnectLoginResultModelCopyWith<$Res> {
  _$QuickConnectLoginResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickConnectLoginResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? sid = freezed,
    Object? errorMessage = freezed,
    Object? redirectUrl = freezed,
  }) {
    return _then(_value.copyWith(
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      sid: freezed == sid
          ? _value.sid
          : sid // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      redirectUrl: freezed == redirectUrl
          ? _value.redirectUrl
          : redirectUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickConnectLoginResultModelImplCopyWith<$Res>
    implements $QuickConnectLoginResultModelCopyWith<$Res> {
  factory _$$QuickConnectLoginResultModelImplCopyWith(
          _$QuickConnectLoginResultModelImpl value,
          $Res Function(_$QuickConnectLoginResultModelImpl) then) =
      __$$QuickConnectLoginResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'is_success') bool isSuccess,
      String? sid,
      @JsonKey(name: 'error_message') String? errorMessage,
      @JsonKey(name: 'redirect_url') String? redirectUrl});
}

/// @nodoc
class __$$QuickConnectLoginResultModelImplCopyWithImpl<$Res>
    extends _$QuickConnectLoginResultModelCopyWithImpl<$Res,
        _$QuickConnectLoginResultModelImpl>
    implements _$$QuickConnectLoginResultModelImplCopyWith<$Res> {
  __$$QuickConnectLoginResultModelImplCopyWithImpl(
      _$QuickConnectLoginResultModelImpl _value,
      $Res Function(_$QuickConnectLoginResultModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuickConnectLoginResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? sid = freezed,
    Object? errorMessage = freezed,
    Object? redirectUrl = freezed,
  }) {
    return _then(_$QuickConnectLoginResultModelImpl(
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      sid: freezed == sid
          ? _value.sid
          : sid // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      redirectUrl: freezed == redirectUrl
          ? _value.redirectUrl
          : redirectUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickConnectLoginResultModelImpl
    implements _QuickConnectLoginResultModel {
  const _$QuickConnectLoginResultModelImpl(
      {@JsonKey(name: 'is_success') required this.isSuccess,
      this.sid,
      @JsonKey(name: 'error_message') this.errorMessage,
      @JsonKey(name: 'redirect_url') this.redirectUrl});

  factory _$QuickConnectLoginResultModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$QuickConnectLoginResultModelImplFromJson(json);

  @override
  @JsonKey(name: 'is_success')
  final bool isSuccess;
  @override
  final String? sid;
  @override
  @JsonKey(name: 'error_message')
  final String? errorMessage;
  @override
  @JsonKey(name: 'redirect_url')
  final String? redirectUrl;

  @override
  String toString() {
    return 'QuickConnectLoginResultModel(isSuccess: $isSuccess, sid: $sid, errorMessage: $errorMessage, redirectUrl: $redirectUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickConnectLoginResultModelImpl &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.sid, sid) || other.sid == sid) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.redirectUrl, redirectUrl) ||
                other.redirectUrl == redirectUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isSuccess, sid, errorMessage, redirectUrl);

  /// Create a copy of QuickConnectLoginResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickConnectLoginResultModelImplCopyWith<
          _$QuickConnectLoginResultModelImpl>
      get copyWith => __$$QuickConnectLoginResultModelImplCopyWithImpl<
          _$QuickConnectLoginResultModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickConnectLoginResultModelImplToJson(
      this,
    );
  }
}

abstract class _QuickConnectLoginResultModel
    implements QuickConnectLoginResultModel {
  const factory _QuickConnectLoginResultModel(
          {@JsonKey(name: 'is_success') required final bool isSuccess,
          final String? sid,
          @JsonKey(name: 'error_message') final String? errorMessage,
          @JsonKey(name: 'redirect_url') final String? redirectUrl}) =
      _$QuickConnectLoginResultModelImpl;

  factory _QuickConnectLoginResultModel.fromJson(Map<String, dynamic> json) =
      _$QuickConnectLoginResultModelImpl.fromJson;

  @override
  @JsonKey(name: 'is_success')
  bool get isSuccess;
  @override
  String? get sid;
  @override
  @JsonKey(name: 'error_message')
  String? get errorMessage;
  @override
  @JsonKey(name: 'redirect_url')
  String? get redirectUrl;

  /// Create a copy of QuickConnectLoginResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickConnectLoginResultModelImplCopyWith<
          _$QuickConnectLoginResultModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

QuickConnectConnectionStatusModel _$QuickConnectConnectionStatusModelFromJson(
    Map<String, dynamic> json) {
  return _QuickConnectConnectionStatusModel.fromJson(json);
}

/// @nodoc
mixin _$QuickConnectConnectionStatusModel {
  @JsonKey(name: 'is_connected')
  bool get isConnected => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_time')
  int get responseTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'error_message')
  String? get errorMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'server_info')
  QuickConnectServerInfoModel? get serverInfo =>
      throw _privateConstructorUsedError;

  /// Serializes this QuickConnectConnectionStatusModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickConnectConnectionStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickConnectConnectionStatusModelCopyWith<QuickConnectConnectionStatusModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickConnectConnectionStatusModelCopyWith<$Res> {
  factory $QuickConnectConnectionStatusModelCopyWith(
          QuickConnectConnectionStatusModel value,
          $Res Function(QuickConnectConnectionStatusModel) then) =
      _$QuickConnectConnectionStatusModelCopyWithImpl<$Res,
          QuickConnectConnectionStatusModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'is_connected') bool isConnected,
      @JsonKey(name: 'response_time') int responseTime,
      @JsonKey(name: 'error_message') String? errorMessage,
      @JsonKey(name: 'server_info') QuickConnectServerInfoModel? serverInfo});

  $QuickConnectServerInfoModelCopyWith<$Res>? get serverInfo;
}

/// @nodoc
class _$QuickConnectConnectionStatusModelCopyWithImpl<$Res,
        $Val extends QuickConnectConnectionStatusModel>
    implements $QuickConnectConnectionStatusModelCopyWith<$Res> {
  _$QuickConnectConnectionStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickConnectConnectionStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? responseTime = null,
    Object? errorMessage = freezed,
    Object? serverInfo = freezed,
  }) {
    return _then(_value.copyWith(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      serverInfo: freezed == serverInfo
          ? _value.serverInfo
          : serverInfo // ignore: cast_nullable_to_non_nullable
              as QuickConnectServerInfoModel?,
    ) as $Val);
  }

  /// Create a copy of QuickConnectConnectionStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuickConnectServerInfoModelCopyWith<$Res>? get serverInfo {
    if (_value.serverInfo == null) {
      return null;
    }

    return $QuickConnectServerInfoModelCopyWith<$Res>(_value.serverInfo!,
        (value) {
      return _then(_value.copyWith(serverInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuickConnectConnectionStatusModelImplCopyWith<$Res>
    implements $QuickConnectConnectionStatusModelCopyWith<$Res> {
  factory _$$QuickConnectConnectionStatusModelImplCopyWith(
          _$QuickConnectConnectionStatusModelImpl value,
          $Res Function(_$QuickConnectConnectionStatusModelImpl) then) =
      __$$QuickConnectConnectionStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'is_connected') bool isConnected,
      @JsonKey(name: 'response_time') int responseTime,
      @JsonKey(name: 'error_message') String? errorMessage,
      @JsonKey(name: 'server_info') QuickConnectServerInfoModel? serverInfo});

  @override
  $QuickConnectServerInfoModelCopyWith<$Res>? get serverInfo;
}

/// @nodoc
class __$$QuickConnectConnectionStatusModelImplCopyWithImpl<$Res>
    extends _$QuickConnectConnectionStatusModelCopyWithImpl<$Res,
        _$QuickConnectConnectionStatusModelImpl>
    implements _$$QuickConnectConnectionStatusModelImplCopyWith<$Res> {
  __$$QuickConnectConnectionStatusModelImplCopyWithImpl(
      _$QuickConnectConnectionStatusModelImpl _value,
      $Res Function(_$QuickConnectConnectionStatusModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuickConnectConnectionStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? responseTime = null,
    Object? errorMessage = freezed,
    Object? serverInfo = freezed,
  }) {
    return _then(_$QuickConnectConnectionStatusModelImpl(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      serverInfo: freezed == serverInfo
          ? _value.serverInfo
          : serverInfo // ignore: cast_nullable_to_non_nullable
              as QuickConnectServerInfoModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickConnectConnectionStatusModelImpl
    implements _QuickConnectConnectionStatusModel {
  const _$QuickConnectConnectionStatusModelImpl(
      {@JsonKey(name: 'is_connected') required this.isConnected,
      @JsonKey(name: 'response_time') required this.responseTime,
      @JsonKey(name: 'error_message') this.errorMessage,
      @JsonKey(name: 'server_info') this.serverInfo});

  factory _$QuickConnectConnectionStatusModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$QuickConnectConnectionStatusModelImplFromJson(json);

  @override
  @JsonKey(name: 'is_connected')
  final bool isConnected;
  @override
  @JsonKey(name: 'response_time')
  final int responseTime;
  @override
  @JsonKey(name: 'error_message')
  final String? errorMessage;
  @override
  @JsonKey(name: 'server_info')
  final QuickConnectServerInfoModel? serverInfo;

  @override
  String toString() {
    return 'QuickConnectConnectionStatusModel(isConnected: $isConnected, responseTime: $responseTime, errorMessage: $errorMessage, serverInfo: $serverInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickConnectConnectionStatusModelImpl &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.serverInfo, serverInfo) ||
                other.serverInfo == serverInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, isConnected, responseTime, errorMessage, serverInfo);

  /// Create a copy of QuickConnectConnectionStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickConnectConnectionStatusModelImplCopyWith<
          _$QuickConnectConnectionStatusModelImpl>
      get copyWith => __$$QuickConnectConnectionStatusModelImplCopyWithImpl<
          _$QuickConnectConnectionStatusModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickConnectConnectionStatusModelImplToJson(
      this,
    );
  }
}

abstract class _QuickConnectConnectionStatusModel
    implements QuickConnectConnectionStatusModel {
  const factory _QuickConnectConnectionStatusModel(
          {@JsonKey(name: 'is_connected') required final bool isConnected,
          @JsonKey(name: 'response_time') required final int responseTime,
          @JsonKey(name: 'error_message') final String? errorMessage,
          @JsonKey(name: 'server_info')
          final QuickConnectServerInfoModel? serverInfo}) =
      _$QuickConnectConnectionStatusModelImpl;

  factory _QuickConnectConnectionStatusModel.fromJson(
          Map<String, dynamic> json) =
      _$QuickConnectConnectionStatusModelImpl.fromJson;

  @override
  @JsonKey(name: 'is_connected')
  bool get isConnected;
  @override
  @JsonKey(name: 'response_time')
  int get responseTime;
  @override
  @JsonKey(name: 'error_message')
  String? get errorMessage;
  @override
  @JsonKey(name: 'server_info')
  QuickConnectServerInfoModel? get serverInfo;

  /// Create a copy of QuickConnectConnectionStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickConnectConnectionStatusModelImplCopyWith<
          _$QuickConnectConnectionStatusModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TunnelResponseModel _$TunnelResponseModelFromJson(Map<String, dynamic> json) {
  return _TunnelResponseModel.fromJson(json);
}

/// @nodoc
mixin _$TunnelResponseModel {
  String get id => throw _privateConstructorUsedError;
  String get domain => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  String get protocol => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_online')
  bool get isOnline => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_time')
  int get responseTime => throw _privateConstructorUsedError;

  /// Serializes this TunnelResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TunnelResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TunnelResponseModelCopyWith<TunnelResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TunnelResponseModelCopyWith<$Res> {
  factory $TunnelResponseModelCopyWith(
          TunnelResponseModel value, $Res Function(TunnelResponseModel) then) =
      _$TunnelResponseModelCopyWithImpl<$Res, TunnelResponseModel>;
  @useResult
  $Res call(
      {String id,
      String domain,
      int port,
      String protocol,
      @JsonKey(name: 'is_online') bool isOnline,
      @JsonKey(name: 'response_time') int responseTime});
}

/// @nodoc
class _$TunnelResponseModelCopyWithImpl<$Res, $Val extends TunnelResponseModel>
    implements $TunnelResponseModelCopyWith<$Res> {
  _$TunnelResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TunnelResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? domain = null,
    Object? port = null,
    Object? protocol = null,
    Object? isOnline = null,
    Object? responseTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      protocol: null == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TunnelResponseModelImplCopyWith<$Res>
    implements $TunnelResponseModelCopyWith<$Res> {
  factory _$$TunnelResponseModelImplCopyWith(_$TunnelResponseModelImpl value,
          $Res Function(_$TunnelResponseModelImpl) then) =
      __$$TunnelResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String domain,
      int port,
      String protocol,
      @JsonKey(name: 'is_online') bool isOnline,
      @JsonKey(name: 'response_time') int responseTime});
}

/// @nodoc
class __$$TunnelResponseModelImplCopyWithImpl<$Res>
    extends _$TunnelResponseModelCopyWithImpl<$Res, _$TunnelResponseModelImpl>
    implements _$$TunnelResponseModelImplCopyWith<$Res> {
  __$$TunnelResponseModelImplCopyWithImpl(_$TunnelResponseModelImpl _value,
      $Res Function(_$TunnelResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TunnelResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? domain = null,
    Object? port = null,
    Object? protocol = null,
    Object? isOnline = null,
    Object? responseTime = null,
  }) {
    return _then(_$TunnelResponseModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      protocol: null == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TunnelResponseModelImpl implements _TunnelResponseModel {
  const _$TunnelResponseModelImpl(
      {required this.id,
      required this.domain,
      required this.port,
      required this.protocol,
      @JsonKey(name: 'is_online') required this.isOnline,
      @JsonKey(name: 'response_time') required this.responseTime});

  factory _$TunnelResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TunnelResponseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String domain;
  @override
  final int port;
  @override
  final String protocol;
  @override
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @override
  @JsonKey(name: 'response_time')
  final int responseTime;

  @override
  String toString() {
    return 'TunnelResponseModel(id: $id, domain: $domain, port: $port, protocol: $protocol, isOnline: $isOnline, responseTime: $responseTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TunnelResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, domain, port, protocol, isOnline, responseTime);

  /// Create a copy of TunnelResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TunnelResponseModelImplCopyWith<_$TunnelResponseModelImpl> get copyWith =>
      __$$TunnelResponseModelImplCopyWithImpl<_$TunnelResponseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TunnelResponseModelImplToJson(
      this,
    );
  }
}

abstract class _TunnelResponseModel implements TunnelResponseModel {
  const factory _TunnelResponseModel(
          {required final String id,
          required final String domain,
          required final int port,
          required final String protocol,
          @JsonKey(name: 'is_online') required final bool isOnline,
          @JsonKey(name: 'response_time') required final int responseTime}) =
      _$TunnelResponseModelImpl;

  factory _TunnelResponseModel.fromJson(Map<String, dynamic> json) =
      _$TunnelResponseModelImpl.fromJson;

  @override
  String get id;
  @override
  String get domain;
  @override
  int get port;
  @override
  String get protocol;
  @override
  @JsonKey(name: 'is_online')
  bool get isOnline;
  @override
  @JsonKey(name: 'response_time')
  int get responseTime;

  /// Create a copy of TunnelResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TunnelResponseModelImplCopyWith<_$TunnelResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServerInfoResponseModel _$ServerInfoResponseModelFromJson(
    Map<String, dynamic> json) {
  return _ServerInfoResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ServerInfoResponseModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'external_domain')
  String get externalDomain => throw _privateConstructorUsedError;
  @JsonKey(name: 'internal_ip')
  String get internalIp => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_online')
  bool get isOnline => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;
  String? get protocol => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_time')
  int get responseTime => throw _privateConstructorUsedError;

  /// Serializes this ServerInfoResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServerInfoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerInfoResponseModelCopyWith<ServerInfoResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerInfoResponseModelCopyWith<$Res> {
  factory $ServerInfoResponseModelCopyWith(ServerInfoResponseModel value,
          $Res Function(ServerInfoResponseModel) then) =
      _$ServerInfoResponseModelCopyWithImpl<$Res, ServerInfoResponseModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'external_domain') String externalDomain,
      @JsonKey(name: 'internal_ip') String internalIp,
      @JsonKey(name: 'is_online') bool isOnline,
      int? port,
      String? protocol,
      @JsonKey(name: 'response_time') int responseTime});
}

/// @nodoc
class _$ServerInfoResponseModelCopyWithImpl<$Res,
        $Val extends ServerInfoResponseModel>
    implements $ServerInfoResponseModelCopyWith<$Res> {
  _$ServerInfoResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerInfoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? externalDomain = null,
    Object? internalIp = null,
    Object? isOnline = null,
    Object? port = freezed,
    Object? protocol = freezed,
    Object? responseTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      externalDomain: null == externalDomain
          ? _value.externalDomain
          : externalDomain // ignore: cast_nullable_to_non_nullable
              as String,
      internalIp: null == internalIp
          ? _value.internalIp
          : internalIp // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as String?,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerInfoResponseModelImplCopyWith<$Res>
    implements $ServerInfoResponseModelCopyWith<$Res> {
  factory _$$ServerInfoResponseModelImplCopyWith(
          _$ServerInfoResponseModelImpl value,
          $Res Function(_$ServerInfoResponseModelImpl) then) =
      __$$ServerInfoResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'external_domain') String externalDomain,
      @JsonKey(name: 'internal_ip') String internalIp,
      @JsonKey(name: 'is_online') bool isOnline,
      int? port,
      String? protocol,
      @JsonKey(name: 'response_time') int responseTime});
}

/// @nodoc
class __$$ServerInfoResponseModelImplCopyWithImpl<$Res>
    extends _$ServerInfoResponseModelCopyWithImpl<$Res,
        _$ServerInfoResponseModelImpl>
    implements _$$ServerInfoResponseModelImplCopyWith<$Res> {
  __$$ServerInfoResponseModelImplCopyWithImpl(
      _$ServerInfoResponseModelImpl _value,
      $Res Function(_$ServerInfoResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServerInfoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? externalDomain = null,
    Object? internalIp = null,
    Object? isOnline = null,
    Object? port = freezed,
    Object? protocol = freezed,
    Object? responseTime = null,
  }) {
    return _then(_$ServerInfoResponseModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      externalDomain: null == externalDomain
          ? _value.externalDomain
          : externalDomain // ignore: cast_nullable_to_non_nullable
              as String,
      internalIp: null == internalIp
          ? _value.internalIp
          : internalIp // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as String?,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerInfoResponseModelImpl implements _ServerInfoResponseModel {
  const _$ServerInfoResponseModelImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'external_domain') required this.externalDomain,
      @JsonKey(name: 'internal_ip') required this.internalIp,
      @JsonKey(name: 'is_online') required this.isOnline,
      this.port,
      this.protocol,
      @JsonKey(name: 'response_time') required this.responseTime});

  factory _$ServerInfoResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerInfoResponseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'external_domain')
  final String externalDomain;
  @override
  @JsonKey(name: 'internal_ip')
  final String internalIp;
  @override
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @override
  final int? port;
  @override
  final String? protocol;
  @override
  @JsonKey(name: 'response_time')
  final int responseTime;

  @override
  String toString() {
    return 'ServerInfoResponseModel(id: $id, name: $name, externalDomain: $externalDomain, internalIp: $internalIp, isOnline: $isOnline, port: $port, protocol: $protocol, responseTime: $responseTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerInfoResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.externalDomain, externalDomain) ||
                other.externalDomain == externalDomain) &&
            (identical(other.internalIp, internalIp) ||
                other.internalIp == internalIp) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, externalDomain,
      internalIp, isOnline, port, protocol, responseTime);

  /// Create a copy of ServerInfoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerInfoResponseModelImplCopyWith<_$ServerInfoResponseModelImpl>
      get copyWith => __$$ServerInfoResponseModelImplCopyWithImpl<
          _$ServerInfoResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerInfoResponseModelImplToJson(
      this,
    );
  }
}

abstract class _ServerInfoResponseModel implements ServerInfoResponseModel {
  const factory _ServerInfoResponseModel(
      {required final String id,
      required final String name,
      @JsonKey(name: 'external_domain') required final String externalDomain,
      @JsonKey(name: 'internal_ip') required final String internalIp,
      @JsonKey(name: 'is_online') required final bool isOnline,
      final int? port,
      final String? protocol,
      @JsonKey(name: 'response_time')
      required final int responseTime}) = _$ServerInfoResponseModelImpl;

  factory _ServerInfoResponseModel.fromJson(Map<String, dynamic> json) =
      _$ServerInfoResponseModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'external_domain')
  String get externalDomain;
  @override
  @JsonKey(name: 'internal_ip')
  String get internalIp;
  @override
  @JsonKey(name: 'is_online')
  bool get isOnline;
  @override
  int? get port;
  @override
  String? get protocol;
  @override
  @JsonKey(name: 'response_time')
  int get responseTime;

  /// Create a copy of ServerInfoResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerInfoResponseModelImplCopyWith<_$ServerInfoResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) {
  return _LoginRequestModel.fromJson(json);
}

/// @nodoc
mixin _$LoginRequestModel {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'otp_code')
  String? get otpCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'remember_me')
  bool get rememberMe => throw _privateConstructorUsedError;

  /// Serializes this LoginRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestModelCopyWith<LoginRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestModelCopyWith<$Res> {
  factory $LoginRequestModelCopyWith(
          LoginRequestModel value, $Res Function(LoginRequestModel) then) =
      _$LoginRequestModelCopyWithImpl<$Res, LoginRequestModel>;
  @useResult
  $Res call(
      {String username,
      String password,
      @JsonKey(name: 'otp_code') String? otpCode,
      @JsonKey(name: 'remember_me') bool rememberMe});
}

/// @nodoc
class _$LoginRequestModelCopyWithImpl<$Res, $Val extends LoginRequestModel>
    implements $LoginRequestModelCopyWith<$Res> {
  _$LoginRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? otpCode = freezed,
    Object? rememberMe = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      otpCode: freezed == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String?,
      rememberMe: null == rememberMe
          ? _value.rememberMe
          : rememberMe // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginRequestModelImplCopyWith<$Res>
    implements $LoginRequestModelCopyWith<$Res> {
  factory _$$LoginRequestModelImplCopyWith(_$LoginRequestModelImpl value,
          $Res Function(_$LoginRequestModelImpl) then) =
      __$$LoginRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String password,
      @JsonKey(name: 'otp_code') String? otpCode,
      @JsonKey(name: 'remember_me') bool rememberMe});
}

/// @nodoc
class __$$LoginRequestModelImplCopyWithImpl<$Res>
    extends _$LoginRequestModelCopyWithImpl<$Res, _$LoginRequestModelImpl>
    implements _$$LoginRequestModelImplCopyWith<$Res> {
  __$$LoginRequestModelImplCopyWithImpl(_$LoginRequestModelImpl _value,
      $Res Function(_$LoginRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? otpCode = freezed,
    Object? rememberMe = null,
  }) {
    return _then(_$LoginRequestModelImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      otpCode: freezed == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String?,
      rememberMe: null == rememberMe
          ? _value.rememberMe
          : rememberMe // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestModelImpl implements _LoginRequestModel {
  const _$LoginRequestModelImpl(
      {required this.username,
      required this.password,
      @JsonKey(name: 'otp_code') this.otpCode,
      @JsonKey(name: 'remember_me') this.rememberMe = false});

  factory _$LoginRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestModelImplFromJson(json);

  @override
  final String username;
  @override
  final String password;
  @override
  @JsonKey(name: 'otp_code')
  final String? otpCode;
  @override
  @JsonKey(name: 'remember_me')
  final bool rememberMe;

  @override
  String toString() {
    return 'LoginRequestModel(username: $username, password: $password, otpCode: $otpCode, rememberMe: $rememberMe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestModelImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.otpCode, otpCode) || other.otpCode == otpCode) &&
            (identical(other.rememberMe, rememberMe) ||
                other.rememberMe == rememberMe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, username, password, otpCode, rememberMe);

  /// Create a copy of LoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestModelImplCopyWith<_$LoginRequestModelImpl> get copyWith =>
      __$$LoginRequestModelImplCopyWithImpl<_$LoginRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestModelImplToJson(
      this,
    );
  }
}

abstract class _LoginRequestModel implements LoginRequestModel {
  const factory _LoginRequestModel(
          {required final String username,
          required final String password,
          @JsonKey(name: 'otp_code') final String? otpCode,
          @JsonKey(name: 'remember_me') final bool rememberMe}) =
      _$LoginRequestModelImpl;

  factory _LoginRequestModel.fromJson(Map<String, dynamic> json) =
      _$LoginRequestModelImpl.fromJson;

  @override
  String get username;
  @override
  String get password;
  @override
  @JsonKey(name: 'otp_code')
  String? get otpCode;
  @override
  @JsonKey(name: 'remember_me')
  bool get rememberMe;

  /// Create a copy of LoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestModelImplCopyWith<_$LoginRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) {
  return _LoginResponseModel.fromJson(json);
}

/// @nodoc
mixin _$LoginResponseModel {
  @JsonKey(name: 'is_success')
  bool get isSuccess => throw _privateConstructorUsedError;
  String? get sid => throw _privateConstructorUsedError;
  @JsonKey(name: 'error_message')
  String? get errorMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'redirect_url')
  String? get redirectUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_time')
  int get responseTime => throw _privateConstructorUsedError;

  /// Serializes this LoginResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginResponseModelCopyWith<LoginResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseModelCopyWith<$Res> {
  factory $LoginResponseModelCopyWith(
          LoginResponseModel value, $Res Function(LoginResponseModel) then) =
      _$LoginResponseModelCopyWithImpl<$Res, LoginResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'is_success') bool isSuccess,
      String? sid,
      @JsonKey(name: 'error_message') String? errorMessage,
      @JsonKey(name: 'redirect_url') String? redirectUrl,
      @JsonKey(name: 'response_time') int responseTime});
}

/// @nodoc
class _$LoginResponseModelCopyWithImpl<$Res, $Val extends LoginResponseModel>
    implements $LoginResponseModelCopyWith<$Res> {
  _$LoginResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? sid = freezed,
    Object? errorMessage = freezed,
    Object? redirectUrl = freezed,
    Object? responseTime = null,
  }) {
    return _then(_value.copyWith(
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      sid: freezed == sid
          ? _value.sid
          : sid // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      redirectUrl: freezed == redirectUrl
          ? _value.redirectUrl
          : redirectUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginResponseModelImplCopyWith<$Res>
    implements $LoginResponseModelCopyWith<$Res> {
  factory _$$LoginResponseModelImplCopyWith(_$LoginResponseModelImpl value,
          $Res Function(_$LoginResponseModelImpl) then) =
      __$$LoginResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'is_success') bool isSuccess,
      String? sid,
      @JsonKey(name: 'error_message') String? errorMessage,
      @JsonKey(name: 'redirect_url') String? redirectUrl,
      @JsonKey(name: 'response_time') int responseTime});
}

/// @nodoc
class __$$LoginResponseModelImplCopyWithImpl<$Res>
    extends _$LoginResponseModelCopyWithImpl<$Res, _$LoginResponseModelImpl>
    implements _$$LoginResponseModelImplCopyWith<$Res> {
  __$$LoginResponseModelImplCopyWithImpl(_$LoginResponseModelImpl _value,
      $Res Function(_$LoginResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSuccess = null,
    Object? sid = freezed,
    Object? errorMessage = freezed,
    Object? redirectUrl = freezed,
    Object? responseTime = null,
  }) {
    return _then(_$LoginResponseModelImpl(
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      sid: freezed == sid
          ? _value.sid
          : sid // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      redirectUrl: freezed == redirectUrl
          ? _value.redirectUrl
          : redirectUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResponseModelImpl implements _LoginResponseModel {
  const _$LoginResponseModelImpl(
      {@JsonKey(name: 'is_success') required this.isSuccess,
      this.sid,
      @JsonKey(name: 'error_message') this.errorMessage,
      @JsonKey(name: 'redirect_url') this.redirectUrl,
      @JsonKey(name: 'response_time') required this.responseTime});

  factory _$LoginResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'is_success')
  final bool isSuccess;
  @override
  final String? sid;
  @override
  @JsonKey(name: 'error_message')
  final String? errorMessage;
  @override
  @JsonKey(name: 'redirect_url')
  final String? redirectUrl;
  @override
  @JsonKey(name: 'response_time')
  final int responseTime;

  @override
  String toString() {
    return 'LoginResponseModel(isSuccess: $isSuccess, sid: $sid, errorMessage: $errorMessage, redirectUrl: $redirectUrl, responseTime: $responseTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResponseModelImpl &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.sid, sid) || other.sid == sid) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.redirectUrl, redirectUrl) ||
                other.redirectUrl == redirectUrl) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, isSuccess, sid, errorMessage, redirectUrl, responseTime);

  /// Create a copy of LoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseModelImplCopyWith<_$LoginResponseModelImpl> get copyWith =>
      __$$LoginResponseModelImplCopyWithImpl<_$LoginResponseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseModelImplToJson(
      this,
    );
  }
}

abstract class _LoginResponseModel implements LoginResponseModel {
  const factory _LoginResponseModel(
          {@JsonKey(name: 'is_success') required final bool isSuccess,
          final String? sid,
          @JsonKey(name: 'error_message') final String? errorMessage,
          @JsonKey(name: 'redirect_url') final String? redirectUrl,
          @JsonKey(name: 'response_time') required final int responseTime}) =
      _$LoginResponseModelImpl;

  factory _LoginResponseModel.fromJson(Map<String, dynamic> json) =
      _$LoginResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'is_success')
  bool get isSuccess;
  @override
  String? get sid;
  @override
  @JsonKey(name: 'error_message')
  String? get errorMessage;
  @override
  @JsonKey(name: 'redirect_url')
  String? get redirectUrl;
  @override
  @JsonKey(name: 'response_time')
  int get responseTime;

  /// Create a copy of LoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResponseModelImplCopyWith<_$LoginResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
