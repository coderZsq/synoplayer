import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../network/network_config.dart';
import '../network/api_factory.dart';
import '../../quickconnect/domain/repositories/quick_connect_repository.dart';
import '../../quickconnect/data/repositories/quick_connect_repository_impl.dart';
import '../../quickconnect/domain/usecases/login_usecase.dart';

/// 全局服务定位器实例
final GetIt getIt = GetIt.instance;

/// 初始化所有依赖注入
Future<void> setupDependencies() async {
  // 注册网络层
  getIt.registerLazySingleton<Dio>(() => NetworkConfig.createDio());
  
  // 注册 API Factory
  getIt.registerLazySingleton<ApiFactory>(() => ApiFactoryImpl(getIt<Dio>()));
  
  // 注册仓库层
  getIt.registerLazySingleton<QuickConnectRepository>(() => 
    QuickConnectRepositoryImpl(getIt<ApiFactory>()));
  
  // 注册用例层
  getIt.registerLazySingleton<LoginUseCase>(() => 
    LoginUseCase(getIt<QuickConnectRepository>()));
}

/// 清理所有依赖（主要用于测试）
Future<void> resetDependencies() async {
  await getIt.reset();
}
