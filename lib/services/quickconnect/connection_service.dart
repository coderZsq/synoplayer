import 'api/quickconnect_api_interface.dart';
import './models/quickconnect_models.dart';
import '../../core/utils/logger.dart';
import 'address_resolver.dart';

/// QuickConnect 连接服务
class QuickConnectConnectionService {
  QuickConnectConnectionService(this._api);
  
  final QuickConnectApiInterface _api;
  static const String _tag = 'ConnectionService';

  /// 测试连接是否可用
  Future<ConnectionTestResult> testConnection(String baseUrl) async {
    try {
      AppLogger.info('测试连接可用性: $baseUrl', tag: _tag);
      
      // 使用抽象 API 接口进行连接测试
      return await _api.testConnection(baseUrl);
      
    } catch (e) {
      AppLogger.error('连接测试异常: $e', tag: _tag);
      return ConnectionTestResult.failure(
        baseUrl, 
        '连接异常: $e', 
        Duration.zero
      );
    }
  }

  /// 获取所有可用的连接地址
  Future<List<String>> getAllAvailableAddresses(String quickConnectId) async {
    try {
      AppLogger.info('获取 QuickConnect ID 的所有可用地址: $quickConnectId', tag: _tag);
      
      final addressResolver = QuickConnectAddressResolver(_api);
      final addresses = await addressResolver.getAllAddressesWithDetails(quickConnectId);
      return addresses.map((addr) => addr.url).toList();
      
    } catch (e) {
      AppLogger.error('获取可用地址时发生异常: $e', tag: _tag);
      return [];
    }
  }

  /// 获取所有可用的连接地址详细信息
  Future<List<AddressInfo>> getAllAvailableAddressesWithDetails(String quickConnectId) async {
    try {
      AppLogger.info('获取 QuickConnect ID 的所有地址详细信息: $quickConnectId', tag: _tag);
      
      final addressResolver = QuickConnectAddressResolver(_api);
      return await addressResolver.getAllAddressesWithDetails(quickConnectId);
      
    } catch (e) {
      AppLogger.error('获取地址详细信息时发生异常: $e', tag: _tag);
      return [];
    }
  }

  /// 批量测试连接
  Future<List<ConnectionTestResult>> testMultipleConnections(List<String> urls) async {
    try {
      AppLogger.info('批量测试连接，共 ${urls.length} 个地址', tag: _tag);
      
      // 使用抽象 API 接口进行批量连接测试
      return await _api.testMultipleConnections(urls);
      
    } catch (e) {
      AppLogger.error('批量连接测试异常: $e', tag: _tag);
      return [];
    }
  }

  /// 测试连接并返回最佳地址
  Future<String?> findBestConnection(List<String> urls) async {
    try {
      AppLogger.info('开始寻找最佳连接，共 ${urls.length} 个地址', tag: _tag);
      
      final results = await testMultipleConnections(urls);
      
      // 按响应时间排序，选择最快的可用连接
      final successfulResults = results
          .where((result) => result.isConnected)
          .toList()
        ..sort((a, b) => a.responseTime.compareTo(b.responseTime));
      
      if (successfulResults.isNotEmpty) {
        final bestResult = successfulResults.first;
        AppLogger.success('找到最佳连接: ${bestResult.url} (响应时间: ${bestResult.responseTime.inMilliseconds}ms)', tag: _tag);
        return bestResult.url;
      } else {
        AppLogger.warning('没有找到可用的连接', tag: _tag);
        return null;
      }
      
    } catch (e) {
      AppLogger.error('寻找最佳连接时发生异常: $e', tag: _tag);
      return null;
    }
  }

  /// 获取连接统计信息
  Map<String, dynamic> getConnectionStats(List<ConnectionTestResult> results) {
    final total = results.length;
    final successful = results.where((r) => r.isConnected).length;
    final failed = total - successful;
    
    if (successful > 0) {
      final avgResponseTime = results
          .where((r) => r.isConnected)
          .map((r) => r.responseTime.inMilliseconds)
          .reduce((a, b) => a + b) / successful;
      
      return {
        'total': total,
        'successful': successful,
        'failed': failed,
        'successRate': '${(successful / total * 100).toStringAsFixed(1)}%',
        'averageResponseTime': '${avgResponseTime.toStringAsFixed(0)}ms',
        'bestResponseTime': '${results
            .where((r) => r.isConnected)
            .map((r) => r.responseTime.inMilliseconds)
            .reduce((a, b) => a < b ? a : b)}ms',
      };
    }
    
    return {
      'total': total,
      'successful': successful,
      'failed': failed,
      'successRate': '0%',
      'averageResponseTime': 'N/A',
      'bestResponseTime': 'N/A',
    };
  }
}
