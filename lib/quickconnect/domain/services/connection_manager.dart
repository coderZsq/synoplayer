import '../repositories/quick_connect_repository.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/result.dart';

class ConnectionManager {
  final QuickConnectRepository repository;
  bool? isConnected;

  ConnectionManager(this.repository);

  /// 建立与服务器的连接
  Future<Result<void>> establishConnection(String quickConnectId) async {
    final serverInfoResult = await repository.getServerInfo(serverID: quickConnectId);
    
    if (serverInfoResult.isFailure) {
      return serverInfoResult.mapError((_) => serverInfoResult.error);
    }
    
    final r1 = serverInfoResult.value;
    final sites = r1.sites;
    if (sites == null || sites.isEmpty) {
      return Failure(BusinessException('未找到可用的连接站点'));
    }
    
    final site = sites.first;
    final siteResult = await repository.getServerInfo(
      serverID: quickConnectId,
      site: site,
    );
    
    if (siteResult.isFailure) {
      return siteResult.mapError((_) => siteResult.error);
    }
    
    final r2 = siteResult.value;
    final relayDn = r2.service?.relay_dn;
    final relayPort = r2.service?.relay_port;
    
    if (relayDn == null || relayPort == null) {
      return Failure(BusinessException('无法获取服务器连接信息'));
    }
    
    final queryResult = await repository.queryApiInfo(relayDn: relayDn, relayPort: relayPort);
    if (queryResult.isFailure) {
      return queryResult.mapError((_) => queryResult.error);
    }
    
    isConnected = queryResult.value;
    return const Success(null);
  }

  /// 检查是否已连接
  bool get connected => isConnected == true;

  /// 重置连接状态
  void resetConnection() {
    isConnected = null;
  }
}
