import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/feature_flags.dart';
import '../../../core/config/retrofit_migration_config.dart';
import '../../../services/quickconnect/providers/quickconnect_providers.dart';
import '../../../core/utils/logger.dart';

/// Retrofit 迁移状态展示组件
/// 
/// 显示当前 Retrofit 迁移状态和配置信息
class RetrofitMigrationWidget extends ConsumerStatefulWidget {
  const RetrofitMigrationWidget({super.key});

  @override
  ConsumerState<RetrofitMigrationWidget> createState() => _RetrofitMigrationWidgetState();
}

class _RetrofitMigrationWidgetState extends ConsumerState<RetrofitMigrationWidget> {
  MigrationPhase _currentPhase = MigrationPhase.legacyOnly;
  bool _isRetrofitEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMigrationStatus();
  }

  Future<void> _loadMigrationStatus() async {
    try {
      final phase = await RetrofitMigrationConfig.getCurrentPhase();
      final enabled = await RetrofitMigrationConfig.isRetrofitEnabled();
      
      setState(() {
        _currentPhase = phase;
        _isRetrofitEnabled = enabled;
        _isLoading = false;
      });
    } catch (e) {
      AppLogger.error('加载迁移状态失败: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleRetrofit(bool enabled) async {
    try {
      await RetrofitMigrationConfig.setRetrofitEnabled(enabled);
      await _loadMigrationStatus();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Retrofit ${enabled ? '已启用' : '已禁用'}'),
            backgroundColor: enabled ? Colors.green : Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('操作失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _setMigrationPhase(MigrationPhase phase) async {
    try {
      await RetrofitMigrationConfig.setCurrentPhase(phase);
      await _loadMigrationStatus();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('迁移阶段已设置为: ${_getPhaseName(phase)}'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('设置失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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

  String _getPhaseDescription(MigrationPhase phase) {
    return switch (phase) {
      MigrationPhase.legacyOnly => '所有功能都使用旧的 API 实现',
      MigrationPhase.tunnelRetrofit => '隧道请求使用新的 Retrofit 实现，其他功能使用旧实现',
      MigrationPhase.serverInfoRetrofit => '隧道和服务器信息请求使用 Retrofit，其他功能使用旧实现',
      MigrationPhase.loginRetrofit => '隧道、服务器信息和登录请求使用 Retrofit，连接测试使用旧实现',
      MigrationPhase.connectionTestRetrofit => '除连接测试外，所有功能都使用 Retrofit',
      MigrationPhase.retrofitOnly => '所有功能都使用新的 Retrofit 实现',
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.api,
                  color: _isRetrofitEnabled ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'Retrofit 迁移状态',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Switch(
                  value: _isRetrofitEnabled,
                  onChanged: _toggleRetrofit,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 当前状态
            _buildStatusSection(),
            const SizedBox(height: 16),
            
            // 迁移阶段选择
            _buildPhaseSelection(),
            const SizedBox(height: 16),
            
            // 功能开关状态
            _buildFeatureFlags(),
            const SizedBox(height: 16),
            
            // 测试按钮
            _buildTestSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '当前状态',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _isRetrofitEnabled ? Colors.green : Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _isRetrofitEnabled ? '已启用' : '已禁用',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
            Text('迁移阶段: ${_getPhaseName(_currentPhase)}'),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _getPhaseDescription(_currentPhase),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildPhaseSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '迁移阶段',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: MigrationPhase.values.map((phase) {
            final isSelected = phase == _currentPhase;
            return FilterChip(
              label: Text(_getPhaseName(phase).split('使用')[0]),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  _setMigrationPhase(phase);
                }
              },
              backgroundColor: isSelected ? Colors.blue : null,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFeatureFlags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '功能开关',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: FeatureFlags.useRetrofitApi ? Colors.green : Colors.red,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text('Retrofit API: ${FeatureFlags.useRetrofitApi ? "启用" : "禁用"}'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: FeatureFlags.enableRetrofitFallback ? Colors.green : Colors.red,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text('降级机制: ${FeatureFlags.enableRetrofitFallback ? "启用" : "禁用"}'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: FeatureFlags.enableRetrofitPerformanceMonitoring ? Colors.green : Colors.red,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text('性能监控: ${FeatureFlags.enableRetrofitPerformanceMonitoring ? "启用" : "禁用"}'),
          ],
        ),
      ],
    );
  }

  Widget _buildTestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '测试功能',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _testQuickConnectService(),
              child: const Text('测试 QuickConnect 服务'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _resetConfiguration(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('重置配置'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _testQuickConnectService() async {
    try {
      final service = ref.read(quickConnectServiceProvider);
      
      // 测试地址解析
      final address = await service.resolveAddress('demo');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('测试完成: ${address ?? "未找到地址"}'),
            backgroundColor: address != null ? Colors.green : Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('测试失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _resetConfiguration() async {
    try {
      await RetrofitMigrationConfig.resetToDefault();
      await _loadMigrationStatus();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('配置已重置'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('重置失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
