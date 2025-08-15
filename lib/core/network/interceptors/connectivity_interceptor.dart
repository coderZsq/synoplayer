import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../utils/logger.dart';

/// 网络连接拦截器
class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor({required this.connectivity});

  final Connectivity connectivity;
  static const String _tag = 'ConnectivityInterceptor';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 检查网络连接状态
    final connectivityResults = await connectivity.checkConnectivity();
    
    // 检查是否没有网络连接  
    // connectivity_plus 在新版本中返回的是 List<ConnectivityResult>
    final hasNoConnection = connectivityResults is List
        ? (connectivityResults as List<ConnectivityResult>).every((result) => result == ConnectivityResult.none)
        : connectivityResults == ConnectivityResult.none;
    
    if (hasNoConnection) {
      AppLogger.error('网络连接不可用', tag: _tag);
      
      // 创建网络不可用的错误
      final error = DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        message: '网络连接不可用',
      );
      
      handler.reject(error);
      return;
    }
    
    AppLogger.debug('网络连接正常: $connectivityResults', tag: _tag);
    handler.next(options);
  }
}
