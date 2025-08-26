import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_state_notifier.dart';
import '../providers/audio_list_provider.dart';

class AudioListPage extends ConsumerStatefulWidget {
  const AudioListPage({super.key});

  @override
  ConsumerState<AudioListPage> createState() => _AudioListPageState();
}

class _AudioListPageState extends ConsumerState<AudioListPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    // 在 initState 中调用接口获取歌曲列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(songListNotifierProvider.notifier).getSongList(isRefresh: true);
    });
    
    // 添加滚动监听器
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;
    
    final notifier = ref.read(songListNotifierProvider.notifier);
    if (!notifier.hasMoreData) return;
    
    setState(() {
      _isLoadingMore = true;
    });
    
    await notifier.loadMore();
    
    setState(() {
      _isLoadingMore = false;
    });
  }

  Future<void> _onRefresh() async {
    ref.read(songListNotifierProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    // 监听歌曲列表状态
    final songListState = ref.watch(songListNotifierProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('音频'),
        backgroundColor: CupertinoColors.systemBackground,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            ref.read(authStateNotifierProvider.notifier).logout();
            context.go('/login');
          },
          child: const Text('登出'),
        ),
      ),
      child: SafeArea(
        child: songListState.when(
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(),
                SizedBox(height: 16),
                Text('正在加载歌曲列表...'),
              ],
            ),
          ),
          error: (error, stackTrace) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '错误: $error',
                      style: const TextStyle(color: CupertinoColors.systemRed),
                    ),
                    const SizedBox(height: 8),
                    CupertinoButton.filled(
                      onPressed: () => ref.read(songListNotifierProvider.notifier).getSongList(isRefresh: true),
                      child: const Text('重试'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          data: (songList) => songList == null
              ? const Center(child: Text('暂无数据'))
              : Column(
                  children: [
                    // 标题和刷新按钮
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '歌曲列表',
                            style: TextStyle(
                              color: CupertinoColors.systemGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: _onRefresh,
                            child: const Icon(
                              CupertinoIcons.refresh,
                              size: 20,
                              color: CupertinoColors.systemBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 歌曲总数
                    if (songList.songs != null && songList.songs?.isNotEmpty == true) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '共 ${songList.total ?? 0} 首歌曲',
                          style: const TextStyle(
                            color: CupertinoColors.systemGreen,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    // 歌曲列表
                    Expanded(
                      child: songList.songs != null && songList.songs?.isNotEmpty == true
                          ? CupertinoScrollbar(
                              controller: _scrollController,
                              child: CustomScrollView(
                                controller: _scrollController,
                                slivers: [
                                  CupertinoSliverRefreshControl(
                                    onRefresh: _onRefresh,
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                          // 显示加载更多指示器
                                          if (index == songList.songs!.length) {
                                            if (ref.read(songListNotifierProvider.notifier).hasMoreData) {
                                              return Container(
                                                padding: const EdgeInsets.all(16),
                                                child: Center(
                                                  child: _isLoadingMore
                                                      ? const CupertinoActivityIndicator()
                                                      : const Text(
                                                          '上拉加载更多',
                                                          style: TextStyle(
                                                            color: CupertinoColors.systemGrey,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                ),
                                              );
                                            } else {
                                              return Container(
                                                padding: const EdgeInsets.all(16),
                                                child: const Center(
                                                  child: Text(
                                                    '没有更多数据了',
                                                    style: TextStyle(
                                                      color: CupertinoColors.systemGrey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                          
                                          final song = songList.songs![index];
                                          return Container(
                                            margin: const EdgeInsets.only(bottom: 8),
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: CupertinoColors.systemBackground,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                color: CupertinoColors.systemGrey4,
                                                width: 1,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: CupertinoColors.systemGrey.withOpacity(0.1),
                                                  blurRadius: 2,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.music_note,
                                                  size: 20,
                                                  color: CupertinoColors.systemBlue,
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        song.title ?? '未知标题',
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 16,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        song.path ?? '未知路径',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: CupertinoColors.systemGrey,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: CupertinoColors.systemGrey5,
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    song.type ?? 'unknown',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: CupertinoColors.systemGrey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        childCount: (songList.songs?.length ?? 0) + 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.music_note,
                                    size: 48,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    '暂无歌曲数据',
                                    style: TextStyle(
                                      color: CupertinoColors.systemGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
