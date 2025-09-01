import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../base/auth/auth_state_notifier.dart';
import '../../../../../base/theme/theme.dart';
import '../providers/audio_list_provider.dart';
import '../providers/audio_player_provider.dart';
import '../widgets/audio_list_state.dart';
import '../widgets/audio_player_controls.dart';

class AudioListPage extends ConsumerStatefulWidget {
  const AudioListPage({super.key});

  @override
  ConsumerState<AudioListPage> createState() => _AudioListPageState();
}

class _AudioListPageState extends ConsumerState<AudioListPage> {
  final ScrollController _scrollController = ScrollController();

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
    final notifier = ref.read(songListNotifierProvider.notifier);
    if (!notifier.hasMoreData) return;
    await notifier.loadMore();
  }

  Future<void> _onRefresh() async {
    ref.read(songListNotifierProvider.notifier).refresh();
  }

  void _onRetry() {
    ref.read(songListNotifierProvider.notifier).getSongList(isRefresh: true);
  }

  void _onSongTap(String songId, String songTitle) {
    // 获取当前歌曲列表并设置为播放列表
    final songListState = ref.read(songListNotifierProvider);
    songListState.whenData((songList) {
      if (songList != null && songList.songs != null) {
        // 创建歌曲ID到标题的映射
        final songMap = <String, String>{};
        for (final song in songList.songs!) {
          if (song.id != null && song.id!.isNotEmpty && song.title != null) {
            songMap[song.id!] = song.title!;
          }
        }
        
        if (songMap.isNotEmpty) {
          // 设置播放列表（包含标题信息）
          ref.read(audioPlayerNotifierProvider.notifier).setPlaylistWithTitles(songMap);
        }
      }
    });
    
    // 播放选中的歌曲
    ref.read(audioPlayerNotifierProvider.notifier).playSong(songId, songTitle);
  }

  /// 显示登出错误信息
  void _showLogoutError(String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('登出失败'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 监听歌曲列表状态
    final songListState = ref.watch(songListNotifierProvider);
    // 监听排序状态
    final isSortedByName = ref.watch(songListNotifierProvider.notifier).isSortedByName;

    return CupertinoPageScaffold(
      backgroundColor: context.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '音频',
          style: TextStyle(
            color: context.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: context.primaryBackgroundColor,
        // iOS 设置样式的导航栏配置
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: false,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 排序按钮
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                ref.read(songListNotifierProvider.notifier).toggleSortByName();
              },
              child: Icon(
                isSortedByName ? CupertinoIcons.sort_down : CupertinoIcons.sort_up,
                size: 20,
                color: isSortedByName 
                    ? context.primaryColor
                    : CupertinoColors.systemGrey,
              ),
            ),
            // 刷新按钮
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _onRefresh,
              child: Icon(
                CupertinoIcons.refresh,
                size: 20,
                color: context.primaryColor,
              ),
            ),
            // 登出按钮
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                try {
                  // 等待登出操作完成
                  final result = await ref.read(authStateNotifierProvider.notifier).logout();
                  
                  if (result.isSuccess) {
                    // 登出成功，跳转到登录页
                    if (mounted) {
                      context.go('/login');
                    }
                  } else {
                    // 登出失败，显示错误信息
                    if (mounted) {
                      _showLogoutError(result.error.message);
                    }
                  }
                } catch (e) {
                  // 处理异常情况
                  if (mounted) {
                    _showLogoutError('登出过程中发生异常: $e');
                  }
                }
              },
              child: Text(
                '登出',
                style: TextStyle(color: context.primaryColor),
              ),
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: Container(
          color: context.backgroundColor,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: AudioList(
                        songListState: songListState,
                        scrollController: _scrollController,
                        onRetry: _onRetry,
                        onSongTap: _onSongTap,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.secondaryBackgroundColor,
                  border: Border(
                    top: BorderSide(
                      color: context.separatorColor,
                      width: 0.5,
                    ),
                  ),
                ),
                child: const AudioPlayerControls(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
