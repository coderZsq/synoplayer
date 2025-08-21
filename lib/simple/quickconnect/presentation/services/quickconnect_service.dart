import '../../domain/usecases/get_server_info_usecase.dart';
import '../../data/repositories/get_server_info_repository_impl.dart';
import '../../entities/get_server_info_response.dart';

class QuickConnectService2 {
  late final GetServerInfoUseCase _getServerInfoUseCase;

  QuickConnectService2() {
    _getServerInfoUseCase = GetServerInfoUseCase(GetServerInfoRepositoryImpl());
  }

  Future<GetServerInfoResponse> getServerInfo({
    required String serverID,
  }) async {
    return await _getServerInfoUseCase(
      serverID: serverID,
    );
  }

  Future<GetServerInfoResponse> getServerInfoWithSiteUrl({
    required String serverID,
    required String site,
  }) async {
    return await _getServerInfoUseCase(
      serverID: serverID,
      site: site,
    );
  }

  Future<GetServerInfoResponse> getServerInfoWithFallback({
    required String serverID,
  }) async {
    final firstResponse = await getServerInfo(serverID: serverID);
    final sites = firstResponse.sites;
    if (sites != null && sites.isNotEmpty) {
      final site = sites.first;
      try {
        final secondResponse = await getServerInfoWithSiteUrl(
          serverID: serverID,
          site: site,
        );
        return secondResponse;
      } catch (e) {
        return firstResponse;
      }
    }
    return firstResponse;
  }
}
