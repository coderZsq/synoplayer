import 'package:connectivity_plus/connectivity_plus.dart';

/// 网络信息接口
/// 
/// 提供网络连接状态的检查功能
abstract class NetworkInfo {
  /// 检查是否有网络连接
  Future<bool> get isConnected;
  
  /// 获取网络类型
  Future<ConnectivityResult> get connectivityResult;
  
  /// 监听网络状态变化
  Stream<ConnectivityResult> get onConnectivityChanged;
}

/// 网络信息实现
class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<ConnectivityResult> get connectivityResult async {
    return await _connectivity.checkConnectivity();
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }
}
