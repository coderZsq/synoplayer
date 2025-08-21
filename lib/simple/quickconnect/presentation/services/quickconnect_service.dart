import '../../domain/usecases/login_usecase.dart';
import '../../data/repositories/quick_connect_repository_impl.dart';
import '../../entities/get_server_info_response.dart';

class QuickConnectService2 {
  late final LoginUseCase _loginUseCase;

  QuickConnectService2() {
    _loginUseCase = LoginUseCase(QuickConnectRepositoryImpl());
  }

  Future<GetServerInfoResponse> login({
    required String quickConnectId,
    required String username,
    required String password,
    String? optCode,
  }) async {
    return await _loginUseCase(
      quickConnectId: quickConnectId,
      username: username,
      password: username,
      optCode: username,
    );
  }
}
