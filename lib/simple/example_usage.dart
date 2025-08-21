import 'quickconnect/index.dart';

void main() async {
  // 使用 QuickConnect 服务
  final quickConnectService = QuickConnectService2();
  
  try {
    // 使用新的 fallback 方法：先调用 global.quickconnect.to，如果 sites 有值则用 sites 中的值再次调用
    final response = await quickConnectService.getServerInfoWithFallback(
      serverID: 'Shuangquan',
    );
    print('Final server info: ${response.sites}');
    
    // 或者使用原来的方法
    // final response = await quickConnectService.getServerInfo(
    //   serverID: 'Shuangquan',
    // );
    // print('Server info: ${response.sites}');
  } catch (e) {
    print('Error: $e');
  }
}
