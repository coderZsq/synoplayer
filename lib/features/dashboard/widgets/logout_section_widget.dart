import 'package:flutter/material.dart';

/// 退出登录区域组件
/// 
/// 提供安全的退出登录功能
class LogoutSectionWidget extends StatelessWidget {
  const LogoutSectionWidget({
    super.key,
    required this.onLogout,
    required this.isLoading,
  });

  final VoidCallback onLogout;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark 
            ? Colors.red.shade900.withOpacity(0.3)
            : Colors.red.shade50,
        border: Border.all(
          color: isDark 
              ? Colors.red.shade700
              : Colors.red.shade200,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Row(
            children: [
              Icon(
                Icons.security,
                color: isDark ? Colors.red.shade300 : Colors.red.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '账户安全',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.red.shade300 : Colors.red.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // 描述
          Text(
            '如果您不再使用此设备，或者想要切换到其他账户，可以安全退出登录',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.red.shade200 : Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          // 退出登录按钮
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : () => _showLogoutConfirmDialog(context),
              icon: isLoading 
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.onError,
                        ),
                      ),
                    )
                  : const Icon(Icons.logout),
              label: Text(isLoading ? '退出中...' : '退出登录'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 显示退出登录确认对话框
  void _showLogoutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Text('确认退出'),
            ],
          ),
          content: const Text(
            '您确定要退出登录吗？\n\n退出后需要重新输入登录信息才能访问群晖服务。',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onLogout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('确认退出'),
            ),
          ],
        );
      },
    );
  }
}
