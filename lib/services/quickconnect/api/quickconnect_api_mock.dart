import '../models/quickconnect_models.dart';
import '../models/login_result.dart';
import 'quickconnect_api_interface.dart';

/// QuickConnect API Mock 实现
///
/// 用于单元测试，提供可控的模拟数据和行为
class QuickConnectApiMock implements QuickConnectApiInterface {
  QuickConnectApiMock({
    this.shouldSucceed = true,
    this.mockDelay = const Duration(milliseconds: 100),
    this.tunnelResponse,
    this.serverInfoResponse,
    this.quickConnectServerInfoResponse,
    this.loginResult,
    this.connectionTestResult,
  });

  final bool shouldSucceed;
  final Duration mockDelay;
  final TunnelResponse? tunnelResponse;
  final ServerInfoResponse? serverInfoResponse;
  final QuickConnectServerInfoResponse? quickConnectServerInfoResponse;
  final LoginResult? loginResult;
  final ConnectionTestResult? connectionTestResult;

  // ==================== 地址解析 API Mock ====================

  @override
  Future<TunnelResponse?> requestTunnel(String quickConnectId) async {
    await Future.delayed(mockDelay);

    if (!shouldSucceed) {
      throw Exception('Mock tunnel request failed');
    }

    return tunnelResponse ?? _createDefaultTunnelResponse(quickConnectId);
  }

  @override
  Future<ServerInfoResponse?> requestServerInfo(String quickConnectId) async {
    await Future.delayed(mockDelay);

    if (!shouldSucceed) {
      throw Exception('Mock server info request failed');
    }

    return serverInfoResponse ?? _createDefaultServerInfoResponse(quickConnectId);
  }

  @override
  Future<QuickConnectServerInfoResponse?> requestQuickConnectServerInfo({
    required String quickConnectId,
    bool getCaFingerprints = true,
  }) async {
    await Future.delayed(mockDelay);

    // 模拟不同的响应场景
    if (quickConnectId.toLowerCase() == 'error') {
      return _createErrorQuickConnectServerInfoResponse(quickConnectId);
    }

    if (quickConnectId.toLowerCase() == 'notfound') {
      return _createNotFoundQuickConnectServerInfoResponse(quickConnectId);
    }

    if (quickConnectId.toLowerCase() == 'timeout') {
      await Future.delayed(Duration(seconds: 5)); // 减少等待时间以便测试
      return null;
    }

    return quickConnectServerInfoResponse ?? _createDefaultQuickConnectServerInfoResponse(
      quickConnectId,
      getCaFingerprints
    );
  }

  // ==================== 认证登录 API Mock ====================

  @override
  Future<LoginResult> requestLogin({
    required String baseUrl,
    required String username,
    required String password,
    String? otpCode,
  }) async {
    await Future.delayed(mockDelay);

    if (!shouldSucceed) {
      return LoginResult.failure(errorMessage: 'Mock login failed');
    }

    // 模拟不同的登录场景
    if (username == 'invalid_user') {
      return LoginResult.failure(errorMessage: 'Invalid username');
    }

    if (password == 'wrong_password') {
      return LoginResult.failure(errorMessage: 'Invalid password');
    }

    if (username == 'otp_required' && (otpCode == null || otpCode.isEmpty)) {
      return LoginResult.requireOTP(errorMessage: 'OTP code required');
    }

    if (username == 'otp_required' && otpCode == 'invalid_otp') {
      return LoginResult.failure(errorMessage: 'Invalid OTP code');
    }

    return loginResult ?? LoginResult.success(
      sid: 'mock_session_id_${DateTime.now().millisecondsSinceEpoch}',
      availableAddress: baseUrl,
    );
  }

  // ==================== 连接测试 API Mock ====================

  @override
  Future<ConnectionTestResult> testConnection(String baseUrl) async {
    await Future.delayed(mockDelay);

    if (!shouldSucceed) {
      return ConnectionTestResult.failure(
        baseUrl,
        'Mock connection test failed',
        mockDelay,
      );
    }

    // 模拟不同的连接场景
    if (baseUrl.contains('invalid')) {
      return ConnectionTestResult.failure(
        baseUrl,
        'Invalid URL',
        mockDelay,
      );
    }

    if (baseUrl.contains('timeout')) {
      return ConnectionTestResult.failure(
        baseUrl,
        'Connection timeout',
        Duration(seconds: 30),
      );
    }

    return connectionTestResult ?? ConnectionTestResult.success(
      baseUrl,
      200,
      mockDelay,
    );
  }

  // ==================== 批量操作 API Mock ====================

  @override
  Future<List<ConnectionTestResult>> testMultipleConnections(List<String> urls) async {
    final results = <ConnectionTestResult>[];

    for (final url in urls) {
      final result = await testConnection(url);
      results.add(result);
    }

    return results;
  }

  // ==================== Mock 数据创建辅助方法 ====================

  /// 创建默认的隧道响应
  TunnelResponse _createDefaultTunnelResponse(String quickConnectId) {
    return TunnelResponse(
      success: true,
      tunnelData: TunnelData(
        relay: RelayInfo(
          ip: 'relay.example.com',
          port: 443,
        ),
        external: ExternalInfo(
          ip: 'external.example.com',
          port: 443,
        ),
      ),
      errorCode: null,
      errorInfo: null,
    );
  }

  /// 创建默认的服务器信息响应
  ServerInfoResponse _createDefaultServerInfoResponse(String quickConnectId) {
    return ServerInfoResponse(
      success: true,
      smartDns: SmartDnsInfo(
        host: '$quickConnectId.synology.me',
        port: 5001,
      ),
      service: ServiceInfo(
        port: 5001,
        relayDn: 'relay.synology.com',
        relayPort: 443,
        httpsIp: '192.168.1.100',
        httpsPort: 5001,
      ),
      serverInfo: ServerInfo(
        external: ExternalServerInfo(
          ip: '203.0.113.1',
        ),
        interfaces: [
          InterfaceInfo(
            ip: '192.168.1.100',
            name: 'eth0',
            type: 'ethernet',
          ),
        ],
      ),
      sites: [
        '$quickConnectId.direct.example.com:5001',
      ],
    );
  }

  /// 创建默认的 QuickConnect 服务器信息响应（成功情况）
  QuickConnectServerInfoResponse _createDefaultQuickConnectServerInfoResponse(
    String quickConnectId,
    bool getCaFingerprints,
  ) {
    return QuickConnectServerInfoResponse(
      command: 'get_server_info',
      version: 1,
      getCaFingerprints: getCaFingerprints,
      sites: ['global.quickconnect.to', 'cnc.quickconnect.cn'],
      server: ServerInfo(
        external: ExternalServerInfo(
          ip: '192.168.1.100',
          port: 5000,
        ),
      ),
      smartdns: SmartDnsInfo(
        host: '$quickConnectId.synology.me',
        port: 443,
      ),
      service: ServiceInfo(
        relayDn: 'relay.quickconnect.to',
        relayPort: 443,
        httpsIp: '192.168.1.100',
        httpsPort: 5001,
        port: 5000,
      ),
    );
  }

  /// 创建错误的 QuickConnect 服务器信息响应（基于抓包的错误响应）
  QuickConnectServerInfoResponse _createErrorQuickConnectServerInfoResponse(
    String quickConnectId,
  ) {
    return QuickConnectServerInfoResponse(
      command: 'get_server_info',
      errinfo: 'get_server_info.go:112[Ds info not found]',
      errno: 4,
      sites: ['cnc.quickconnect.cn'],
      suberrno: 2,
      version: 1,
    );
  }

  /// 创建未找到的 QuickConnect 服务器信息响应
  QuickConnectServerInfoResponse _createNotFoundQuickConnectServerInfoResponse(
    String quickConnectId,
  ) {
    return QuickConnectServerInfoResponse(
      command: 'get_server_info',
      errinfo: 'QuickConnect ID not found',
      errno: 1,
      sites: ['global.quickconnect.to'],
      version: 1,
    );
  }
}

/// QuickConnect API Mock 工厂类
///
/// 提供不同场景的 Mock 实例
class QuickConnectApiMockFactory {

  /// 创建成功场景的 Mock
  static QuickConnectApiMock createSuccess({
    Duration delay = const Duration(milliseconds: 100),
  }) {
    return QuickConnectApiMock(
      shouldSucceed: true,
      mockDelay: delay,
    );
  }

  /// 创建失败场景的 Mock
  static QuickConnectApiMock createFailure({
    Duration delay = const Duration(milliseconds: 100),
  }) {
    return QuickConnectApiMock(
      shouldSucceed: false,
      mockDelay: delay,
    );
  }

  /// 创建需要 OTP 验证的 Mock
  static QuickConnectApiMock createOTPRequired({
    Duration delay = const Duration(milliseconds: 100),
  }) {
    return QuickConnectApiMock(
      shouldSucceed: true,
      mockDelay: delay,
      loginResult: LoginResult.requireOTP(
        errorMessage: 'OTP verification required',
      ),
    );
  }

  /// 创建连接超时的 Mock
  static QuickConnectApiMock createTimeout({
    Duration delay = const Duration(seconds: 30),
  }) {
    return QuickConnectApiMock(
      shouldSucceed: true,
      mockDelay: delay,
      connectionTestResult: ConnectionTestResult.failure(
        'timeout.example.com',
        'Connection timeout',
        delay,
      ),
    );
  }

  /// 创建自定义响应的 Mock
  static QuickConnectApiMock createCustom({
    required TunnelResponse? tunnelResponse,
    required ServerInfoResponse? serverInfoResponse,
    QuickConnectServerInfoResponse? quickConnectServerInfoResponse,
    required LoginResult? loginResult,
    required ConnectionTestResult? connectionTestResult,
    Duration delay = const Duration(milliseconds: 100),
  }) {
    return QuickConnectApiMock(
      shouldSucceed: true,
      mockDelay: delay,
      tunnelResponse: tunnelResponse,
      serverInfoResponse: serverInfoResponse,
      quickConnectServerInfoResponse: quickConnectServerInfoResponse,
      loginResult: loginResult,
      connectionTestResult: connectionTestResult,
    );
  }
}
