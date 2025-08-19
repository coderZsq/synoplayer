import 'package:dartz/dartz.dart';

import '../../domain/entities/quickconnect_entity.dart';
import '../../domain/repositories/quickconnect_repository.dart';
import '../datasources/quickconnect_remote_datasource.dart';
import '../datasources/quickconnect_local_datasource.dart';
import '../models/quickconnect_model.dart';
import '../../../../core/error/failures.dart';
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
    String address, {
    int? port,
  }) async {
    try {
      // 1. 检查网络连接
      final isConnected = await networkInfo.isConnected;
      
      if (!isConnected) {
        return const Left(NetworkFailure('网络不可用'));
      }

      // 2. 测试连接
      final testResult = await remoteDataSource.testConnection(address, port: port);
      
      return testResult.fold(
        (failure) => Left(failure),
        (isConnected) async {
          // 3. 创建连接状态
          final connectionStatus = QuickConnectConnectionStatus(
            isConnected: isConnected,
            responseTime: 0, // 这里可以添加实际的响应时间测量
            errorMessage: isConnected ? null : '连接失败',
            serverInfo: null, // 可以添加服务器信息
          );

          // 4. 缓存连接状态
          await localDataSource.cacheConnectionStatus(
            QuickConnectConnectionStatusModel.fromEntity(connectionStatus),
          );

          return Right(connectionStatus);
        },
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, QuickConnectLoginResult>> login({
    required String address,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
    int? port,
  }) async {
    try {
      // 1. 检查网络连接
      final isConnected = await networkInfo.isConnected;
      
      if (!isConnected) {
        return const Left(NetworkFailure('网络不可用'));
      }

      // 2. 执行登录
      final loginResult = await remoteDataSource.login(
        address: address,
        username: username,
        password: password,
        otpCode: otpCode,
        rememberMe: rememberMe,
        port: port,
      );

      return loginResult.fold(
        (failure) => Left(failure),
        (loginResponse) async {
          if (loginResponse == null) {
            return const Left(ServerFailure('登录响应为空'));
          }

          // 3. 转换为领域实体
          final loginResult = QuickConnectLoginResult(
            isSuccess: loginResponse.isSuccess,
            sid: loginResponse.sid,
            errorMessage: loginResponse.errorMessage,
            redirectUrl: loginResponse.redirectUrl,
          );

          // 4. 如果登录成功且选择记住我，缓存凭据
          if (loginResult.isSuccess && rememberMe) {
            final credentials = LoginRequestModel(
              username: username,
              password: password,
              otpCode: otpCode,
              rememberMe: rememberMe,
            );
            await localDataSource.cacheCredentials(credentials);
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
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
  }) async {
    try {
      // 1. 解析地址
      final addressResult = await resolveAddress(quickConnectId);
      
      return addressResult.fold(
        (failure) => Left(failure),
        (serverInfo) async {
          // 2. 尝试登录
          final loginResult = await login(
            address: serverInfo.externalDomain,
            username: username,
            password: password,
            otpCode: otpCode,
            rememberMe: rememberMe,
            port: serverInfo.port,
          );

          return loginResult;
        },
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPerformanceStats() async {
    try {
      // 1. 尝试从远程获取最新统计
      final remoteResult = await remoteDataSource.getPerformanceStats();
      
      return remoteResult.fold(
        (failure) async {
          // 远程获取失败，尝试从本地获取缓存
          final cachedResult = await localDataSource.getCachedPerformanceStats();
          return cachedResult.fold(
            (cacheFailure) => Left(cacheFailure),
            (cachedStats) => cachedStats != null
                ? Right(cachedStats)
                : const Left(ServerFailure('无法获取性能统计')),
          );
        },
        (remoteStats) async {
          // 远程获取成功，缓存到本地
          await localDataSource.cachePerformanceStats(remoteStats);
          return Right(remoteStats);
        },
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> cleanupExpiredCache() async {
    try {
      final result = await localDataSource.cleanupExpiredCache();
      return result;
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCacheStats() async {
    try {
      final result = await localDataSource.getCacheStats();
      return result;
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  /// 处理意外错误
  Failure _handleUnexpectedError(Object error) {
    if (error is Failure) {
      return error;
    } else if (error is Exception) {
      return ServerFailure('服务器异常: $error');
    } else {
      return ServerFailure('未知错误: $error');
    }
  }
}
