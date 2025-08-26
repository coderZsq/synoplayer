import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../auth/storage/storage_service.dart';
import '../auth/storage/auth_storage_service.dart';
import '../network/network_config.dart';
import '../network/api_factory.dart';
import '../../quickconnect/domain/repositories/quick_connect_repository.dart';
import '../../quickconnect/data/repositories/quick_connect_repository_impl.dart';
import '../../quickconnect/domain/services/connection_manager.dart';
import '../../quickconnect/domain/usecases/login_usecase.dart';
import '../../quickconnect/domain/usecases/get_song_list_usecase.dart';
import '../../quickconnect/presentation/services/quickconnect_service.dart';

/// 网络层依赖
final dioProvider = Provider<Dio>((ref) {
  return NetworkConfig.createDio();
});

final apiFactoryProvider = Provider<ApiFactory>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiFactoryImpl(dio);
});

/// 存储层依赖
final authStorageServiceProvider = Provider<AuthStorageService>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return AuthStorageService(storage);
});

/// 数据层依赖
final quickConnectRepositoryProvider = Provider<QuickConnectRepository>((ref) {
  final apiFactory = ref.watch(apiFactoryProvider);
  final authStorage = ref.watch(authStorageServiceProvider);
  return QuickConnectRepositoryImpl(apiFactory, authStorage);
});

/// 连接管理依赖
final connectionManagerProvider = Provider<ConnectionManager>((ref) {
  final repository = ref.watch(quickConnectRepositoryProvider);
  return ConnectionManager(repository);
});

/// 用例层依赖
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(quickConnectRepositoryProvider);
  final connectionManager = ref.watch(connectionManagerProvider);
  return LoginUseCase(repository, connectionManager);
});

final getSongListUseCaseProvider = Provider<GetSongListUseCase>((ref) {
  final repository = ref.watch(quickConnectRepositoryProvider);
  final authStorage = ref.watch(authStorageServiceProvider);
  final connectionManager = ref.watch(connectionManagerProvider);
  return GetSongListUseCase(repository, authStorage, connectionManager);
});

/// 服务层依赖
final quickConnectServiceProvider = Provider<QuickConnectService>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final getSongListUseCase = ref.watch(getSongListUseCaseProvider);
  return QuickConnectService(
    loginUseCase,
    getSongListUseCase,
  );
});