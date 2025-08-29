import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../components/audio/presentation/services/audio_player_service.dart';
import '../../components/login/domain/repositories/login_repository.dart';
import '../../components/login/domain/services/connection_manager.dart';
import '../auth/storage/storage_service.dart';
import '../auth/storage/auth_storage_service.dart';
import '../network/network_config.dart';
import '../network/global_dio_manager.dart';
import '../../components/login/data/repositories/login_repository_impl.dart';
import '../../components/login/domain/usecases/login_usecase.dart';
import '../../components/login/domain/usecases/logout_usecase.dart';
import '../../components/audio/domain/usecases/get_audio_list_usecase.dart';
import '../../components/login/presentation/services/login_service.dart';
import '../../components/audio/presentation/services/audio_service.dart';
import '../../components/audio/domain/repositories/audio_repository.dart';
import '../../components/audio/data/repositories/audio_repository_impl.dart';
import '../../components/audio/data/datasources/audio_datasource_local.dart';
import '../../components/audio/data/datasources/audio_datasource_remote.dart';
import '../../components/audio/domain/usecases/play_audio_usecase.dart';

/// 网络层依赖
final dioProvider = Provider<Dio>((ref) {
  return NetworkConfig.createDio();
});

/// 全局 Dio 管理器
final globalDioManagerProvider = Provider<GlobalDioManager>((ref) {
  final manager = GlobalDioManager();
  final dio = ref.watch(dioProvider);
  manager.initialize(dio);
  return manager;
});

/// 存储层依赖
final authStorageServiceProvider = Provider<AuthStorageService>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return AuthStorageService(storage);
});

/// 数据层依赖
final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final globalDioManager = ref.watch(globalDioManagerProvider);
  return LoginRepositoryImpl(globalDioManager);
});

/// 连接管理依赖
final connectionManagerProvider = Provider<ConnectionManager>((ref) {
  final repository = ref.watch(loginRepositoryProvider);
  final globalDioManager = ref.watch(globalDioManagerProvider);
  return ConnectionManager(repository, globalDioManager);
});

/// 音频数据源依赖
final audioDataSourceLocalProvider = Provider<AudioDataSourceLocal>((ref) {
  final connectionManager = ref.watch(connectionManagerProvider);
  return AudioDataSourceLocal(connectionManager);
});

final audioDataSourceRemoteProvider = Provider<AudioDataSourceRemote>((ref) {
  final globalDioManager = ref.watch(globalDioManagerProvider);
  return AudioDataSourceRemote(globalDioManager.dio);
});

/// 音频仓库依赖
final audioRepositoryProvider = Provider<AudioRepository>((ref) {
  final authStorage = ref.watch(authStorageServiceProvider);
  final connectionManager = ref.watch(connectionManagerProvider);
  final dataSourceRemote = ref.watch(audioDataSourceRemoteProvider);
  final dataSourceLocal = ref.watch(audioDataSourceLocalProvider);
  return AudioRepositoryImpl(authStorage, connectionManager, dataSourceRemote, dataSourceLocal);
});

/// 用例层依赖
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(loginRepositoryProvider);
  final connectionManager = ref.watch(connectionManagerProvider);
  return LoginUseCase(repository, connectionManager);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(loginRepositoryProvider);
  final connectionManager = ref.watch(connectionManagerProvider);
  return LogoutUseCase(repository, connectionManager);
});

final getSongListUseCaseProvider = Provider<GetAudioListUseCase>((ref) {
  final repository = ref.watch(audioRepositoryProvider);
  final authStorage = ref.watch(authStorageServiceProvider);
  final connectionManager = ref.watch(connectionManagerProvider);
  return GetAudioListUseCase(repository, authStorage, connectionManager);
});

/// 服务层依赖
final loginServiceProvider = Provider<LoginService>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final logoutUseCase = ref.watch(logoutUseCaseProvider);
  return LoginService(loginUseCase, logoutUseCase);
});

/// 音频播放服务依赖 - 确保单例
final audioPlayerServiceProvider = Provider<AudioPlayerService>((ref) {
  return AudioPlayerService();
});

/// 音频播放用例依赖
final playSongUseCaseProvider = Provider<PlayAudioUseCase>((ref) {
  final audioRepository = ref.watch(audioRepositoryProvider);
  return PlayAudioUseCase(audioRepository);
});

/// 音频服务依赖
final audioServiceProvider = Provider<AudioService>((ref) {
  final getSongListUseCase = ref.watch(getSongListUseCaseProvider);
  final playSongUseCase = ref.watch(playSongUseCaseProvider);
  final audioPlayerService = ref.watch(audioPlayerServiceProvider);
  return AudioService(getSongListUseCase, playSongUseCase, audioPlayerService);
});