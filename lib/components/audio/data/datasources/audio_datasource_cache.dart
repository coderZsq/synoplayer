import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../entities/song_list_all/song_list_all_response.dart';

/// 音频缓存数据源 - 提供像remote一样自然的缓存接口
class AudioDataSourceCache {
  // 缓存相关常量
  static const String _cacheKey = 'audio_station_song_list_cache';
  static const String _cacheTimestampKey = 'audio_station_song_list_cache_timestamp';
  static const String _cacheOffsetKey = 'audio_station_song_list_cache_offset';
  static const String _cacheLimitKey = 'audio_station_song_list_cache_limit';
  
  // 缓存过期时间：1小时
  static const Duration _cacheExpiration = Duration(hours: 1);

  /// 从缓存获取音频列表（像remote一样自然调用）
  Future<SongListAllResponse?> getAudioStationSongListAll({
    required int offset,
    required int limit,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // 检查缓存是否存在
      if (!prefs.containsKey(_cacheKey)) {
        return null;
      }
      
      // 检查缓存是否过期
      final timestamp = prefs.getInt(_cacheTimestampKey);
      if (timestamp == null) {
        return null;
      }
      
      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      if (DateTime.now().difference(cacheTime) > _cacheExpiration) {
        // 缓存已过期，清除缓存
        await _clearCache();
        return null;
      }
      
      // 读取缓存数据
      final jsonString = prefs.getString(_cacheKey);
      if (jsonString == null) {
        return null;
      }
      
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return SongListAllResponse.fromJson(json);
    } catch (e) {
      print('读取缓存音频列表失败: $e');
      return null;
    }
  }

  /// 保存音频列表到缓存（像remote一样自然调用）
  Future<void> saveAudioStationSongListAll({
    required SongListAllResponse response,
    required int offset,
    required int limit,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // 保存音频列表数据
      final jsonString = jsonEncode(response.toJson());
      await prefs.setString(_cacheKey, jsonString);
      
      // 保存分页参数
      await prefs.setInt(_cacheOffsetKey, offset);
      await prefs.setInt(_cacheLimitKey, limit);
      
      // 保存缓存时间戳
      await prefs.setInt(_cacheTimestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('缓存音频列表失败: $e');
    }
  }

  /// 检查缓存是否存在且有效
  Future<bool> hasValidCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (!prefs.containsKey(_cacheKey)) {
        return false;
      }
      
      final timestamp = prefs.getInt(_cacheTimestampKey);
      if (timestamp == null) {
        return false;
      }
      
      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return DateTime.now().difference(cacheTime) <= _cacheExpiration;
    } catch (e) {
      return false;
    }
  }

  /// 清除缓存
  Future<void> clearCache() async {
    await _clearCache();
  }

  /// 内部清除缓存方法
  Future<void> _clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      await prefs.remove(_cacheTimestampKey);
      await prefs.remove(_cacheOffsetKey);
      await prefs.remove(_cacheLimitKey);
    } catch (e) {
      print('清除缓存失败: $e');
    }
  }
}
