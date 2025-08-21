import '../../entities/get_server_info_response.dart';
import '../repositories/get_server_info_repository.dart';

class GetServerInfoUseCase {
  final GetServerInfoRepository repository;

  GetServerInfoUseCase(this.repository);

  Future<GetServerInfoResponse> call({
    required String serverID,
  }) {
    return repository.getServerInfo(
      serverID: serverID,
    );
  }
}
