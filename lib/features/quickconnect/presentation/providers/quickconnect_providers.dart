import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

import '../../../../core/providers/network_providers.dart';
import '../../domain/entities/quickconnect_entity.dart';
import '../../domain/repositories/quickconnect_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/resolve_address_usecase.dart';
import '../../data/datasources/quickconnect_local_datasource.dart';
import '../../data/datasources/quickconnect_remote_datasource.dart';
import '../../data/repositories/quickconnect_repository_impl.dart';

part 'quickconnect_providers.g.dart';

// ==================== 数据源 Providers ====================

/// 本地数据源 Provider
@riverpod
QuickConnectLocalDataSource localDataSource(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  
  return QuickConnectLocalDataSourceImpl(
    sharedPreferences: sharedPreferences.valueOrNull!,
    secureStorage: secureStorage,
  );
}

/// 远程数据源 Provider
@riverpod
QuickConnectRemoteDataSource remoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  
  return QuickConnectRemoteDataSourceImpl(
    dio: dio,
    networkInfo: networkInfo,
  );
}

// ==================== 仓库 Provider ====================

/// QuickConnect 仓库 Provider
@riverpod
QuickConnectRepository quickConnectRepository(Ref ref) {
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  final localDataSource = ref.watch(localDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  
  return QuickConnectRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    networkInfo: networkInfo,
  );
}

// ==================== 用例 Providers ====================

/// 地址解析用例 Provider
@riverpod
ResolveAddressUseCase resolveAddressUseCase(Ref ref) {
  final repository = ref.watch(quickConnectRepositoryProvider);
  return ResolveAddressUseCase(repository);
}

/// 登录用例 Provider
@riverpod
LoginUseCase loginUseCase(Ref ref) {
  final repository = ref.watch(quickConnectRepositoryProvider);
  return LoginUseCase(repository);
}

/// 智能登录用例 Provider
@riverpod
SmartLoginUseCase smartLoginUseCase(Ref ref) {
  final repository = ref.watch(quickConnectRepositoryProvider);
  return SmartLoginUseCase(repository);
}

// ==================== 状态管理 Providers ====================

/// 地址解析状态管理
@riverpod
class AddressResolutionNotifier extends _$AddressResolutionNotifier {
  @override
  Future<QuickConnectServerInfo?> build() async {
    return null;
  }

  /// 解析 QuickConnect 地址
  Future<void> resolveAddress(String quickConnectId) async {
    state = const AsyncValue.loading();
    
    try {
      final useCase = ref.read(resolveAddressUseCaseProvider);
      final result = await useCase.execute(quickConnectId);
      
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (serverInfo) => state = AsyncValue.data(serverInfo),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 清除地址解析状态
  void clearAddress() {
    state = const AsyncValue.data(null);
  }
}

/// 登录状态管理
@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  Future<QuickConnectLoginResult?> build() async {
    return null;
  }

  /// 执行登录
  Future<void> login({
    required String address,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
    int? port,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final useCase = ref.read(loginUseCaseProvider);
      final result = await useCase.execute(
        address: address,
        username: username,
        password: password,
        otpCode: otpCode,
        rememberMe: rememberMe,
        port: port,
      );
      
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (loginResult) => state = AsyncValue.data(loginResult),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 执行智能登录
  Future<void> smartLogin({
    required String quickConnectId,
    required String username,
    required String password,
    String? otpCode,
    bool rememberMe = false,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final useCase = ref.read(smartLoginUseCaseProvider);
      final result = await useCase.execute(
        quickConnectId: quickConnectId,
        username: username,
        password: password,
        otpCode: otpCode,
        rememberMe: rememberMe,
      );
      
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (loginResult) => state = AsyncValue.data(loginResult),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 清除登录状态
  void clearLogin() {
    state = const AsyncValue.data(null);
  }
}

/// 连接测试状态管理
@riverpod
class ConnectionTestNotifier extends _$ConnectionTestNotifier {
  @override
  Future<QuickConnectConnectionStatus?> build() async {
    return null;
  }

  /// 测试连接
  Future<void> testConnection(String address, {int? port}) async {
    state = const AsyncValue.loading();
    
    try {
      final repository = ref.read(quickConnectRepositoryProvider);
      final result = await repository.testConnection(address, port: port);
      
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (connectionStatus) => state = AsyncValue.data(connectionStatus),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 清除连接测试状态
  void clearConnectionTest() {
    state = const AsyncValue.data(null);
  }
}

/// 缓存管理状态
@riverpod
class CacheManagementNotifier extends _$CacheManagementNotifier {
  @override
  Future<Map<String, dynamic>?> build() async {
    return null;
  }

  /// 清理过期缓存
  Future<void> cleanupExpiredCache() async {
    state = const AsyncValue.loading();
    
    try {
      final repository = ref.read(quickConnectRepositoryProvider);
      final result = await repository.cleanupExpiredCache();
      
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (success) async {
          if (success) {
            // 获取更新后的缓存统计
            final statsResult = await repository.getCacheStats();
            statsResult.fold(
              (failure) => state = AsyncValue.error(failure, StackTrace.current),
              (stats) => state = AsyncValue.data(stats),
            );
          } else {
            state = const AsyncValue.data(null);
          }
        },
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 获取缓存统计
  Future<void> getCacheStats() async {
    state = const AsyncValue.loading();
    
    try {
      final repository = ref.read(quickConnectRepositoryProvider);
      final result = await repository.getCacheStats();
      
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (stats) => state = AsyncValue.data(stats),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 清除缓存统计状态
  void clearCacheStats() {
    state = const AsyncValue.data(null);
  }
}

// ==================== 辅助 Providers ====================

/// 共享偏好设置 Provider
@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}

/// 安全存储 Provider
@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

/// Dio 客户端 Provider
@riverpod
Dio dio(Ref ref) {
  final dio = Dio();
  
  // 基础配置
  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  return dio;
}
