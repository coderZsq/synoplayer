import '../../domain/usecases/login_usecase.dart';
import '../../entities/auth_login/auth_login_response.dart';
import '../../../core/di/injection.dart';

class QuickConnectService {
  late final LoginUseCase _loginUseCase;

  QuickConnectService() {
    _loginUseCase = getIt<LoginUseCase>();
  }

  Future<LoginData> login({
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
