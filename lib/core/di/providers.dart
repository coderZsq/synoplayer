import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../network/network_config.dart';
import '../network/api_factory.dart';
import '../../quickconnect/domain/repositories/quick_connect_repository.dart';
import '../../quickconnect/data/repositories/quick_connect_repository_impl.dart';
import '../../quickconnect/domain/usecases/login_usecase.dart';
import '../../quickconnect/presentation/services/quickconnect_service.dart';

/// 网络层依赖
final dioProvider = Provider<Dio>((ref) {
  return NetworkConfig.createDio();
});

final apiFactoryProvider = Provider<ApiFactory>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiFactoryImpl(dio);
});

/// 数据层依赖
final quickConnectRepositoryProvider = Provider<QuickConnectRepository>((ref) {
  final apiFactory = ref.watch(apiFactoryProvider);
  return QuickConnectRepositoryImpl(apiFactory);
});

/// 用例层依赖
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(quickConnectRepositoryProvider);
  return LoginUseCase(repository);
});

/// 服务层依赖
final quickConnectServiceProvider = Provider<QuickConnectService>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  return QuickConnectService(loginUseCase);
});