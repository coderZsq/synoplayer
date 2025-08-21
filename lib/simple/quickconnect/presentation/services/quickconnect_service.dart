import '../../domain/usecases/get_server_info_usecase.dart';
import '../../data/repositories/get_server_info_repository_impl.dart';
import '../../entities/get_server_info_response.dart';

class QuickConnectService {
  late final GetServerInfoUseCase _getServerInfoUseCase;

  QuickConnectService() {
    _getServerInfoUseCase = GetServerInfoUseCase(GetServerInfoRepositoryImpl());
  }

  Future<GetServerInfoResponse> getServerInfo({
    required String serverID,
  }) async {
    return await _getServerInfoUseCase(
      serverID: serverID,
    );
  }
}
