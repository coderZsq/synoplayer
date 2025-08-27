import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../components/audio/presentation/services/audio_player_service.dart';
import '../auth/storage/storage_service.dart';
import '../auth/storage/auth_storage_service.dart';
import '../network/network_config.dart';
import '../network/global_dio_manager.dart';
import '../../quickconnect/domain/repositories/quick_connect_repository.dart';
import '../../quickconnect/data/repositories/quick_connect_repository_impl.dart';
import '../../quickconnect/domain/services/connection_manager.dart';
import '../../quickconnect/domain/usecases/login_usecase.dart';
import '../../components/audio/domain/usecases/get_song_list_usecase.dart';
import '../../quickconnect/presentation/services/quickconnect_service.dart';
import '../../components/audio/presentation/services/audio_service.dart';
import '../../components/audio/domain/repositories/audio_repository.dart';
import '../../components/audio/data/repositories/audio_repository_impl.dart';
import '../../components/audio/data/datasources/audio_datasource_local.dart';
import '../../components/audio/data/datasources/audio_datasource_remote.dart';
import '../../components/audio/domain/usecases/play_song_usecase.dart';

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
final quickConnectRepositoryProvider = Provider<QuickConnectRepository>((ref) {
  final globalDioManager = ref.watch(globalDioManagerProvider);
  return QuickConnectRepositoryImpl(globalDioManager);
});

/// 连接管理依赖
final connectionManagerProvider = Provider<ConnectionManager>((ref) {
  final repository = ref.watch(quickConnectRepositoryProvider);
  final globalDioManager = ref.watch(globalDioManagerProvider);
  return ConnectionManager(repository, globalDioManager);
});

/// 音频数据源依赖
final audioDatasourceLocalProvider = Provider<AudioDataSourceLocal>((ref) {
  final connectionManager = ref.watch(connectionManagerProvider);
  return AudioDataSourceLocal(connectionManager);
});

final audioDatasourceRemoteProvider = Provider<AudioDataSourceRemote>((ref) {
  final globalDioManager = ref.watch(globalDioManagerProvider);
  return AudioDataSourceRemote(globalDioManager.dio);
});

/// 音频仓库依赖
final audioRepositoryProvider = Provider<AudioRepository>((ref) {
  final authStorage = ref.watch(authStorageServiceProvider);
  final connectionManager = ref.watch(connectionManagerProvider);
  final dataSourceRemote = ref.watch(audioDatasourceRemoteProvider);
  final dataSourceLocal = ref.watch(audioDatasourceLocalProvider);
  return AudioRepositoryImpl(authStorage, connectionManager, dataSourceRemote, dataSourceLocal);
});

/// 用例层依赖
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(quickConnectRepositoryProvider);
  final connectionManager = ref.watch(connectionManagerProvider);
  return LoginUseCase(repository, connectionManager);
});

final getSongListUseCaseProvider = Provider<GetSongListUseCase>((ref) {
  final repository = ref.watch(audioRepositoryProvider);
  final authStorage = ref.watch(authStorageServiceProvider);
  final connectionManager = ref.watch(connectionManagerProvider);
  return GetSongListUseCase(repository, authStorage, connectionManager);
});

/// 服务层依赖
final quickConnectServiceProvider = Provider<QuickConnectService>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  return QuickConnectService(loginUseCase);
});

/// 音频播放服务依赖 - 确保单例
final audioPlayerServiceProvider = Provider<AudioPlayerService>((ref) {
  return AudioPlayerService();
});

/// 音频播放用例依赖
final playSongUseCaseProvider = Provider<PlaySongUseCase>((ref) {
  final audioRepository = ref.watch(audioRepositoryProvider);
  return PlaySongUseCase(audioRepository);
});

/// 音频服务依赖
final audioServiceProvider = Provider<AudioService>((ref) {
  final getSongListUseCase = ref.watch(getSongListUseCaseProvider);
  final playSongUseCase = ref.watch(playSongUseCaseProvider);
  final audioPlayerService = ref.watch(audioPlayerServiceProvider);
  return AudioService(getSongListUseCase, playSongUseCase, audioPlayerService);
});