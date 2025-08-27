import '../../domain/usecases/login_usecase.dart';
import '../../entities/auth_login/auth_login_response.dart';
import '../../../../base/error/result.dart';

class LoginService {
  final LoginUseCase _loginUseCase;

  LoginService(
    this._loginUseCase,
  );

  /// 登录功能
  Future<Result<LoginData>> login({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    return await _loginUseCase(
      quickConnectId: quickConnectId,
      username: username,
      password: password,
      otpCode: otpCode,
    );
  }
}
