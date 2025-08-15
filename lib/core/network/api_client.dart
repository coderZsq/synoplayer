import 'package:dio/dio.dart';
import 'models/api_response.dart';
import 'models/network_exceptions.dart';
import '../utils/logger.dart';

/// 统一的 API 客户端
class ApiClient {
  ApiClient(this._dio);
  
  final Dio _dio;
  static const String _tag = 'ApiClient';

  /// GET 请求
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      AppLogger.network('GET 请求: $path', tag: _tag);
      if (queryParameters != null) {
        AppLogger.debug('查询参数: $queryParameters', tag: _tag);
      }
      
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      AppLogger.error('GET 请求失败: $path, 错误: $e', tag: _tag);
      return _handleError<T>(e);
    } catch (e) {
      AppLogger.error('GET 请求异常: $path, 异常: $e', tag: _tag);
      return ApiResponse.error(
        message: '请求异常: $e',
        statusCode: 0,
        error: e,
      );
    }
  }

  /// POST 请求
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      AppLogger.network('POST 请求: $path', tag: _tag);
      if (data != null) {
        AppLogger.debug('请求数据: $data', tag: _tag);
      }
      if (queryParameters != null) {
        AppLogger.debug('查询参数: $queryParameters', tag: _tag);
      }
      
      final response = await _dio.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      AppLogger.error('POST 请求失败: $path, 错误: $e', tag: _tag);
      return _handleError<T>(e);
    } catch (e) {
      AppLogger.error('POST 请求异常: $path, 异常: $e', tag: _tag);
      return ApiResponse.error(
        message: '请求异常: $e',
        statusCode: 0,
        error: e,
      );
    }
  }

  /// PUT 请求
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      AppLogger.network('PUT 请求: $path', tag: _tag);
      
      final response = await _dio.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      AppLogger.error('PUT 请求失败: $path, 错误: $e', tag: _tag);
      return _handleError<T>(e);
    } catch (e) {
      AppLogger.error('PUT 请求异常: $path, 异常: $e', tag: _tag);
      return ApiResponse.error(
        message: '请求异常: $e',
        statusCode: 0,
        error: e,
      );
    }
  }

  /// DELETE 请求
  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      AppLogger.network('DELETE 请求: $path', tag: _tag);
      
      final response = await _dio.delete<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      AppLogger.error('DELETE 请求失败: $path, 错误: $e', tag: _tag);
      return _handleError<T>(e);
    } catch (e) {
      AppLogger.error('DELETE 请求异常: $path, 异常: $e', tag: _tag);
      return ApiResponse.error(
        message: '请求异常: $e',
        statusCode: 0,
        error: e,
      );
    }
  }

  /// PATCH 请求
  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      AppLogger.network('PATCH 请求: $path', tag: _tag);
      
      final response = await _dio.patch<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      AppLogger.error('PATCH 请求失败: $path, 错误: $e', tag: _tag);
      return _handleError<T>(e);
    } catch (e) {
      AppLogger.error('PATCH 请求异常: $path, 异常: $e', tag: _tag);
      return ApiResponse.error(
        message: '请求异常: $e',
        statusCode: 0,
        error: e,
      );
    }
  }

  /// 处理响应
  ApiResponse<T> _handleResponse<T>(
    Response<dynamic> response,
    T Function(dynamic)? fromJson,
  ) {
    final statusCode = response.statusCode ?? 0;
    AppLogger.success('请求成功，状态码: $statusCode', tag: _tag);
    
    try {
      T data;
      if (fromJson != null) {
        data = fromJson(response.data);
      } else {
        data = response.data as T;
      }
      
      return ApiResponse.success(
        data: data,
        statusCode: statusCode,
        extra: {
          'headers': response.headers.map,
          'realUri': response.realUri.toString(),
        },
      );
    } catch (e) {
      AppLogger.error('响应数据解析失败: $e', tag: _tag);
      return ApiResponse.error(
        message: '响应数据解析失败: $e',
        statusCode: statusCode,
        error: e,
      );
    }
  }

  /// 处理错误
  ApiResponse<T> _handleError<T>(DioException dioException) {
    final networkException = NetworkExceptionHandler.fromDioException(dioException);
    final errorMessage = NetworkExceptionHandler.getErrorMessage(networkException);
    
    return ApiResponse.error(
      message: errorMessage,
      statusCode: dioException.response?.statusCode ?? 0,
      errorCode: dioException.type.name,
      error: networkException,
      extra: {
        'requestPath': dioException.requestOptions.path,
        'requestMethod': dioException.requestOptions.method,
      },
    );
  }

  /// 取消所有请求
  void cancelAllRequests([String? reason]) {
    // 清除所有拦截器来模拟取消请求
    _dio.interceptors.clear();
    
    // 这里可以添加取消逻辑
    AppLogger.warning('取消所有请求: ${reason ?? "用户取消"}', tag: _tag);
  }

  /// 获取当前 Dio 实例（用于特殊需求）
  Dio get dio => _dio;
}
