import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../quickconnect/domain/repositories/quick_connect_repository.dart';
import '../../quickconnect/domain/usecases/login_usecase.dart';
import '../../quickconnect/presentation/services/quickconnect_service.dart';
import 'injection.dart';

/// Riverpod Provider 桥接层
/// 将 GetIt 依赖注入与 Riverpod 状态管理连接

/// QuickConnect Repository Provider
final quickConnectRepositoryProvider = Provider<QuickConnectRepository>((ref) {
  return getIt<QuickConnectRepository>();
});

/// Login UseCase Provider
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return getIt<LoginUseCase>();
});

/// QuickConnect Service Provider
final quickConnectServiceProvider = Provider<QuickConnectService>((ref) {
  return getIt<QuickConnectService>();
});
