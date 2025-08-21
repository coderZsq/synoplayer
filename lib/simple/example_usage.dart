import 'quickconnect/index.dart';

void main() async {
  // 使用 QuickConnect 服务
  final quickConnectService = QuickConnectService();
  
  try {
    final response = await quickConnectService.getServerInfo(
      serverID: 'Shuangquan',
    );
    print('Server info: ${response.sites}');
  } catch (e) {
    print('Error: $e');
  }
}
