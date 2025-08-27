// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'song_list_all_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SongListAllResponse _$SongListAllResponseFromJson(Map<String, dynamic> json) {
  return _SongListAllResponse.fromJson(json);
}

/// @nodoc
mixin _$SongListAllResponse {
  SongListData? get data => throw _privateConstructorUsedError;
  bool? get success => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongListAllResponseCopyWith<SongListAllResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongListAllResponseCopyWith<$Res> {
  factory $SongListAllResponseCopyWith(
          SongListAllResponse value, $Res Function(SongListAllResponse) then) =
      _$SongListAllResponseCopyWithImpl<$Res, SongListAllResponse>;
  @useResult
  $Res call({SongListData? data, bool? success});

  $SongListDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$SongListAllResponseCopyWithImpl<$Res, $Val extends SongListAllResponse>
    implements $SongListAllResponseCopyWith<$Res> {
  _$SongListAllResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? success = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SongListData?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SongListDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $SongListDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SongListAllResponseImplCopyWith<$Res>
    implements $SongListAllResponseCopyWith<$Res> {
  factory _$$SongListAllResponseImplCopyWith(_$SongListAllResponseImpl value,
          $Res Function(_$SongListAllResponseImpl) then) =
      __$$SongListAllResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SongListData? data, bool? success});

  @override
  $SongListDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$SongListAllResponseImplCopyWithImpl<$Res>
    extends _$SongListAllResponseCopyWithImpl<$Res, _$SongListAllResponseImpl>
    implements _$$SongListAllResponseImplCopyWith<$Res> {
  __$$SongListAllResponseImplCopyWithImpl(_$SongListAllResponseImpl _value,
      $Res Function(_$SongListAllResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? success = freezed,
  }) {
    return _then(_$SongListAllResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SongListData?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SongListAllResponseImpl implements _SongListAllResponse {
  const _$SongListAllResponseImpl({required this.data, required this.success});

  factory _$SongListAllResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SongListAllResponseImplFromJson(json);

  @override
  final SongListData? data;
  @override
  final bool? success;

  @override
  String toString() {
    return 'SongListAllResponse(data: $data, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SongListAllResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, success);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SongListAllResponseImplCopyWith<_$SongListAllResponseImpl> get copyWith =>
      __$$SongListAllResponseImplCopyWithImpl<_$SongListAllResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SongListAllResponseImplToJson(
      this,
    );
  }
}

abstract class _SongListAllResponse implements SongListAllResponse {
  const factory _SongListAllResponse(
      {required final SongListData? data,
      required final bool? success}) = _$SongListAllResponseImpl;

  factory _SongListAllResponse.fromJson(Map<String, dynamic> json) =
      _$SongListAllResponseImpl.fromJson;

  @override
  SongListData? get data;
  @override
  bool? get success;
  @override
  @JsonKey(ignore: true)
  _$$SongListAllResponseImplCopyWith<_$SongListAllResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SongListData _$SongListDataFromJson(Map<String, dynamic> json) {
  return _SongListData.fromJson(json);
}

/// @nodoc
mixin _$SongListData {
  int? get offset => throw _privateConstructorUsedError;
  List<Song>? get songs => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongListDataCopyWith<SongListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongListDataCopyWith<$Res> {
  factory $SongListDataCopyWith(
          SongListData value, $Res Function(SongListData) then) =
      _$SongListDataCopyWithImpl<$Res, SongListData>;
  @useResult
  $Res call({int? offset, List<Song>? songs, int? total});
}

/// @nodoc
class _$SongListDataCopyWithImpl<$Res, $Val extends SongListData>
    implements $SongListDataCopyWith<$Res> {
  _$SongListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = freezed,
    Object? songs = freezed,
    Object? total = freezed,
  }) {
    return _then(_value.copyWith(
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      songs: freezed == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SongListDataImplCopyWith<$Res>
    implements $SongListDataCopyWith<$Res> {
  factory _$$SongListDataImplCopyWith(
          _$SongListDataImpl value, $Res Function(_$SongListDataImpl) then) =
      __$$SongListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? offset, List<Song>? songs, int? total});
}

/// @nodoc
class __$$SongListDataImplCopyWithImpl<$Res>
    extends _$SongListDataCopyWithImpl<$Res, _$SongListDataImpl>
    implements _$$SongListDataImplCopyWith<$Res> {
  __$$SongListDataImplCopyWithImpl(
      _$SongListDataImpl _value, $Res Function(_$SongListDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = freezed,
    Object? songs = freezed,
    Object? total = freezed,
  }) {
    return _then(_$SongListDataImpl(
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      songs: freezed == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SongListDataImpl implements _SongListData {
  const _$SongListDataImpl(
      {required this.offset,
      required final List<Song>? songs,
      required this.total})
      : _songs = songs;

  factory _$SongListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SongListDataImplFromJson(json);

  @override
  final int? offset;
  final List<Song>? _songs;
  @override
  List<Song>? get songs {
    final value = _songs;
    if (value == null) return null;
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? total;

  @override
  String toString() {
    return 'SongListData(offset: $offset, songs: $songs, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SongListDataImpl &&
            (identical(other.offset, offset) || other.offset == offset) &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, offset, const DeepCollectionEquality().hash(_songs), total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SongListDataImplCopyWith<_$SongListDataImpl> get copyWith =>
      __$$SongListDataImplCopyWithImpl<_$SongListDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SongListDataImplToJson(
      this,
    );
  }
}

abstract class _SongListData implements SongListData {
  const factory _SongListData(
      {required final int? offset,
      required final List<Song>? songs,
      required final int? total}) = _$SongListDataImpl;

  factory _SongListData.fromJson(Map<String, dynamic> json) =
      _$SongListDataImpl.fromJson;

  @override
  int? get offset;
  @override
  List<Song>? get songs;
  @override
  int? get total;
  @override
  @JsonKey(ignore: true)
  _$$SongListDataImplCopyWith<_$SongListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Song _$SongFromJson(Map<String, dynamic> json) {
  return _Song.fromJson(json);
}

/// @nodoc
mixin _$Song {
  String? get id => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongCopyWith<Song> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongCopyWith<$Res> {
  factory $SongCopyWith(Song value, $Res Function(Song) then) =
      _$SongCopyWithImpl<$Res, Song>;
  @useResult
  $Res call({String? id, String? path, String? title, String? type});
}

/// @nodoc
class _$SongCopyWithImpl<$Res, $Val extends Song>
    implements $SongCopyWith<$Res> {
  _$SongCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? path = freezed,
    Object? title = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SongImplCopyWith<$Res> implements $SongCopyWith<$Res> {
  factory _$$SongImplCopyWith(
          _$SongImpl value, $Res Function(_$SongImpl) then) =
      __$$SongImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? path, String? title, String? type});
}

/// @nodoc
class __$$SongImplCopyWithImpl<$Res>
    extends _$SongCopyWithImpl<$Res, _$SongImpl>
    implements _$$SongImplCopyWith<$Res> {
  __$$SongImplCopyWithImpl(_$SongImpl _value, $Res Function(_$SongImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? path = freezed,
    Object? title = freezed,
    Object? type = freezed,
  }) {
    return _then(_$SongImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SongImpl implements _Song {
  const _$SongImpl(
      {required this.id,
      required this.path,
      required this.title,
      required this.type});

  factory _$SongImpl.fromJson(Map<String, dynamic> json) =>
      _$$SongImplFromJson(json);

  @override
  final String? id;
  @override
  final String? path;
  @override
  final String? title;
  @override
  final String? type;

  @override
  String toString() {
    return 'Song(id: $id, path: $path, title: $title, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SongImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, path, title, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SongImplCopyWith<_$SongImpl> get copyWith =>
      __$$SongImplCopyWithImpl<_$SongImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SongImplToJson(
      this,
    );
  }
}

abstract class _Song implements Song {
  const factory _Song(
      {required final String? id,
      required final String? path,
      required final String? title,
      required final String? type}) = _$SongImpl;

  factory _Song.fromJson(Map<String, dynamic> json) = _$SongImpl.fromJson;

  @override
  String? get id;
  @override
  String? get path;
  @override
  String? get title;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$$SongImplCopyWith<_$SongImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
