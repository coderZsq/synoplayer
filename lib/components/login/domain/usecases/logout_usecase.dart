import '../../../../base/error/exceptions.dart';
import '../../../../base/error/result.dart';
import '../../../../base/utils/logger.dart';
import '../repositories/login_repository.dart';
import '../services/connection_manager.dart';

class LogoutUseCase {
  final LoginRepository repository;
  final ConnectionManager connectionManager;

  LogoutUseCase(this.repository, this.connectionManager);

  Future<Result<void>> call({
    required String sessionId,
  }) async {
    try {
      // 检查是否已连接
      if (!connectionManager.connected) {
        Logger.info('未连接到服务器，无法执行登出操作', tag: 'LogoutUseCase');
        return Failure(BusinessException('未连接到服务器'));
      }

      // 执行登出
      final logoutResult = await repository.authLogout(sessionId: sessionId);
      
      if (logoutResult.isFailure) {
        Logger.info('登出失败 - ${logoutResult.error.message}', tag: 'LogoutUseCase');
        return Failure(logoutResult.error);
      }

      final response = logoutResult.value;
      Logger.info('登出响应 - success: ${response.success}', tag: 'LogoutUseCase');

      // 检查登出是否成功
      if (!response.success) {
        Logger.info('登出失败 - success: ${response.success}', tag: 'LogoutUseCase');
        return Failure(BusinessException('登出失败，请稍后重试'));
      }

      // 登出成功后重置连接状态
      connectionManager.resetConnection();
      
      Logger.info('登出成功，已重置连接状态', tag: 'LogoutUseCase');
      return const Success(null);
    } catch (e) {
      if (e is AppException) {
        return Failure(e);
      }
      return Failure(ServerException('登出过程发生未知错误: ${e.toString()}'));
    }
  }
}
