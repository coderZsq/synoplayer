import 'package:dio/dio.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/get_song_list_usecase.dart';
import '../../domain/usecases/get_audio_stream_usecase.dart';
import '../../entities/auth_login/auth_login_response.dart';
import '../../entities/song_list_all/song_list_all_response.dart';
import '../../../base/error/result.dart';

class QuickConnectService {
  final LoginUseCase _loginUseCase;
  final GetSongListUseCase _getSongListUseCase;
  final GetAudioStreamUseCase _getAudioStreamUseCase;

  QuickConnectService(
    this._loginUseCase,
    this._getSongListUseCase,
    this._getAudioStreamUseCase,
  );

  /// 登录功能
  Future<Result<LoginData>> login({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return await _loginUseCase(
      quickConnectId: quickConnectId,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }

  /// 获取歌曲列表
  Future<Result<SongListAllResponse>> getSongList({
    int offset = 0,
    int limit = 20,
  }) async {
    return await _getSongListUseCase(
      offset: offset,
      limit: limit,
    );
  }

  /// 获取音频流
  Future<Result<Response>> getAudioStream({
    required String id,
    int seekPosition = 0,
  }) async {
    return await _getAudioStreamUseCase(
      id: id,
      seekPosition: seekPosition,
    );
  }
}
