// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_list_all_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SongListAllResponseImpl _$$SongListAllResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SongListAllResponseImpl(
      data: json['data'] == null
          ? null
          : SongListData.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$$SongListAllResponseImplToJson(
        _$SongListAllResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
    };

_$SongListDataImpl _$$SongListDataImplFromJson(Map<String, dynamic> json) =>
    _$SongListDataImpl(
      offset: (json['offset'] as num?)?.toInt(),
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SongListDataImplToJson(_$SongListDataImpl instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'songs': instance.songs,
      'total': instance.total,
    };

_$SongImpl _$$SongImplFromJson(Map<String, dynamic> json) => _$SongImpl(
      id: json['id'] as String?,
      path: json['path'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$SongImplToJson(_$SongImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'title': instance.title,
      'type': instance.type,
    };
