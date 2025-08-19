import 'package:dartz/dartz.dart';

import '../entities/quickconnect_entity.dart';
import '../repositories/quickconnect_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

/// 地址解析用例
/// 
/// 负责协调地址解析的业务逻辑
/// 包含输入验证、业务规则和错误处理
class ResolveAddressUseCase {
  const ResolveAddressUseCase(this._repository);

  final QuickConnectRepository _repository;

  /// 执行地址解析
  /// 
  /// [quickConnectId] QuickConnect ID
  /// 
  /// Returns: 成功时返回服务器信息，失败时返回错误
  Future<Either<Failure, QuickConnectServerInfo>> call(
    String quickConnectId,
  ) async {
    try {
      // 1. 输入验证
      final validationResult = _validateInput(quickConnectId);
      if (validationResult.isLeft()) {
        return validationResult.map((_) => throw UnimplementedError());
      }

      // 2. 执行业务逻辑
      final result = await _repository.resolveAddress(quickConnectId);

      // 3. 后处理验证
      return result.fold(
        (failure) => Left(failure),
        (serverInfo) => _validateServerInfo(serverInfo),
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  /// 验证输入参数
  Either<Failure, void> _validateInput(String quickConnectId) {
    if (quickConnectId.isEmpty) {
      return const Left(ValidationFailure('QuickConnect ID 不能为空'));
    }

    if (quickConnectId.length < 3) {
      return const Left(ValidationFailure('QuickConnect ID 长度不能少于3个字符'));
    }

    if (quickConnectId.length > 50) {
      return const Left(ValidationFailure('QuickConnect ID 长度不能超过50个字符'));
    }

    // 检查是否包含非法字符
    final validPattern = RegExp(r'^[a-zA-Z0-9_-]+$');
    if (!validPattern.hasMatch(quickConnectId)) {
      return const Left(
        ValidationFailure('QuickConnect ID 只能包含字母、数字、下划线和连字符'),
      );
    }

    return const Right(null);
  }

  /// 验证服务器信息
  Either<Failure, QuickConnectServerInfo> _validateServerInfo(
    QuickConnectServerInfo serverInfo,
  ) {
    if (!serverInfo.isValid) {
      return const Left(
        ValidationFailure('服务器信息无效，缺少必要字段'),
      );
    }

    if (!serverInfo.isOnline) {
      return const Left(
        ServerFailure('服务器当前离线，无法连接'),
      );
    }

    return Right(serverInfo);
  }

  /// 处理未预期的错误
  Failure _handleUnexpectedError(Object error) {
    if (error is Exception) {
      return ServerFailure('服务器异常: ${error.toString()}');
    }

    return UnknownFailure('未知错误: ${error.toString()}');
  }
}
