import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../network/network_info.dart';

part 'network_providers.g.dart';

/// 网络信息 Provider
@riverpod
NetworkInfo networkInfo(Ref ref) {
  return NetworkInfoImpl(Connectivity());
}

/// 网络连接状态 Provider
@riverpod
Stream<bool> networkConnectivity(Ref ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  return networkInfo.onConnectivityChanged.map(
    (result) => result != ConnectivityResult.none,
  );
}

/// 当前网络连接状态 Provider
@riverpod
Future<bool> isNetworkConnected(Ref ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  return networkInfo.isConnected;
}
