import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../components/audio/presentation/services/audio_player_service.dart';
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
import '../../components/audio/presentation/services/audio_service.dart';
import '../../components/audio/domain/repositories/audio_repository.dart';
import '../../components/audio/data/repositories/audio_repository_impl.dart';
import '../../components/audio/data/datasources/audio_datasource.dart';
import '../../components/audio/domain/usecases/play_song_usecase.dart';

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

/// 音频播放服务依赖 - 确保单例
final audioPlayerServiceProvider = Provider<AudioPlayerService>((ref) {
  return AudioPlayerService();
});

/// 音频数据源依赖
final audioDatasourceProvider = Provider<AudioDatasource>((ref) {
  final connectionManager = ref.watch(connectionManagerProvider);
  return AudioDatasource(connectionManager);
});

/// 音频仓库依赖
final audioRepositoryProvider = Provider<AudioRepository>((ref) {
  final audioDatasource = ref.watch(audioDatasourceProvider);
  return AudioRepositoryImpl(audioDatasource);
});

/// 音频播放用例依赖
final playSongUseCaseProvider = Provider<PlaySongUseCase>((ref) {
  final audioRepository = ref.watch(audioRepositoryProvider);
  return PlaySongUseCase(audioRepository);
});

/// 音频服务依赖
final audioServiceProvider = Provider<AudioService>((ref) {
  final playSongUseCase = ref.watch(playSongUseCaseProvider);
  final audioPlayerService = ref.watch(audioPlayerServiceProvider);
  return AudioService(playSongUseCase, audioPlayerService);
});