import '../../domain/usecases/get_server_info_usecase.dart';
import '../../data/repositories/quickconnect_repository_impl.dart';
import '../../entities/quickconnect_response.dart';

class QuickConnectService {
  late final GetServerInfoUseCase _getServerInfoUseCase;

  QuickConnectService() {
    _getServerInfoUseCase = GetServerInfoUseCase(QuickConnectRepositoryImpl());
  }

  Future<QuickConnectResponse> getServerInfo({
    required String serverId,
  }) async {
    return await _getServerInfoUseCase(
      serverId: serverId,
    );
  }
}
