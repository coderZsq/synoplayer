import '../../../../base/error/result.dart';

abstract class AudioRepository {
  Future<Result<String>> getAudioStreamUrl(String songId);
}
