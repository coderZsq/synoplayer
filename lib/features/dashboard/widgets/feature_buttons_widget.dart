import 'package:flutter/material.dart';

/// 功能按钮组件
/// 
/// 显示各种功能入口按钮
class FeatureButtonsWidget extends StatelessWidget {
  const FeatureButtonsWidget({
    super.key,
    required this.onTestConnection,
    required this.onFileManager,
    required this.onSystemMonitor,
    required this.onSettings,
    required this.isLoading,
  });

  final VoidCallback onTestConnection;
  final VoidCallback onFileManager;
  final VoidCallback onSystemMonitor;
  final VoidCallback onSettings;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 第一行按钮
        Row(
          children: [
            Expanded(
              child: _buildFeatureButton(
                context,
                icon: Icons.wifi,
                label: '测试连接',
                color: Colors.green,
                onPressed: isLoading ? null : onTestConnection,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFeatureButton(
                context,
                icon: Icons.folder,
                label: '文件管理',
                color: Colors.orange,
                onPressed: onFileManager,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // 第二行按钮
        Row(
          children: [
            Expanded(
              child: _buildFeatureButton(
                context,
                icon: Icons.monitor,
                label: '系统监控',
                color: Colors.purple,
                onPressed: onSystemMonitor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFeatureButton(
                context,
                icon: Icons.settings,
                label: '设置',
                color: Colors.grey,
                onPressed: onSettings,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                size: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
