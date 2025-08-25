import 'package:freezed_annotation/freezed_annotation.dart';

part 'song_list_all_response.freezed.dart';
part 'song_list_all_response.g.dart';

@freezed
class SongListAllResponse with _$SongListAllResponse {
  const factory SongListAllResponse({
    required SongListData? data,
    required bool? success,
  }) = _SongListAllResponse;

  factory SongListAllResponse.fromJson(Map<String, dynamic> json) =>
      _$SongListAllResponseFromJson(json);
}

@freezed
class SongListData with _$SongListData {
  const factory SongListData({
    required int? offset,
    required List<Song>? songs,
    required int? total,
  }) = _SongListData;

  factory SongListData.fromJson(Map<String, dynamic> json) =>
      _$SongListDataFromJson(json);
}

@freezed
class Song with _$Song {
  const factory Song({
    required String? id,
    required String? path,
    required String? title,
    required String? type,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) =>
      _$SongFromJson(json);
}
