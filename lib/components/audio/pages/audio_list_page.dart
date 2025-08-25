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
  @override
  void initState() {
    super.initState();
    // 在 initState 中调用接口获取歌曲列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(songListNotifierProvider.notifier).getSongList();
    });
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
                      onPressed: () => ref.read(songListNotifierProvider.notifier).getSongList(),
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
                            onPressed: () => ref.read(songListNotifierProvider.notifier).refresh(),
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
                          ? ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              itemCount: songList.songs?.length,
                              itemBuilder: (context, index) {
                                final song = songList.songs?[index];
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
                                              song?.title ?? '未知标题',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              song?.path ?? '未知路径',
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
                                          song?.type ?? 'unknown',
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
