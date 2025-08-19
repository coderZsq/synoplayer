import 'package:dartz/dartz.dart';

import '../../domain/entities/quickconnect_entity.dart';
import '../../domain/repositories/quickconnect_repository.dart';
import '../datasources/quickconnect_remote_datasource.dart';
import '../datasources/quickconnect_local_datasource.dart';
import '../models/quickconnect_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

/// QuickConnect 仓库实现
/// 
/// 实现 QuickConnectRepository 接口
/// 协调远程和本地数据源
/// 实现缓存策略和离线支持
class QuickConnectRepositoryImpl implements QuickConnectRepository {
  const QuickConnectRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final QuickConnectRemoteDataSource remoteDataSource;
  final QuickConnectLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, QuickConnectServerInfo>> resolveAddress(
    String quickConnectId,
  ) async {
    try {
      // 1. 检查网络连接
      final isConnected = await networkInfo.isConnected;
      
      if (!isConnected) {
        // 离线时尝试从本地获取缓存
        final cachedResult = await localDataSource.getCachedServerInfo(quickConnectId);
        return cachedResult.fold(
          (failure) => Left(failure),
          (cachedInfo) => cachedInfo != null
              ? Right(cachedInfo.toEntity())
              : const Left(NetworkFailure('网络不可用且无缓存数据')),
        );
      }

      // 2. 从远程获取数据
      final remoteResult = await remoteDataSource.requestTunnel(quickConnectId);
      
      return remoteResult.fold(
        (failure) => Left(failure),
        (tunnelResponse) async {
          if (tunnelResponse == null) {
            return const Left(ServerFailure('无法解析 QuickConnect ID'));
          }

          // 3. 转换为领域实体
          final serverInfo = QuickConnectServerInfo(
            id: tunnelResponse.id,
            name: tunnelResponse.id, // 使用 ID 作为名称
            externalDomain: tunnelResponse.domain,
            internalIp: '', // 需要额外请求获取
            isOnline: tunnelResponse.isOnline,
            port: tunnelResponse.port,
            protocol: tunnelResponse.protocol,
          );

          // 4. 缓存到本地
          await localDataSource.cacheServerInfo(
            QuickConnectServerInfoModel.fromEntity(serverInfo),
          );

          return Right(serverInfo);
        },
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, QuickConnectServerInfo>> getServerInfo(
    String quickConnectId,
  ) async {
    try {
      // 1. 检查网络连接
      final isConnected = await networkInfo.isConnected;
      
      if (!isConnected) {
        // 离线时尝试从本地获取缓存
        final cachedResult = await localDataSource.getCachedServerInfo(quickConnectId);
        return cachedResult.fold(
          (failure) => Left(failure),
          (cachedInfo) => cachedInfo != null
              ? Right(cachedInfo.toEntity())
              : const Left(NetworkFailure('网络不可用且无缓存数据')),
        );
      }

      // 2. 从远程获取数据
      final remoteResult = await remoteDataSource.requestServerInfo(quickConnectId);
      
      return remoteResult.fold(
        (failure) => Left(failure),
        (serverInfoResponse) async {
          if (serverInfoResponse == null) {
            return const Left(ServerFailure('无法获取服务器信息'));
          }

          // 3. 转换为领域实体
          final serverInfo = QuickConnectServerInfo(
            id: serverInfoResponse.id,
            name: serverInfoResponse.name,
            externalDomain: serverInfoResponse.externalDomain,
            internalIp: serverInfoResponse.internalIp,
            isOnline: serverInfoResponse.isOnline,
            port: serverInfoResponse.port,
            protocol: serverInfoResponse.protocol,
          );

          // 4. 缓存到本地
          await localDataSource.cacheServerInfo(
            QuickConnectServerInfoModel.fromEntity(serverInfo),
          );

          return Right(serverInfo);
        },
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, QuickConnectConnectionStatus>> testConnection(
    String serverUrl,
  ) async {
    try {
      // 1. 检查网络连接
      final isConnected = await networkInfo.isConnected;
      
      if (!isConnected) {
        return const Left(NetworkFailure('网络不可用'));
      }

      // 2. 测试连接
      final remoteResult = await remoteDataSource.testConnection(serverUrl);
      
      return remoteResult.fold(
        (failure) => Left(failure),
        (connectionStatusModel) => Right(connectionStatusModel.toEntity()),
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, QuickConnectLoginResult>> login({
    required String serverUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    try {
      // 1. 检查网络连接
      final isConnected = await networkInfo.isConnected;
      
      if (!isConnected) {
        return const Left(NetworkFailure('网络不可用'));
      }

      // 2. 执行登录
      final remoteResult = await remoteDataSource.requestLogin(
        baseUrl: serverUrl,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      return remoteResult.fold(
        (failure) => Left(failure),
        (loginResponse) async {
          // 3. 转换为领域实体
          final loginResult = QuickConnectLoginResult(
            isSuccess: loginResponse.isSuccess,
            sid: loginResponse.sid,
            errorMessage: loginResponse.errorMessage,
            redirectUrl: loginResponse.redirectUrl,
          );

          // 4. 如果登录成功，缓存凭据和会话
          if (loginResult.isSuccess && loginResult.sid != null) {
            await _cacheLoginData(
              serverUrl: serverUrl,
              username: username,
              password: password,
              sid: loginResult.sid!,
            );
          }

          return Right(loginResult);
        },
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, QuickConnectLoginResult>> smartLogin({
    required String serverUrl,
    required String username,
    required String password,
  }) async {
    try {
      // 1. 检查网络连接
      final isConnected = await networkInfo.isConnected;
      
      if (!isConnected) {
        return const Left(NetworkFailure('网络不可用'));
      }

      // 2. 尝试智能登录（这里可以添加智能逻辑）
      // 例如：先尝试普通登录，失败时尝试其他方式
      final loginResult = await login(
        serverUrl: serverUrl,
        username: username,
        password: password,
      );

      return loginResult;
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> validateSession({
    required String serverUrl,
    required String sid,
  }) async {
    try {
      // 1. 检查网络连接
      final isConnected = await networkInfo.isConnected;
      
      if (!isConnected) {
        // 离线时检查本地缓存
        final cachedSession = await localDataSource.getCachedSession(serverUrl);
        return cachedSession.fold(
          (failure) => Left(failure),
          (session) {
            if (session == null) return const Right(false);
            
            final expiryTime = DateTime.parse(session['expiry_time']);
            return Right(DateTime.now().isBefore(expiryTime));
          },
        );
      }

      // 2. 验证远程会话
      final remoteResult = await remoteDataSource.validateSession(
        baseUrl: serverUrl,
        sid: sid,
      );
      
      return remoteResult;
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> logout({
    required String serverUrl,
    required String sid,
  }) async {
    try {
      // 1. 检查网络连接
      final isConnected = await networkInfo.isConnected;
      
      if (!isConnected) {
        // 离线时只清除本地缓存
        await localDataSource.clearSession(serverUrl);
        await localDataSource.clearCredentials(serverUrl);
        return const Right(true);
      }

      // 2. 远程注销
      final remoteResult = await remoteDataSource.logout(
        baseUrl: serverUrl,
        sid: sid,
      );
      
      // 3. 无论远程是否成功，都清除本地缓存
      await localDataSource.clearSession(serverUrl);
      await localDataSource.clearCredentials(serverUrl);
      
      return remoteResult;
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, List<QuickConnectServerInfo>>> getConnectionHistory() async {
    try {
      final localResult = await localDataSource.getConnectionHistory();
      
      return localResult.fold(
        (failure) => Left(failure),
        (historyModels) => Right(
          historyModels.map((model) => model.toEntity()).toList(),
        ),
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> saveConnectionHistory(
    QuickConnectServerInfo serverInfo,
  ) async {
    try {
      final model = QuickConnectServerInfoModel.fromEntity(serverInfo);
      final result = await localDataSource.cacheConnectionHistory(model);
      
      return result;
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> clearConnectionHistory() async {
    try {
      final result = await localDataSource.clearConnectionHistory();
      
      return result;
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> checkNetworkConnectivity() async {
    try {
      final isConnected = await networkInfo.isConnected;
      
      return Right(isConnected);
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPerformanceStats() async {
    try {
      // 1. 尝试从远程获取最新统计
      final isConnected = await networkInfo.isConnected;
      
      if (isConnected) {
        final remoteResult = await remoteDataSource.getPerformanceStats();
        
        return remoteResult.fold(
          (failure) => Left(failure),
          (remoteStats) async {
            // 缓存到本地
            await localDataSource.cachePerformanceStats(remoteStats);
            return Right(remoteStats);
          },
        );
      }

      // 2. 离线时返回本地缓存
      final localResult = await localDataSource.getCachedPerformanceStats();
      
      return localResult.fold(
        (failure) => Left(failure),
        (cachedStats) => cachedStats != null
            ? Right(cachedStats)
            : const Left(CacheFailure('无性能统计数据')),
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  /// 缓存登录相关数据
  Future<void> _cacheLoginData({
    required String serverUrl,
    required String username,
    required String password,
    required String sid,
  }) async {
    try {
      // 缓存凭据
      await localDataSource.cacheCredentials(
        serverUrl: serverUrl,
        username: username,
        password: password,
        rememberMe: true,
      );

      // 缓存会话（24小时过期）
      final expiryTime = DateTime.now().add(const Duration(hours: 24));
      await localDataSource.cacheSession(
        serverUrl: serverUrl,
        sid: sid,
        expiryTime: expiryTime,
      );
    } catch (e) {
      // 缓存失败不影响登录流程
      // 可以记录日志但不抛出异常
    }
  }

  /// 处理未预期的错误
  Failure _handleUnexpectedError(Object error) {
    if (error is Exception) {
      return ServerFailure('服务器异常: ${error.toString()}');
    }

    return UnknownFailure('未知错误: ${error.toString()}');
  }
}
