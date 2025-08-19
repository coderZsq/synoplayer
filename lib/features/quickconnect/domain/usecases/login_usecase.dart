import 'package:dartz/dartz.dart';

import '../entities/quickconnect_entity.dart';
import '../repositories/quickconnect_repository.dart';
import '../../../../core/error/failures.dart';

/// 登录用例
/// 
/// 负责协调登录的业务逻辑
/// 包含输入验证、业务规则和错误处理
class LoginUseCase {
  const LoginUseCase(this._repository);

  final QuickConnectRepository _repository;

  /// 执行登录
  /// 
  /// [address] 服务器地址
  /// [username] 用户名
  /// [password] 密码
  /// [otpCode] 双因素认证码（可选）
  /// [rememberMe] 是否记住登录凭据
  /// [port] 服务器端口（可选）
  /// 
  /// Returns: 成功时返回登录结果，失败时返回错误
  Future<Either<Failure, QuickConnectLoginResult>> execute({
    required String address,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
    int? port,
  }) async {
    try {
      // 1. 输入验证
      final validationResult = _validateInput(
        address: address,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      if (validationResult.isLeft()) {
        return validationResult.map((_) => throw UnimplementedError());
      }

      // 2. 执行业务逻辑
      final result = await _repository.login(
        address: address,
        username: username,
        password: password,
        otpCode: otpCode,
        rememberMe: rememberMe,
        port: port,
      );

      // 3. 后处理验证
      return result.fold(
        (failure) => Left(failure),
        (loginResult) => _validateLoginResult(loginResult),
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  /// 验证输入参数
  Either<Failure, void> _validateInput({
    required String address,
    required String username,
    required String password,
    String? otpCode,
  }) {
    // 验证服务器地址
    if (address.isEmpty) {
      return const Left(ValidationFailure('服务器地址不能为空'));
    }

    if (!_isValidUrl(address)) {
      return const Left(ValidationFailure('服务器地址格式无效'));
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

  /// 验证登录结果
  Either<Failure, QuickConnectLoginResult> _validateLoginResult(
    QuickConnectLoginResult loginResult,
  ) {
    if (!loginResult.isValid) {
      return const Left(
        ValidationFailure('登录结果无效，缺少必要信息'),
      );
    }

    return Right(loginResult);
  }

  /// 验证URL格式
  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.hasAuthority;
    } catch (e) {
      return false;
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

/// 智能登录用例
/// 
/// 自动选择最佳登录方式的用例
class SmartLoginUseCase {
  const SmartLoginUseCase(this._repository);

  final QuickConnectRepository _repository;

  /// 执行智能登录
  /// 
  /// [quickConnectId] QuickConnect ID
  /// [username] 用户名
  /// [password] 密码
  /// [otpCode] 双因素认证码（可选）
  /// [rememberMe] 是否记住登录凭据
  /// 
  /// Returns: 成功时返回登录结果，失败时返回错误
  Future<Either<Failure, QuickConnectLoginResult>> execute({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
  }) async {
    try {
      // 1. 输入验证（复用基本验证逻辑）
      final loginUseCase = LoginUseCase(_repository);
      final validationResult = await loginUseCase.execute(
        address: quickConnectId, // 临时使用 quickConnectId 作为地址
        username: username,
        password: password,
        otpCode: otpCode,
        rememberMe: rememberMe,
      );

      if (validationResult.isLeft()) {
        return validationResult;
      }

      // 2. 执行智能登录
      final result = await _repository.smartLogin(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
        rememberMe: rememberMe,
      );

      // 3. 后处理验证
      return result.fold(
        (failure) => Left(failure),
        (loginResult) => _validateLoginResult(loginResult),
      );
    } catch (e) {
      return Left(_handleUnexpectedError(e));
    }
  }

  /// 验证登录结果
  Either<Failure, QuickConnectLoginResult> _validateLoginResult(
    QuickConnectLoginResult loginResult,
  ) {
    if (!loginResult.isValid) {
      return const Left(
        ValidationFailure('智能登录结果无效，缺少必要信息'),
      );
    }

    return Right(loginResult);
  }

  /// 处理未预期的错误
  Failure _handleUnexpectedError(Object error) {
    if (error is Exception) {
      return ServerFailure('智能登录服务器异常: ${error.toString()}');
    }

    return UnknownFailure('智能登录未知错误: ${error.toString()}');
  }
}
