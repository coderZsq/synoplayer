import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

/// 统一的 API 响应包装类
@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success({
    required T data,
    required int statusCode,
    String? message,
    Map<String, dynamic>? extra,
  }) = ApiSuccess<T>;
  
  const factory ApiResponse.error({
    required String message,
    required int statusCode,
    String? errorCode,
    dynamic error,
    Map<String, dynamic>? extra,
  }) = ApiError<T>;
}

/// API 响应的扩展方法
extension ApiResponseExtension<T> on ApiResponse<T> {
  /// 是否成功
  bool get isSuccess => when(
    success: (_, __, ___, ____) => true,
    error: (_, __, ___, ____, _____) => false,
  );
  
  /// 是否失败
  bool get isError => !isSuccess;
  
  /// 获取数据，失败时返回 null
  T? get dataOrNull => when(
    success: (data, _, __, ___) => data,
    error: (_, __, ___, ____, _____) => null,
  );
  
  /// 获取错误信息，成功时返回 null
  String? get errorMessage => when(
    success: (_, __, message, ___) => message,
    error: (message, _, __, ___, ____) => message,
  );
  
  /// 获取状态码
  int get code => when(
    success: (_, statusCode, __, ___) => statusCode,
    error: (_, statusCode, __, ___, ____) => statusCode,
  );
}
