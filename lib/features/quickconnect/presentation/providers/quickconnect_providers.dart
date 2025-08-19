import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/quickconnect_entity.dart';
import '../../domain/repositories/quickconnect_repository.dart';
import '../../domain/usecases/resolve_address_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../data/repositories/quickconnect_repository_impl.dart';
import '../../data/datasources/quickconnect_remote_datasource.dart';
import '../../data/datasources/quickconnect_local_datasource.dart';
import '../../../../core/providers/network_providers.dart';

part 'quickconnect_providers.g.dart';

/// QuickConnect 仓库 Provider
@riverpod
QuickConnectRepository quickConnectRepository(Ref ref) {
  final remoteDataSource = ref.watch(quickConnectRemoteDataSourceProvider);
  final localDataSource = ref.watch(quickConnectLocalDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  
  return QuickConnectRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    networkInfo: networkInfo,
  );
}

/// QuickConnect 远程数据源 Provider
@riverpod
QuickConnectRemoteDataSource quickConnectRemoteDataSource(Ref ref) {
  // 这里应该返回具体的远程数据源实现
  // 暂时返回一个空的实现，需要根据现有代码重构
  throw UnimplementedError('需要实现具体的远程数据源');
}

/// QuickConnect 本地数据源 Provider
@riverpod
QuickConnectLocalDataSource quickConnectLocalDataSource(Ref ref) {
  // 这里应该返回具体的本地数据源实现
  // 暂时返回一个空的实现，需要根据现有代码重构
  throw UnimplementedError('需要实现具体的本地数据源');
}

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

/// 地址解析状态 Provider
@riverpod
class AddressResolutionNotifier extends _$AddressResolutionNotifier {
  @override
  Future<QuickConnectServerInfo?> build() async {
    return null;
  }

  /// 解析地址
  Future<void> resolveAddress(String quickConnectId) async {
    if (quickConnectId.isEmpty) return;
    
    state = const AsyncLoading();
    
    try {
      final useCase = ref.read(resolveAddressUseCaseProvider);
      final result = await useCase.call(quickConnectId);
      
      result.fold(
        (failure) => state = AsyncError(failure, StackTrace.current),
        (serverInfo) => state = AsyncData(serverInfo),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// 清除状态
  void clear() {
    state = const AsyncData(null);
  }
}

/// 登录状态 Provider
@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  Future<QuickConnectLoginResult?> build() async {
    return null;
  }

  /// 执行登录
  Future<void> login({
    required String serverUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    state = const AsyncLoading();
    
    try {
      final useCase = ref.read(loginUseCaseProvider);
      final result = await useCase.call(
        serverUrl: serverUrl,
        username: username,
        password: password,
        otpCode: otpCode,
      );
      
      result.fold(
        (failure) => state = AsyncError(failure, StackTrace.current),
        (loginResult) => state = AsyncData(loginResult),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// 执行智能登录
  Future<void> smartLogin({
    required String serverUrl,
    required String username,
    required String password,
  }) async {
    state = const AsyncLoading();
    
    try {
      final useCase = ref.read(smartLoginUseCaseProvider);
      final result = await useCase.call(
        serverUrl: serverUrl,
        username: username,
        password: password,
      );
      
      result.fold(
        (failure) => state = AsyncError(failure, StackTrace.current),
        (loginResult) => state = AsyncData(loginResult),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// 清除登录状态
  void clear() {
    state = const AsyncData(null);
  }
}

/// 连接测试状态 Provider
@riverpod
class ConnectionTestNotifier extends _$ConnectionTestNotifier {
  @override
  Future<QuickConnectConnectionStatus?> build() async {
    return null;
  }

  /// 测试连接
  Future<void> testConnection(String serverUrl) async {
    if (serverUrl.isEmpty) return;
    
    state = const AsyncLoading();
    
    try {
      final repository = ref.read(quickConnectRepositoryProvider);
      final result = await repository.testConnection(serverUrl);
      
      result.fold(
        (failure) => state = AsyncError(failure, StackTrace.current),
        (connectionStatus) => state = AsyncData(connectionStatus),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// 清除状态
  void clear() {
    state = const AsyncData(null);
  }
}

/// 连接历史 Provider
@riverpod
class ConnectionHistoryNotifier extends _$ConnectionHistoryNotifier {
  @override
  Future<List<QuickConnectServerInfo>> build() async {
    try {
      final repository = ref.read(quickConnectRepositoryProvider);
      final result = await repository.getConnectionHistory();
      
      return result.fold(
        (failure) => throw failure,
        (history) => history,
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return [];
    }
  }

  /// 添加连接历史
  Future<void> addConnectionHistory(QuickConnectServerInfo serverInfo) async {
    try {
      final repository = ref.read(quickConnectRepositoryProvider);
      final result = await repository.saveConnectionHistory(serverInfo);
      
      return result.fold(
        (failure) => throw failure,
        (_) => ref.invalidateSelf(),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// 清除连接历史
  Future<void> clearConnectionHistory() async {
    try {
      final repository = ref.read(quickConnectRepositoryProvider);
      final result = await repository.clearConnectionHistory();
      
      return result.fold(
        (failure) => throw failure,
        (_) => ref.invalidateSelf(),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

/// 网络连接状态 Provider
@riverpod
class NetworkConnectivityNotifier extends _$NetworkConnectivityNotifier {
  @override
  Future<bool> build() async {
    try {
      final repository = ref.read(quickConnectRepositoryProvider);
      final result = await repository.checkNetworkConnectivity();
      
      return result.fold(
        (failure) => throw failure,
        (isConnected) => isConnected,
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }

  /// 刷新网络状态
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// 性能统计 Provider
@riverpod
class PerformanceStatsNotifier extends _$PerformanceStatsNotifier {
  @override
  Future<Map<String, dynamic>> build() async {
    try {
      final repository = ref.read(quickConnectRepositoryProvider);
      final result = await repository.getPerformanceStats();
      
      return result.fold(
        (failure) => throw failure,
        (stats) => stats,
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return {};
    }
  }

  /// 刷新性能统计
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
