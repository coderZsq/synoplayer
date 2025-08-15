import 'dart:convert';
import 'package:dio/dio.dart';
import 'constants/quickconnect_constants.dart';
import './models/quickconnect_models.dart';
import '../../core/index.dart';
import 'utils/serialization_helper.dart';

/// QuickConnect 地址解析服务
class QuickConnectAddressResolver {
  QuickConnectAddressResolver(this._apiClient);
  
  final ApiClient _apiClient;
  static const String _tag = 'AddressResolver';

  /// 解析 QuickConnect ID 获取可用地址
  Future<String?> resolveAddress(String quickConnectId) async {
    try {
      AppLogger.info('开始解析 QuickConnect ID: $quickConnectId', tag: _tag);
      
      // 1. 尝试隧道请求
      final tunnelAddress = await _tryTunnelRequest(quickConnectId);
      if (tunnelAddress != null) {
        AppLogger.success('隧道请求成功，地址: $tunnelAddress', tag: _tag);
        return tunnelAddress;
      }
      
      // 2. 尝试服务器信息请求
      final serverInfoAddress = await _tryServerInfoRequest(quickConnectId);
      if (serverInfoAddress != null) {
        AppLogger.success('服务器信息请求成功，地址: $serverInfoAddress', tag: _tag);
        return serverInfoAddress;
      }
      
      AppLogger.error('无法解析 QuickConnect ID: $quickConnectId', tag: _tag);
      return null;
      
    } catch (e) {
      AppLogger.error('地址解析异常: $e', tag: _tag);
      return null;
    }
  }

  /// 获取所有可用地址的详细信息
  Future<List<AddressInfo>> getAllAddressesWithDetails(String quickConnectId) async {
    try {
      AppLogger.info('获取 QuickConnect ID 的所有地址详细信息: $quickConnectId', tag: _tag);
      
      // 调试：测试 SmartDNS 数据格式
      _testSmartDnsFormats();
      
      final addresses = <AddressInfo>[];
      
      // 1. 尝试隧道请求获取地址
      final tunnelAddress = await _tryTunnelRequest(quickConnectId);
      if (tunnelAddress != null) {
        addresses.add(AddressInfo(
          url: tunnelAddress,
          type: AddressType.relay,
          description: '隧道中继地址',
          priority: 1,
        ));
      }
      
      // 2. 获取服务器信息中的所有地址
      final serverInfoAddresses = await _getServerInfoAddresses(quickConnectId);
      addresses.addAll(serverInfoAddresses);
      
      // 按优先级排序
      addresses.sort((a, b) => a.priority.compareTo(b.priority));
      
      AppLogger.success('总共找到 ${addresses.length} 个可用地址', tag: _tag);
      return addresses;
      
    } catch (e) {
      AppLogger.error('获取地址详细信息异常: $e', tag: _tag);
      return [];
    }
  }

  /// 尝试隧道请求
  Future<String?> _tryTunnelRequest(String quickConnectId) async {
    try {
      final tunnelUrl = Uri.parse(QuickConnectConstants.tunnelServiceUrl);
      final tunnelBody = jsonEncode({
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetTunnel,
        "version": QuickConnectConstants.apiVersion1
      });

      AppLogger.network('发送隧道请求: $tunnelBody', tag: _tag);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        tunnelUrl.toString(),
        data: tunnelBody,
        options: Options(
          headers: QuickConnectConstants.defaultHeaders,
          sendTimeout: QuickConnectConstants.tunnelTimeout,
          receiveTimeout: QuickConnectConstants.tunnelTimeout,
        ),
        fromJson: (data) {
          // data 可能是 String 或已经解析的 Map
          if (data is String) {
            return jsonDecode(data) as Map<String, dynamic>;
          } else {
            return data as Map<String, dynamic>;
          }
        },
      );

      return response.when(
        success: (data, statusCode, message, extra) {
          final tunnelResponse = SerializationHelper.safeFromMap(
            data,
            TunnelResponse.fromJson,
          );
          
          if (tunnelResponse != null && tunnelResponse.success) {
            return _parseTunnelAddresses(tunnelResponse.tunnelData);
          } else if (tunnelResponse != null) {
            AppLogger.error('QuickConnect 隧道请求失败', tag: _tag);
            AppLogger.error('错误代码: ${tunnelResponse.errorCode}', tag: _tag);
            AppLogger.error('错误信息: ${tunnelResponse.errorInfo}', tag: _tag);
          }
          return null;
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('隧道请求失败: $message', tag: _tag);
          return null;
        },
      );
    } catch (e) {
      AppLogger.error('隧道请求异常: $e', tag: _tag);
      return null;
    }
  }

  /// 尝试服务器信息请求
  Future<String?> _tryServerInfoRequest(String quickConnectId) async {
    try {
      final serverInfoUrl = Uri.parse(QuickConnectConstants.serverInfoUrl);
      final serverInfoBody = jsonEncode({
        "get_ca_fingerprints": true,
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetServerInfo,
        "version": QuickConnectConstants.apiVersion1
      });

      AppLogger.network('发送服务器信息请求: $serverInfoBody', tag: _tag);
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        serverInfoUrl.toString(),
        data: serverInfoBody,
        options: Options(
          headers: QuickConnectConstants.defaultHeaders,
          sendTimeout: QuickConnectConstants.serverInfoTimeout,
          receiveTimeout: QuickConnectConstants.serverInfoTimeout,
        ),
        fromJson: (data) {
          // data 可能是 String 或已经解析的 Map
          if (data is String) {
            return jsonDecode(data) as Map<String, dynamic>;
          } else {
            return data as Map<String, dynamic>;
          }
        },
      );

      return response.when(
        success: (data, statusCode, message, extra) {
          final serverInfoResponse = SerializationHelper.safeFromMap(
            data,
            ServerInfoResponse.fromJson,
          );
          
          if (serverInfoResponse != null) {
            // 调试：记录原始 JSON 数据
            AppLogger.debug('原始 JSON 数据: $data', tag: _tag);
            AppLogger.debug('解析后的 ServerInfoResponse: $serverInfoResponse', tag: _tag);
            
            return _trySmartDnsAddress(serverInfoResponse);
          }
          return null;
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('服务器信息请求失败: $message', tag: _tag);
          return null;
        },
      );
    } catch (e) {
      AppLogger.error('服务器信息请求异常: $e', tag: _tag);
      return null;
    }
  }

  /// 获取服务器信息中的所有地址
  Future<List<AddressInfo>> _getServerInfoAddresses(String quickConnectId) async {
    try {
      final serverInfoUrl = Uri.parse(QuickConnectConstants.serverInfoUrl);
      final serverInfoBody = jsonEncode({
        "get_ca_fingerprints": true,
        "id": QuickConnectConstants.serverIdDsmHttps,
        "serverID": quickConnectId.trim(),
        "command": QuickConnectConstants.commandGetServerInfo,
        "version": QuickConnectConstants.apiVersion1
      });

      final response = await _apiClient.post<Map<String, dynamic>>(
        serverInfoUrl.toString(),
        data: serverInfoBody,
        options: Options(
          headers: QuickConnectConstants.defaultHeaders,
          sendTimeout: QuickConnectConstants.serverInfoTimeout,
          receiveTimeout: QuickConnectConstants.serverInfoTimeout,
        ),
        fromJson: (data) {
          // data 可能是 String 或已经解析的 Map
          if (data is String) {
            return jsonDecode(data) as Map<String, dynamic>;
          } else {
            return data as Map<String, dynamic>;
          }
        },
      );

      return response.when(
        success: (data, statusCode, message, extra) {
          final serverInfoResponse = SerializationHelper.safeFromMap(
            data,
            ServerInfoResponse.fromJson,
          );
          
          if (serverInfoResponse != null) {
            return _extractAllAddresses(serverInfoResponse);
          }
          return [];
        },
        error: (message, statusCode, errorCode, error, extra) {
          AppLogger.error('获取服务器信息地址失败: $message', tag: _tag);
          return [];
        },
      );
    } catch (e) {
      AppLogger.error('获取服务器信息地址异常: $e', tag: _tag);
      return [];
    }
  }

  /// 解析隧道地址
  String? _parseTunnelAddresses(TunnelData? tunnelData) {
    if (tunnelData == null) {
      AppLogger.warning('隧道数据为空', tag: _tag);
      return null;
    }

    // 优先使用中继服务器
    if (tunnelData.relay?.isValid == true) {
      final relay = tunnelData.relay!;
      final address = relay.validAddress!;
      final port = relay.port!;
      final result = 'https://$address:$port';
      AppLogger.success('使用隧道中继地址: $result', tag: _tag);
      return result;
    }

    // 其次使用外部地址
    if (tunnelData.external?.isValid == true) {
      final external = tunnelData.external!;
      final address = external.validAddress!;
      final port = external.port!;
      final result = 'https://$address:$port';
      AppLogger.success('使用隧道外部地址: $result', tag: _tag);
      return result;
    }

    AppLogger.warning('隧道数据中没有有效的地址信息', tag: _tag);
    return null;
  }

  /// 尝试 SmartDNS 直连地址
  String? _trySmartDnsAddress(ServerInfoResponse serverInfoResponse) {
    final smartDns = serverInfoResponse.smartDns;
    if (smartDns?.isValid == true) {
      final host = smartDns!.host!;
      final port = smartDns.port ?? QuickConnectConstants.defaultServicePort;
      final result = 'https://$host:$port';
      AppLogger.success('使用 SmartDNS 直连地址: $result', tag: _tag);
      AppLogger.info('注意: 如果直连失败，系统会自动尝试中继服务器', tag: _tag);
      return result;
    }
    
    // 调试：记录 SmartDNS 信息
    AppLogger.debug('SmartDNS 检查结果:', tag: _tag);
    AppLogger.debug('smartDns 对象: $smartDns', tag: _tag);
    if (smartDns != null) {
      AppLogger.debug('host: ${smartDns.host}, port: ${smartDns.port}', tag: _tag);
      AppLogger.debug('isValid: ${smartDns.isValid}', tag: _tag);
    }
    
    return null;
  }

  /// 提取所有可用地址
  List<AddressInfo> _extractAllAddresses(ServerInfoResponse serverInfoResponse) {
    final addresses = <AddressInfo>[];
    
    // 调试信息：记录原始数据
    AppLogger.debug('开始提取地址，原始数据:', tag: _tag);
    AppLogger.debug('SmartDNS: ${serverInfoResponse.smartDns}', tag: _tag);
    AppLogger.debug('Service: ${serverInfoResponse.service}', tag: _tag);
    AppLogger.debug('ServerInfo: ${serverInfoResponse.serverInfo}', tag: _tag);
    AppLogger.debug('Sites: ${serverInfoResponse.sites}', tag: _tag);
    
    // 1. SmartDNS 直连地址（最高优先级）
    final smartDns = serverInfoResponse.smartDns;
    AppLogger.debug('SmartDNS 对象: $smartDns', tag: _tag);
    if (smartDns != null) {
      AppLogger.debug('SmartDNS host: ${smartDns.host}', tag: _tag);
      AppLogger.debug('SmartDNS port: ${smartDns.port}', tag: _tag);
      AppLogger.debug('SmartDNS isValid: ${smartDns.isValid}', tag: _tag);
      AppLogger.debug('SmartDNS hasValidHost: ${smartDns.hasValidHost}', tag: _tag);
      AppLogger.debug('SmartDNS hasPort: ${smartDns.hasPort}', tag: _tag);
      AppLogger.debug('SmartDNS debugInfo: ${smartDns.debugInfo}', tag: _tag);
    }
    
    // 尝试使用更宽松的验证
    if (smartDns?.hasValidHost == true) {
      final host = smartDns!.host!;
      // 如果没有端口，使用默认端口
      final port = smartDns.port ?? QuickConnectConstants.defaultServicePort;
      final url = 'https://$host:$port';
      
      AppLogger.info('使用 SmartDNS 直连地址 (宽松验证): $url', tag: _tag);
      if (smartDns.port == null) {
        AppLogger.warning('SmartDNS 没有端口信息，使用默认端口: $port', tag: _tag);
      }
      
      addresses.add(AddressInfo(
        url: url,
        type: AddressType.smartDns,
        description: 'SmartDNS 直连',
        priority: 1,
      ));
      AppLogger.info('可用地址 1: $url (SmartDNS 直连)', tag: _tag);
    } else if (smartDns?.isValid == true) {
      // 原有的严格验证
      final host = smartDns!.host!;
      final port = smartDns.port!;
      final url = 'https://$host:$port';
      addresses.add(AddressInfo(
        url: url,
        type: AddressType.smartDns,
        description: 'SmartDNS 直连',
        priority: 1,
      ));
      AppLogger.info('可用地址 1: $url (SmartDNS 直连)', tag: _tag);
    } else {
      AppLogger.warning('SmartDNS 地址无效或为空', tag: _tag);
      if (smartDns != null) {
        AppLogger.warning('SmartDNS 详情: host=${smartDns.host}, port=${smartDns.port}', tag: _tag);
        AppLogger.warning('SmartDNS 验证: isValid=${smartDns.isValid}, hasValidHost=${smartDns.hasValidHost}, hasPort=${smartDns.hasPort}', tag: _tag);
      }
    }

    // 2. 中继服务器地址
    final service = serverInfoResponse.service;
    if (service?.hasValidRelay == true) {
      final relayDn = service!.relayDn!;
      final relayPort = service.relayPort!;
      final url = 'https://$relayDn:$relayPort';
      addresses.add(AddressInfo(
        url: url,
        type: AddressType.relay,
        description: '中继服务器',
        priority: 2,
      ));
      AppLogger.info('可用地址 2: $url (中继服务器)', tag: _tag);
    }

    // 3. HTTPS 中继地址
    if (service?.hasValidHttpsRelay == true) {
      final httpsIp = service!.httpsIp!;
      final httpsPort = service.httpsPort!;
      final url = 'https://$httpsIp:$httpsPort';
      addresses.add(AddressInfo(
        url: url,
        type: AddressType.httpsRelay,
        description: 'HTTPS 中继',
        priority: 3,
      ));
      AppLogger.info('可用地址 3: $url (HTTPS 中继)', tag: _tag);
    }

    // 4. 外部 IP 地址
    final server = serverInfoResponse.serverInfo;
    if (server?.external?.isValid == true) {
      final externalIp = server!.external!.ip!;
      final servicePort = service?.port ?? QuickConnectConstants.defaultServicePort;
      final url = 'https://$externalIp:$servicePort';
      addresses.add(AddressInfo(
        url: url,
        type: AddressType.externalIp,
        description: '外部IP',
        priority: 4,
      ));
      AppLogger.info('可用地址 4: $url (外部IP)', tag: _tag);
    }

    // 5. LAN 地址
    if (server?.interfaces != null) {
      for (final interface in server!.interfaces!) {
        if (interface.isValid) {
          final url = 'https://${interface.ip}:${service?.port ?? QuickConnectConstants.defaultServicePort}';
          addresses.add(AddressInfo(
            url: url,
            type: AddressType.lan,
            description: 'LAN地址 (${interface.name ?? interface.type})',
            priority: 5,
          ));
          AppLogger.info('可用地址 5: $url (LAN地址)', tag: _tag);
        }
      }
    }

    // 6. 站点地址
    if (serverInfoResponse.sites != null) {
      for (int i = 0; i < serverInfoResponse.sites!.length; i++) {
        final site = serverInfoResponse.sites![i];
        if (site.isNotEmpty) {
          final url = 'https://$site';
          addresses.add(AddressInfo(
            url: url,
            type: AddressType.site,
            description: '站点地址 ${i + 1}',
            priority: 6 + i,
          ));
          AppLogger.info('可用地址 ${6 + i}: $url (站点地址)', tag: _tag);
        }
      }
    }

    return addresses;
  }

  /// 测试 SmartDNS 数据格式（用于调试）
  void _testSmartDnsFormats() {
    AppLogger.debug('=== SmartDNS 数据格式测试 ===', tag: _tag);
    
    // 测试不同的数据格式
    final testCases = [
      {'smartdns': {'host': 'example.com', 'port': 5001}},
      {'smartdns': {'host': 'example.com'}}, // 没有端口
      {'smartdns': {'host': 'NULL', 'port': 5001}}, // 无效主机
      {'smartdns': null}, // 完全为空
      {'smart_dns': {'host': 'example.com', 'port': 5001}}, // 不同的字段名
      {'smartDns': {'host': 'example.com', 'port': 5001}}, // 驼峰命名
    ];
    
    for (int i = 0; i < testCases.length; i++) {
      final testCase = testCases[i];
      AppLogger.debug('测试用例 $i: $testCase', tag: _tag);
      
      try {
        final response = ServerInfoResponse.fromJson(testCase);
        AppLogger.debug('解析结果: ${response.smartDns}', tag: _tag);
        if (response.smartDns != null) {
          AppLogger.debug('验证结果: isValid=${response.smartDns!.isValid}, hasValidHost=${response.smartDns!.hasValidHost}', tag: _tag);
        }
      } catch (e) {
        AppLogger.error('解析失败: $e', tag: _tag);
      }
    }
    
    AppLogger.debug('=== 测试完成 ===', tag: _tag);
  }
}
