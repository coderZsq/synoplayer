import '../../domain/usecases/login_usecase.dart';
import '../../data/repositories/quick_connect_repository_impl.dart';
import '../../entities/auth_login/auth_login_response.dart';

class QuickConnectService {
  late final LoginUseCase _loginUseCase;

  QuickConnectService() {
    _loginUseCase = LoginUseCase(QuickConnectRepositoryImpl());
  }

  Future<AuthLoginResponse?> login({
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
