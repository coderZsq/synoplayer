import 'package:dio/dio.dart';
import '../repositories/quick_connect_repository.dart';
import '../services/connection_manager.dart';
import '../../../base/error/exceptions.dart';
import '../../../base/error/result.dart';
import '../../../base/auth/storage/auth_storage_service.dart';

class GetAudioStreamUseCase {
  final QuickConnectRepository repository;
  final AuthStorageService authStorage;
  final ConnectionManager connectionManager;

  GetAudioStreamUseCase(this.repository, this.authStorage, this.connectionManager);

  Future<Result<Response>> call({
    required String id,
    int seekPosition = 0,
  }) async {
    try {
      // 从缓存中获取 quickConnectId
      final credentials = await authStorage.getLoginCredentials();
      final quickConnectId = credentials['quickConnectId'];
      
      if (quickConnectId == null || quickConnectId.isEmpty) {
        return Failure(BusinessException('未找到服务器连接信息，请先登录'));
      }
      
      // 如果已经连接，直接获取音频流
      if (connectionManager.connected) {
        return await _getAudioStream(id: id, seekPosition: seekPosition);
      }
      
      // 获取服务器信息并建立连接
      final connectionResult = await connectionManager.establishConnection(quickConnectId);
      if (connectionResult.isFailure) {
        return Failure(connectionResult.error);
      }
      
      // 连接成功后获取音频流
      return await _getAudioStream(id: id, seekPosition: seekPosition);
    } catch (e) {
      if (e is AppException) {
        return Failure(e);
      }
      return Failure(ServerException('获取音频流失败: ${e.toString()}'));
    }
  }

  /// 获取音频流
  Future<Result<Response>> _getAudioStream({
    required String id,
    int seekPosition = 0,
  }) async {
    final result = await repository.getAudioStream(
      id: id,
      seekPosition: seekPosition,
    );
    return result;
  }
}
