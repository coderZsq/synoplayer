import 'package:flutter/material.dart';

/// 连接信息组件
/// 
/// 显示当前连接的详细信息
class ConnectionInfoWidget extends StatelessWidget {
  const ConnectionInfoWidget({
    super.key,
    required this.username,
    required this.quickConnectId,
    required this.workingAddress,
    required this.sessionId,
    required this.loginTime,
  });

  final String username;
  final String quickConnectId;
  final String workingAddress;
  final String sessionId;
  final DateTime loginTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '连接信息',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 信息列表
          _buildInfoRow(
            context,
            '用户名',
            username,
            Icons.person,
          ),
          _buildInfoRow(
            context,
            'QuickConnect ID',
            quickConnectId,
            Icons.router,
          ),
          _buildInfoRow(
            context,
            '连接地址',
            workingAddress,
            Icons.language,
          ),
          _buildInfoRow(
            context,
            '会话状态',
            '活跃',
            Icons.verified,
            Colors.green,
          ),
          _buildInfoRow(
            context,
            '会话ID',
            '${sessionId.substring(0, 20)}...',
            Icons.security,
          ),
          _buildInfoRow(
            context,
            '登录时间',
            _formatDateTime(loginTime),
            Icons.access_time,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, [
    IconData? icon,
    Color? valueColor,
  ]) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图标
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 8),
          ],
          
          // 标签
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          
          // 值
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: 'monospace',
                fontSize: 13,
                color: valueColor ?? theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-'
           '${dateTime.day.toString().padLeft(2, '0')} '
           '${dateTime.hour.toString().padLeft(2, '0')}:'
           '${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
