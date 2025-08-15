import 'package:flutter/material.dart';

/// 日志显示组件
/// 
/// 通用的日志显示区域，支持实时日志输出和清空功能
class LogDisplayWidget extends StatefulWidget {
  const LogDisplayWidget({
    super.key,
    required this.log,
    required this.isLoading,
    this.height = 200,
    this.title = '系统日志',
    this.onClear,
    this.showClearButton = true,
  });

  final String log;
  final bool isLoading;
  final double height;
  final String title;
  final VoidCallback? onClear;
  final bool showClearButton;

  @override
  State<LogDisplayWidget> createState() => _LogDisplayWidgetState();
}

class _LogDisplayWidgetState extends State<LogDisplayWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LogDisplayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // 当日志更新时，自动滚动到底部
    if (widget.log != oldWidget.log && widget.log.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey.shade100,
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          _buildHeader(theme, isDark),
          
          // 日志内容
          Expanded(
            child: _buildLogContent(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey.shade200,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.list_alt,
            size: 16,
            color: theme.iconTheme.color,
          ),
          const SizedBox(width: 8),
          Text(
            widget.title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          
          // 加载指示器
          if (widget.isLoading)
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
            ),
          
          // 清空按钮
          if (widget.showClearButton && widget.onClear != null) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: widget.onClear,
              icon: const Icon(Icons.clear_all),
              iconSize: 16,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              tooltip: '清空日志',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLogContent(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: widget.log.isEmpty
          ? _buildEmptyState(theme)
          : _buildLogText(theme),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notes,
            size: 32,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 8),
          Text(
            '等待操作...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogText(ThemeData theme) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: SelectableText(
        widget.log,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: theme.textTheme.bodyMedium?.color,
          height: 1.4,
        ),
      ),
    );
  }
}
