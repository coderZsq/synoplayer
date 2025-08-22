import 'quickconnect/index.dart';

void main() async {
  // 使用 QuickConnect 服务
  final quickConnectService = QuickConnectService2();
  
  try {
    // 简单的登录流程 - 用户只需要知道服务器ID
    final response = await quickConnectService.login(
      quickConnectId: 'Shuangquan',
      username: 'Shuangquan',
      password: 'Super91502991',
      otpCode: '212846'
    );
    print('登录成功！服务器信息: ${response}');
  } catch (e) {
    print('登录失败: $e');
  }
}
