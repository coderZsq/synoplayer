import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../base/di/providers.dart';
import '../services/audio_player_service.dart';

part 'audio_player_provider.g.dart';

@riverpod
AudioPlayerService audioPlayerService(AudioPlayerServiceRef ref) {
  final quickConnectService = ref.read(quickConnectServiceProvider);
  return AudioPlayerService(quickConnectService);
}

@riverpod
class AudioPlayerNotifier extends _$AudioPlayerNotifier {
  @override
  AudioPlayerService build() {
    return ref.read(audioPlayerServiceProvider);
  }

  Future<void> playSong(String songId, String songTitle) async {
    await state.playSong(songId, songTitle);
  }

  Future<void> pause() async {
    await state.pause();
  }

  Future<void> resume() async {
    await state.resume();
  }

  Future<void> stop() async {
    await state.stop();
  }

  Future<void> seekTo(Duration position) async {
    await state.seekTo(position);
  }
}
