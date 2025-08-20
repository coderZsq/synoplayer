import '../../entities/quickconnect_response.dart';
import '../repositories/quickconnect_repository.dart';

class GetServerInfoUseCase {
  final QuickConnectRepository repository;

  GetServerInfoUseCase(this.repository);

  Future<QuickConnectResponse> call({
    required String serverId,
  }) {
    return repository.getServerInfo(
      serverId: serverId,
    );
  }
}
