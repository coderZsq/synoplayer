import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/auth/auth_state_notifier.dart';
import '../core/di/providers.dart';
import '../quickconnect/entities/song_list_all/song_list_all_response.dart';
import '../quickconnect/presentation/services/song_list_service.dart';

// 歌曲列表状态管理
class SongListNotifier extends StateNotifier<AsyncValue<SongListAllResponse?>> {
  final SongListService _songListService;

  SongListNotifier(this._songListService) : super(const AsyncValue.loading());

  Future<void> getSongList() async {
    state = const AsyncValue.loading();
    try {
      final result = await _songListService.getSongList();
      state = AsyncValue.data(result);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void refresh() {
    getSongList();
  }
}

final songListNotifierProvider = StateNotifierProvider<SongListNotifier, AsyncValue<SongListAllResponse?>>((ref) {
  final songListService = ref.watch(songListServiceProvider);
  return SongListNotifier(songListService);
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听歌曲列表状态
    final songListState = ref.watch(songListNotifierProvider);
    
    // 页面初始化时自动加载歌曲列表
    ref.listen(songListNotifierProvider, (previous, next) {
      // 只在首次加载时触发
      if (previous == null && next.isLoading) {
        // 已经在初始化时加载了
      }
    });

    // 使用 Future.microtask 确保在 build 完成后执行
    Future.microtask(() {
      if (songListState.isLoading && songListState.value == null) {
        ref.read(songListNotifierProvider.notifier).getSongList();
      }
    });

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('🏠 主页'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              songListState.when(
                loading: () => const Column(
                  children: [
                    CupertinoActivityIndicator(),
                    SizedBox(height: 16),
                    Text('正在加载歌曲列表...'),
                  ],
                ),
                error: (error, stackTrace) => Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '错误: $error',
                        style: const TextStyle(color: CupertinoColors.systemRed),
                      ),
                      const SizedBox(height: 8),
                      CupertinoButton.filled(
                        onPressed: () => ref.read(songListNotifierProvider.notifier).getSongList(),
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                ),
                data: (songList) => songList == null
                    ? const Text('暂无数据')
                    : Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '歌曲列表',
                                  style: TextStyle(
                                    color: CupertinoColors.systemGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => ref.read(songListNotifierProvider.notifier).refresh(),
                                  child: const Icon(
                                    CupertinoIcons.refresh,
                                    size: 16,
                                    color: CupertinoColors.systemBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (songList.data?.songs != null && songList.data!.songs!.isNotEmpty) ...[
                              Text(
                                '共 ${songList.data?.total ?? 0} 首歌曲',
                                style: const TextStyle(
                                  color: CupertinoColors.systemGreen,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                constraints: const BoxConstraints(maxHeight: 200),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: songList.data!.songs!.length,
                                  itemBuilder: (context, index) {
                                    final song = songList.data!.songs![index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 4),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: CupertinoColors.systemBackground,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: CupertinoColors.systemGrey4,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.music_note,
                                            size: 16,
                                            color: CupertinoColors.systemBlue,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  song.title ?? '未知标题',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  song.path ?? '未知路径',
                                                  style: const TextStyle(
                                                    fontSize: 12,
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
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: CupertinoColors.systemGrey5,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              song.type ?? 'unknown',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: CupertinoColors.systemGrey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ] else ...[
                              const Text(
                                '暂无歌曲数据',
                                style: TextStyle(
                                  color: CupertinoColors.systemGrey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
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
