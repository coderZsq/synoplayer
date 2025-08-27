import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../base/auth/auth_state_notifier.dart';
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
    ref.read(audioPlayerNotifierProvider.notifier).playSong(songId, songTitle);
  }

  @override
  Widget build(BuildContext context) {
    // 监听歌曲列表状态
    final songListState = ref.watch(songListNotifierProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('音频'),
        backgroundColor: CupertinoColors.systemBackground,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 刷新按钮
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _onRefresh,
              child: const Icon(
                CupertinoIcons.refresh,
                size: 20,
                color: CupertinoColors.systemBlue,
              ),
            ),
            // 登出按钮
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                ref.read(authStateNotifierProvider.notifier).logout();
                context.go('/login');
              },
              child: const Text('登出'),
            ),
          ],
        ),
      ),
      child: SafeArea(
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
            const AudioPlayerControls(),
          ],
        ),
      ),
    );
  }
}
