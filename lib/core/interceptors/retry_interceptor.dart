import 'package:dio/dio.dart';

/// 重试拦截器配置
class RetryInterceptorConfig {
  /// 最大重试次数
  final int maxRetries;
  
  /// 基础延迟时间（毫秒）
  final int baseDelayMs;
  
  /// 最大延迟时间（毫秒）
  final int maxDelayMs;
  
  /// 延迟时间增长因子
  final double backoffMultiplier;
  
  /// 是否使用指数退避
  final bool useExponentialBackoff;
  
  /// 可重试的状态码
  final List<int> retryableStatusCodes;
  
  /// 可重试的异常类型
  final List<Type> retryableExceptionTypes;
  
  const RetryInterceptorConfig({
    this.maxRetries = 3,
    this.baseDelayMs = 1000,
    this.maxDelayMs = 10000,
    this.backoffMultiplier = 2.0,
    this.useExponentialBackoff = true,
    this.retryableStatusCodes = const [500, 502, 503, 504],
    this.retryableExceptionTypes = const [DioException],
  });
  
  /// 默认重试配置
  static const RetryInterceptorConfig defaultConfig = RetryInterceptorConfig();
  
  /// 网络错误重试配置
  static const RetryInterceptorConfig networkConfig = RetryInterceptorConfig(
    maxRetries: 3,
    baseDelayMs: 2000,
    maxDelayMs: 15000,
    backoffMultiplier: 2.0,
    useExponentialBackoff: true,
    retryableStatusCodes: [500, 502, 503, 504],
    retryableExceptionTypes: [DioException],
  );
  
  /// 服务器错误重试配置
  static const RetryInterceptorConfig serverConfig = RetryInterceptorConfig(
    maxRetries: 2,
    baseDelayMs: 5000,
    maxDelayMs: 20000,
    backoffMultiplier: 1.5,
    useExponentialBackoff: true,
    retryableStatusCodes: [500, 502, 503, 504],
    retryableExceptionTypes: [DioException],
  );
}

/// 重试拦截器
class RetryInterceptor extends Interceptor {
  final RetryInterceptorConfig _config;
  
  RetryInterceptor([this._config = RetryInterceptorConfig.defaultConfig]);
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!_shouldRetry(err)) {
      handler.next(err);
      return;
    }
    
    // 尝试重试
    final result = await _retryRequest(err, handler);
    if (result != null) {
      handler.resolve(result);
    } else {
      handler.next(err);
    }
  }
  
  /// 判断是否应该重试
  bool _shouldRetry(DioException err) {
    // 检查重试次数
    final retryCount = _getRetryCount(err.requestOptions);
    if (retryCount >= _config.maxRetries) {
      return false;
    }
    
    // 检查状态码
    if (err.response?.statusCode != null) {
      if (!_config.retryableStatusCodes.contains(err.response!.statusCode)) {
        return false;
      }
    }
    
    // 检查异常类型
    if (!_config.retryableExceptionTypes.contains(err.runtimeType)) {
      return false;
    }
    
    // 检查是否为致命错误
    if (_isFatalError(err)) {
      return false;
    }
    
    return true;
  }
  
  /// 判断是否为致命错误
  bool _isFatalError(DioException err) {
    // 4xx 客户端错误通常不应该重试
    if (err.response?.statusCode != null) {
      final statusCode = err.response!.statusCode!;
      if (statusCode >= 400 && statusCode < 500) {
        return true;
      }
    }
    
    // 取消的请求不应该重试
    if (err.type == DioExceptionType.cancel) {
      return true;
    }
    
    return false;
  }
  
  /// 获取重试次数
  int _getRetryCount(RequestOptions options) {
    return options.extra['retryCount'] ?? 0;
  }
  
  /// 设置重试次数
  void _setRetryCount(RequestOptions options, int count) {
    options.extra['retryCount'] = count;
  }
  
  /// 重试请求
  Future<Response?> _retryRequest(
    DioException err, 
    ErrorInterceptorHandler handler,
  ) async {
    final retryCount = _getRetryCount(err.requestOptions) + 1;
    _setRetryCount(err.requestOptions, retryCount);
    
    // 计算延迟时间
    final delay = _calculateDelay(retryCount);
    
    // 等待延迟时间
    await Future.delayed(Duration(milliseconds: delay));
    
    try {
      // 创建新的请求选项
      final options = Options(
        method: err.requestOptions.method,
        headers: err.requestOptions.headers,
        responseType: err.requestOptions.responseType,
        validateStatus: err.requestOptions.validateStatus,
        receiveDataWhenStatusError: err.requestOptions.receiveDataWhenStatusError,
        extra: err.requestOptions.extra,
        contentType: err.requestOptions.contentType,
        followRedirects: err.requestOptions.followRedirects,
        maxRedirects: err.requestOptions.maxRedirects,
        requestEncoder: err.requestOptions.requestEncoder,
        responseDecoder: err.requestOptions.responseDecoder,
        listFormat: err.requestOptions.listFormat,
      );
      
      // 重试请求
      final dio = Dio();
      final response = await dio.request(
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: options,
        cancelToken: err.requestOptions.cancelToken,
        onSendProgress: err.requestOptions.onSendProgress,
        onReceiveProgress: err.requestOptions.onReceiveProgress,
      );
      
      return response;
    } catch (e) {
      // 重试失败，继续尝试或返回错误
      if (retryCount < _config.maxRetries) {
        return await _retryRequest(err, handler);
      }
      return null;
    }
  }
  
  /// 计算延迟时间
  int _calculateDelay(int retryCount) {
    if (!_config.useExponentialBackoff) {
      return _config.baseDelayMs;
    }
    
    final delay = (_config.baseDelayMs * 
        (_config.backoffMultiplier * (retryCount - 1))).round();
    
    // 添加随机抖动，避免多个请求同时重试
    final jitter = (DateTime.now().millisecondsSinceEpoch % 100);
    final finalDelay = delay + jitter;
    
    return finalDelay.clamp(_config.baseDelayMs, _config.maxDelayMs);
  }
}

/// 重试拦截器扩展
extension RetryInterceptorExtension on Dio {
  /// 添加重试拦截器
  void addRetryInterceptor([RetryInterceptorConfig? config]) {
    final interceptor = RetryInterceptor(config ?? RetryInterceptorConfig.defaultConfig);
    interceptors.add(interceptor);
  }
  
  /// 添加网络错误重试拦截器
  void addNetworkRetryInterceptor() {
    addRetryInterceptor(RetryInterceptorConfig.networkConfig);
  }
  
  /// 添加服务器错误重试拦截器
  void addServerRetryInterceptor() {
    addRetryInterceptor(RetryInterceptorConfig.serverConfig);
  }
}
