import 'package:dio/dio.dart';
import '../../quickconnect/data/datasources/quick_connect_api.dart';

/// API Factory 抽象接口
/// 用于创建不同 baseUrl 的 API 实例
abstract class ApiFactory {
  /// 创建 QuickConnect API 实例
  QuickConnectApi createQuickConnectApi(String baseUrl);
  
  /// 获取默认的 QuickConnect API 实例
  QuickConnectApi get quickConnectApi;
}

/// API Factory 具体实现
class ApiFactoryImpl implements ApiFactory {
  final Dio _dio;
  
  const ApiFactoryImpl(this._dio);
  
  @override
  QuickConnectApi createQuickConnectApi(String baseUrl) {
    return QuickConnectApi(_dio, baseUrl: baseUrl);
  }
  
  @override
  QuickConnectApi get quickConnectApi {
    // 使用默认的 baseUrl，这里可以根据需要配置
    return QuickConnectApi(_dio);
  }
}
