import 'package:dartz/dartz.dart';

import '../entities/quickconnect_entity.dart';
import '../repositories/quickconnect_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';

/// 增强的智能登录用例
/// 
/// 集成现有服务的智能登录逻辑
/// 包含地址解析、连接测试、智能登录等完整流程
class EnhancedSmartLoginUseCase {
  const EnhancedSmartLoginUseCase(this._repository);

  final QuickConnectRepository _repository;
  static const String _tag = 'EnhancedSmartLoginUseCase';

  /// 执行增强的智能登录
  /// 
  /// [quickConnectId] QuickConnect ID
  /// [username] 用户名
  /// [password] 密码
  /// [otpCode] 双因素认证码（可选）
  /// [rememberMe] 是否记住登录凭据
  /// [maxRetries] 最大重试次数
  /// 
  /// Returns: 成功时返回登录结果，失败时返回错误
  Future<Either<Failure, QuickConnectLoginResult>> execute({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
    int maxRetries = 3,
  }) async {
    try {
      AppLogger.userAction('开始增强智能登录流程', tag: _tag);
      AppLogger.info('QuickConnect ID: $quickConnectId', tag: _tag);
      AppLogger.info('用户名: $username', tag: _tag);
      AppLogger.info('最大重试次数: $maxRetries', tag: _tag);

      // 1. 输入验证
      final validationResult = _validateInput(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      if (validationResult.isLeft()) {
        return validationResult.map((_) => throw UnimplementedError());
      }

      // 2. 解析地址
      AppLogger.info('开始解析 QuickConnect 地址', tag: _tag);
      final addressResult = await _repository.resolveAddress(quickConnectId);
      
      return addressResult.fold(
        (failure) => Left(failure),
        (serverInfo) async {
          AppLogger.success('地址解析成功: ${serverInfo.externalDomain}', tag: _tag);
          
          // 3. 测试连接
          AppLogger.info('开始测试连接', tag: _tag);
          final connectionResult = await _repository.testConnection(
            serverInfo.externalDomain,
            port: serverInfo.port,
          );
          
          return connectionResult.fold(
            (connectionFailure) => Left(connectionFailure),
            (connectionStatus) async {
              if (!connectionStatus.isConnected) {
                AppLogger.warning('连接测试失败: ${connectionStatus.errorMessage}', tag: _tag);
                return Left(NetworkFailure('无法连接到服务器: ${connectionStatus.errorMessage}'));
              }
              
              AppLogger.success('连接测试成功', tag: _tag);
              
              // 4. 尝试登录
              AppLogger.info('开始尝试登录', tag: _tag);
              final loginResult = await _repository.login(
                address: serverInfo.externalDomain,
                username: username,
                password: password,
                otpCode: otpCode,
                rememberMe: rememberMe,
                port: serverInfo.port,
              );
              
              return loginResult.fold(
                (loginFailure) => Left(loginFailure),
                (loginResult) {
                  if (loginResult.isSuccess) {
                    AppLogger.success('登录成功！', tag: _tag);
                    AppLogger.info('服务器: ${serverInfo.externalDomain}', tag: _tag);
                    AppLogger.info('端口: ${serverInfo.port}', tag: _tag);
                  } else {
                    AppLogger.warning('登录失败: ${loginResult.errorMessage}', tag: _tag);
                  }
                  
                  return Right(loginResult);
                },
              );
            },
          );
        },
      );
    } catch (e) {
      AppLogger.error('增强智能登录异常: $e', tag: _tag);
      return Left(ServerFailure('智能登录异常: $e'));
    }
  }

  /// 执行带重试的智能登录
  /// 
  /// [quickConnectId] QuickConnect ID
  /// [username] 用户名
  /// [password] 密码
  /// [otpCode] 双因素认证码（可选）
  /// [rememberMe] 是否记住登录凭据
  /// [maxRetries] 最大重试次数
  /// [retryDelay] 重试延迟
  /// 
  /// Returns: 成功时返回登录结果，失败时返回错误
  Future<Either<Failure, QuickConnectLoginResult>> executeWithRetry({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) async {
    int attemptCount = 0;
    
    while (attemptCount < maxRetries) {
      attemptCount++;
      AppLogger.info('登录尝试 ${attemptCount}/$maxRetries', tag: _tag);
      
      final result = await execute(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
        rememberMe: rememberMe,
      );
      
      if (result.isRight()) {
        final loginResult = result.getOrElse(() => throw UnimplementedError());
        if (loginResult.isSuccess) {
          AppLogger.success('登录成功！尝试次数: $attemptCount', tag: _tag);
          return result;
        }
      }
      
      if (attemptCount < maxRetries) {
        AppLogger.info('等待 ${retryDelay.inSeconds} 秒后重试...', tag: _tag);
        await Future.delayed(retryDelay);
      }
    }
    
    AppLogger.error('达到最大重试次数，登录失败', tag: _tag);
    return const Left(ServerFailure('登录失败，已达到最大重试次数'));
  }

  /// 执行批量地址测试和智能登录
  /// 
  /// [quickConnectId] QuickConnect ID
  /// [username] 用户名
  /// [password] 密码
  /// [otpCode] 双因素认证码（可选）
  /// [rememberMe] 是否记住登录凭据
  /// 
  /// Returns: 成功时返回登录结果，失败时返回错误
  Future<Either<Failure, QuickConnectLoginResult>> executeWithMultipleAddresses({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
  }) async {
    try {
      AppLogger.info('开始多地址智能登录', tag: _tag);
      
      // 1. 解析地址
      final addressResult = await _repository.resolveAddress(quickConnectId);
      
      return addressResult.fold(
        (failure) => Left(failure),
        (primaryServerInfo) async {
          // 2. 尝试主地址
          AppLogger.info('尝试主地址: ${primaryServerInfo.externalDomain}', tag: _tag);
          final primaryLoginResult = await _tryLoginAtAddress(
            serverInfo: primaryServerInfo,
            username: username,
            password: password,
            otpCode: otpCode,
            rememberMe: rememberMe,
          );
          
          if (primaryLoginResult.isRight()) {
            final loginResult = primaryLoginResult.getOrElse(() => throw UnimplementedError());
            if (loginResult.isSuccess) {
              AppLogger.success('主地址登录成功！', tag: _tag);
              return primaryLoginResult;
            }
          }
          
          // 3. 如果主地址失败，尝试备用地址
          AppLogger.info('主地址登录失败，尝试备用地址', tag: _tag);
          
          // 这里可以添加备用地址的逻辑
          // 例如：尝试不同的端口、协议等
          
          // 4. 返回主地址的结果
          return primaryLoginResult;
        },
      );
    } catch (e) {
      AppLogger.error('多地址智能登录异常: $e', tag: _tag);
      return Left(ServerFailure('多地址智能登录异常: $e'));
    }
  }

  /// 在指定地址尝试登录
  Future<Either<Failure, QuickConnectLoginResult>> _tryLoginAtAddress({
    required QuickConnectServerInfo serverInfo,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
  }) async {
    try {
      // 1. 测试连接
      final connectionResult = await _repository.testConnection(
        serverInfo.externalDomain,
        port: serverInfo.port,
      );
      
      return connectionResult.fold(
        (connectionFailure) => Left(connectionFailure),
        (connectionStatus) async {
          if (!connectionStatus.isConnected) {
            return Left(NetworkFailure('无法连接到服务器: ${connectionStatus.errorMessage}'));
          }
          
          // 2. 尝试登录
          final loginResult = await _repository.login(
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
      return Left(ServerFailure('地址登录异常: $e'));
    }
  }

  /// 验证输入参数
  Either<Failure, void> _validateInput({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) {
    // 验证 QuickConnect ID
    if (quickConnectId.isEmpty) {
      return const Left(ValidationFailure('QuickConnect ID 不能为空'));
    }

    if (quickConnectId.length < 3) {
      return const Left(ValidationFailure('QuickConnect ID 长度不能少于3个字符'));
    }

    if (quickConnectId.length > 50) {
      return const Left(ValidationFailure('QuickConnect ID 长度不能超过50个字符'));
    }

    // 验证用户名
    if (username.isEmpty) {
      return const Left(ValidationFailure('用户名不能为空'));
    }

    if (username.length < 2) {
      return const Left(ValidationFailure('用户名长度不能少于2个字符'));
    }

    if (username.length > 50) {
      return const Left(ValidationFailure('用户名长度不能超过50个字符'));
    }

    // 验证密码
    if (password.isEmpty) {
      return const Left(ValidationFailure('密码不能为空'));
    }

    if (password.length < 6) {
      return const Left(ValidationFailure('密码长度不能少于6个字符'));
    }

    if (password.length > 128) {
      return const Left(ValidationFailure('密码长度不能超过128个字符'));
    }

    // 验证OTP码（如果提供）
    if (otpCode != null && otpCode.isNotEmpty) {
      if (otpCode.length != 6) {
        return const Left(ValidationFailure('OTP码必须是6位数字'));
      }

      if (!RegExp(r'^[0-9]{6}$').hasMatch(otpCode)) {
        return const Left(ValidationFailure('OTP码只能包含数字'));
      }
    }

    return const Right(null);
  }
}
