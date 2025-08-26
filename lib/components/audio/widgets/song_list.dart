import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../quickconnect/entities/song_list_all/song_list_all_response.dart';
import '../providers/audio_list_provider.dart';
import 'song_item.dart';
import 'load_more_indicator.dart';

class SongList extends ConsumerWidget {
  final SongListData songList;
  final ScrollController scrollController;
  final Function(String songId, String songTitle)? onSongTap;
  final Future<void> Function()? onRefresh;

  const SongList({
    super.key,
    required this.songList,
    required this.scrollController,
    this.onSongTap,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = songList.songs ?? [];
    final hasMoreData = songs.length < (songList.total ?? 0);
    final notifier = ref.read(songListNotifierProvider.notifier);

    return CupertinoScrollbar(
      controller: scrollController,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          if (onRefresh != null)
            CupertinoSliverRefreshControl(
              onRefresh: onRefresh!,
            ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // 显示加载更多指示器
                  if (index == songs.length) {
                    return LoadMoreIndicator(
                      isLoading: notifier.isLoadingMore,
                      hasMoreData: hasMoreData,
                    );
                  }

                  final song = songs[index];
                  return SongItem(
                    song: song,
                    onTap: onSongTap,
                  );
                },
                childCount: songs.length + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
