import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/retrofit_migration_config.dart' show MigrationPhase, RetrofitMigrationConfig;
import '../../../core/network/performance_monitor.dart';

/// Retrofit 迁移管理界面
/// 
/// 用于控制迁移过程和查看性能数据
class RetrofitMigrationWidget extends ConsumerStatefulWidget {
  const RetrofitMigrationWidget({super.key});

  @override
  ConsumerState<RetrofitMigrationWidget> createState() => _RetrofitMigrationWidgetState();
}

class _RetrofitMigrationWidgetState extends ConsumerState<RetrofitMigrationWidget> {
  bool _isRetrofitEnabled = false;
  MigrationPhase _currentPhase = MigrationPhase.legacyOnly;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentConfig();
  }

  /// 加载当前配置
  Future<void> _loadCurrentConfig() async {
    setState(() => _isLoading = true);
    
    try {
      final isEnabled = await RetrofitMigrationConfig.isRetrofitEnabled();
      final phase = await RetrofitMigrationConfig.getCurrentPhase();
      
      setState(() {
        _isRetrofitEnabled = isEnabled;
        _currentPhase = phase;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载配置失败: $e')),
        );
      }
    }
  }

  /// 切换 Retrofit 状态
  Future<void> _toggleRetrofit(bool enabled) async {
    setState(() => _isLoading = true);
    
    try {
      await RetrofitMigrationConfig.setRetrofitEnabled(enabled);
      
      if (enabled && _currentPhase == MigrationPhase.legacyOnly) {
        // 如果启用 Retrofit，自动设置到第一阶段
        await RetrofitMigrationConfig.setCurrentPhase(
          MigrationPhase.tunnelRetrofit,
        );
        _currentPhase = MigrationPhase.tunnelRetrofit;
      } else if (!enabled) {
        // 如果禁用 Retrofit，回到第一阶段
        await RetrofitMigrationConfig.setCurrentPhase(
          MigrationPhase.legacyOnly,
        );
        _currentPhase = MigrationPhase.legacyOnly;
      }
      
      setState(() {
        _isRetrofitEnabled = enabled;
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Retrofit ${enabled ? "已启用" : "已禁用"}')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('操作失败: $e')),
        );
      }
    }
  }

  /// 设置迁移阶段
  Future<void> _setMigrationPhase(MigrationPhase phase) async {
    if (!_isRetrofitEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先启用 Retrofit')),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    
    try {
      await RetrofitMigrationConfig.setCurrentPhase(phase);
      setState(() {
        _currentPhase = phase;
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('迁移阶段已设置为: ${_getPhaseName(phase)}')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('设置失败: $e')),
        );
      }
    }
  }

    /// 获取阶段名称
  String _getPhaseName(MigrationPhase phase) {
    return switch (phase) {
      MigrationPhase.legacyOnly => '仅使用旧实现',
      MigrationPhase.tunnelRetrofit => '隧道请求使用 Retrofit',
      MigrationPhase.serverInfoRetrofit => '服务器信息使用 Retrofit',
      MigrationPhase.loginRetrofit => '登录请求使用 Retrofit',
      MigrationPhase.connectionTestRetrofit => '连接测试使用 Retrofit',
      MigrationPhase.retrofitOnly => '完全使用 Retrofit',
    };
  }
  
  /// 获取阶段描述
  String _getPhaseDescription(MigrationPhase phase) {
    return switch (phase) {
      MigrationPhase.legacyOnly => '所有请求都使用原有的实现方式',
      MigrationPhase.tunnelRetrofit => '隧道请求使用 Retrofit，其他使用旧实现',
      MigrationPhase.serverInfoRetrofit => '隧道和服务器信息请求使用 Retrofit',
      MigrationPhase.loginRetrofit => '隧道、服务器信息和登录请求使用 Retrofit',
      MigrationPhase.connectionTestRetrofit => '大部分请求使用 Retrofit，连接测试也使用',
      MigrationPhase.retrofitOnly => '所有请求都使用 Retrofit 实现',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.api, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Retrofit 迁移管理',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (_isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Retrofit 开关
            SwitchListTile(
              title: const Text('启用 Retrofit'),
              subtitle: const Text('切换到新的网络实现'),
              value: _isRetrofitEnabled,
              onChanged: _isLoading ? null : _toggleRetrofit,
              secondary: Icon(
                _isRetrofitEnabled ? Icons.check_circle : Icons.cancel,
                color: _isRetrofitEnabled ? Colors.green : Colors.red,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 迁移阶段选择
            if (_isRetrofitEnabled) ...[
              const Text(
                '迁移阶段',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              
                             DropdownButtonFormField<MigrationPhase>(
                value: _currentPhase,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '选择迁移阶段',
                ),
                                 items: MigrationPhase.values
                     .where((phase) => phase != MigrationPhase.legacyOnly)
                    .map((phase) => DropdownMenuItem(
                      value: phase,
                      child: Text(_getPhaseName(phase)),
                    ))
                    .toList(),
                                 onChanged: _isLoading ? null : (phase) {
                   if (phase != null) {
                     _setMigrationPhase(phase);
                   }
                 },
              ),
              
              const SizedBox(height: 8),
              Text(
                _getPhaseDescription(_currentPhase),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              
              const SizedBox(height: 16),
            ],
            
            // 性能数据
            const Text(
              '性能监控',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            
            _buildPerformanceSummary(),
            
            const SizedBox(height: 16),
            
            // 操作按钮
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isLoading ? null : () => _showPerformanceDetails(context),
                    icon: const Icon(Icons.analytics),
                    label: const Text('查看详细性能'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isLoading ? null : _resetToDefault,
                    icon: const Icon(Icons.refresh),
                    label: const Text('重置配置'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建性能汇总
  Widget _buildPerformanceSummary() {
    final summary = NetworkPerformanceMonitor.getPerformanceSummary();
    
    if (summary.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '暂无性能数据',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    
    return Column(
      children: summary.entries.map((entry) {
        final key = entry.key;
        final data = entry.value;
        
        if (data == null) return const SizedBox.shrink();
        
        final featureName = data.featureName;
        final implementation = data.implementation;
        
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$featureName ($implementation)',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                                         Icon(
                       data.successfulRequests > 0 ? Icons.check_circle : Icons.error,
                       color: data.successfulRequests > 0 ? Colors.green : Colors.red,
                       size: 16,
                     ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('平均响应时间: ${data.averageDuration.inMilliseconds}ms'),
                Text('成功率: ${(data.successRate * 100).toStringAsFixed(1)}%'),
                Text('总请求数: ${data.totalRequests}'),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  /// 显示详细性能数据
  void _showPerformanceDetails(BuildContext context) {
    final allData = NetworkPerformanceMonitor.getAllPerformanceData();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('详细性能数据'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: allData.entries.map((entry) {
                final featureName = entry.key;
                final records = entry.value;
                
                return ExpansionTile(
                  title: Text(featureName),
                  children: records.map((record) {
                    return ListTile(
                      title: Text('${record.implementation} - ${record.duration.inMilliseconds}ms'),
                      subtitle: Text(
                        record.isSuccess ? '成功' : '失败: ${record.errorMessage}',
                      ),
                      trailing: Text(
                        record.timestamp.toString().substring(11, 19),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
          TextButton(
            onPressed: () {
              NetworkPerformanceMonitor.resetAllData();
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text('清除数据'),
          ),
        ],
      ),
    );
  }

  /// 重置到默认配置
  Future<void> _resetToDefault() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认重置'),
        content: const Text('这将重置所有配置到默认状态，确定继续吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('确定'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      setState(() => _isLoading = true);
      
      try {
        await RetrofitMigrationConfig.resetToDefault();
        await _loadCurrentConfig();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('配置已重置')),
          );
        }
      } catch (e) {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('重置失败: $e')),
          );
        }
      }
    }
  }
}
