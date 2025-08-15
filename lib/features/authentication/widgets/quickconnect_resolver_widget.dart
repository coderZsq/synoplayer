import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/quickconnect/index.dart';

/// QuickConnect地址解析组件
/// 
/// 负责解析QuickConnect ID并测试连接
class QuickConnectResolverWidget extends ConsumerStatefulWidget {
  const QuickConnectResolverWidget({
    super.key,
    required this.onAddressResolved,
    required this.onLog,
    required this.isLoading,
    required this.onLoadingChanged,
  });

  final Function(String url, List<String> allAddresses) onAddressResolved;
  final Function(String message) onLog;
  final bool isLoading;
  final Function(bool loading) onLoadingChanged;

  @override
  ConsumerState<QuickConnectResolverWidget> createState() => _QuickConnectResolverWidgetState();
}

class _QuickConnectResolverWidgetState extends ConsumerState<QuickConnectResolverWidget> {
  final _idCtrl = TextEditingController();
  String? _resolvedUrl;
  List<String> _allAddresses = [];
  bool _isConnected = false;

  @override
  void dispose() {
    _idCtrl.dispose();
    super.dispose();
  }

  /// 解析QuickConnect地址
  Future<void> _resolveAddress() async {
    if (_idCtrl.text.trim().isEmpty) {
      widget.onLog('❌ 请输入 QuickConnect ID');
      return;
    }

    widget.onLoadingChanged(true);
    
    try {
      widget.onLog('🔍 开始解析 QuickConnect 地址...');
      
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final addresses = await quickConnectService.getAllAvailableAddresses(_idCtrl.text.trim());
      
      if (addresses.isNotEmpty) {
        setState(() {
          _allAddresses = addresses;
          _resolvedUrl = addresses.first;
        });
        
        widget.onLog('✅ 地址解析成功，找到 ${addresses.length} 个可用地址');
        widget.onLog('📋 默认使用地址: ${addresses.first}');
        
        // 通知父组件地址已解析
        widget.onAddressResolved(addresses.first, addresses);
        
        // 自动测试连接
        await _testConnection();
      } else {
        widget.onLog('❌ 地址解析失败，未找到可用地址');
      }
    } catch (e) {
      widget.onLog('❌ 地址解析异常: $e');
    } finally {
      widget.onLoadingChanged(false);
    }
  }

  /// 测试连接
  Future<void> _testConnection() async {
    if (_resolvedUrl == null) return;

    try {
      final quickConnectService = ref.read(quickConnectServiceProvider);
      final result = await quickConnectService.testConnection(_resolvedUrl!);
      
      setState(() {
        _isConnected = result.isConnected;
      });
      
      if (result.isConnected) {
        widget.onLog('✅ 连接测试成功');
      } else {
        widget.onLog('⚠️ 连接测试失败（这是正常的，需要认证信息）');
      }
    } catch (e) {
      widget.onLog('❌ 连接测试异常: $e');
    }
  }

  /// 加载保存的QuickConnect ID
  Future<void> _loadSavedId() async {
    // 这里可以加载已保存的QuickConnect ID
    // 暂时留空，实际使用时需要实现
  }

  @override
  void initState() {
    super.initState();
    _loadSavedId();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 标题
            Row(
              children: [
                Icon(
                  Icons.router,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'QuickConnect 设置',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // QuickConnect ID输入框
            TextField(
              controller: _idCtrl,
              enabled: !widget.isLoading,
              decoration: InputDecoration(
                labelText: 'QuickConnect ID',
                hintText: '例如: yourname',
                prefixIcon: const Icon(Icons.link),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: theme.colorScheme.surface,
                helperText: '输入您的群晖 QuickConnect ID',
              ),
            ),
            const SizedBox(height: 12),

            // 帮助信息
            _buildHelpInfo(theme),
            const SizedBox(height: 16),

            // 解析按钮
            _buildResolveButton(theme),
            
            // 解析结果显示
            if (_resolvedUrl != null) ...[
              const SizedBox(height: 16),
              _buildResolvedAddressInfo(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHelpInfo(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.blue.shade900.withOpacity(0.3) : Colors.blue.shade50,
        border: Border.all(
          color: isDark ? Colors.blue.shade700 : Colors.blue.shade200,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info,
                color: isDark ? Colors.blue.shade300 : Colors.blue.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'QuickConnect ID 说明',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '• 这是您在群晖 DSM 中设置的 QuickConnect ID\n'
            '• 不包含 ".synology.me" 等域名后缀\n'
            '• 如果不知道 ID，可以在 DSM 控制面板 > 外部访问 > QuickConnect 中查看',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.blue.shade200 : Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResolveButton(ThemeData theme) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: widget.isLoading ? null : _resolveAddress,
        icon: widget.isLoading 
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onPrimary,
                  ),
                ),
              )
            : const Icon(Icons.search),
        label: Text(widget.isLoading ? '解析中...' : '解析地址'),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: theme.colorScheme.onSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildResolvedAddressInfo(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.green.shade900.withOpacity(0.3) : Colors.green.shade50,
        border: Border.all(
          color: isDark ? Colors.green.shade700 : Colors.green.shade200,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 状态行
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: isDark ? Colors.green.shade300 : Colors.green.shade600,
              ),
              const SizedBox(width: 8),
              Text(
                '地址解析成功',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.green.shade300 : Colors.green.shade700,
                ),
              ),
              const Spacer(),
              // 连接状态指示器
              Row(
                children: [
                  Icon(
                    _isConnected ? Icons.wifi : Icons.wifi_off,
                    color: _isConnected 
                        ? (isDark ? Colors.green.shade300 : Colors.green.shade600)
                        : (isDark ? Colors.orange.shade300 : Colors.orange.shade600),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _isConnected ? '连接正常' : '待认证',
                    style: TextStyle(
                      fontSize: 12,
                      color: _isConnected 
                          ? (isDark ? Colors.green.shade300 : Colors.green.shade600)
                          : (isDark ? Colors.orange.shade300 : Colors.orange.shade600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 主要地址
          Text(
            '主要地址:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.green.shade200 : Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? Colors.green.shade800.withOpacity(0.3) : Colors.green.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _resolvedUrl!,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),

          // 所有地址列表（如果有多个）
          if (_allAddresses.length > 1) ...[
            const SizedBox(height: 12),
            Text(
              '所有可用地址 (${_allAddresses.length}):',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.green.shade200 : Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 4),
            ..._allAddresses.asMap().entries.map((entry) {
              final index = entry.key;
              final address = entry.value;
              final isCurrent = address == _resolvedUrl;
              
              return Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isCurrent 
                      ? (isDark ? Colors.green.shade700.withOpacity(0.5) : Colors.green.shade200)
                      : (isDark ? Colors.grey.shade800.withOpacity(0.5) : Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Text(
                      '${index + 1}.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: isDark ? Colors.green.shade300 : Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        address,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                        ),
                      ),
                    ),
                    if (isCurrent)
                      Icon(
                        Icons.check,
                        size: 14,
                        color: isDark ? Colors.green.shade300 : Colors.green.shade600,
                      ),
                  ],
                ),
              );
            }),
          ],

          const SizedBox(height: 12),
          // 提示信息
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? Colors.blue.shade900.withOpacity(0.3) : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '💡 提示: 地址解析成功后，您可以继续进行登录操作',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.blue.shade200 : Colors.blue.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
