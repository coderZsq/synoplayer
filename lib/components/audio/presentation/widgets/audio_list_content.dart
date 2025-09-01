import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../base/theme/theme.dart';
import '../../entities/song_list_all/song_list_all_response.dart';
import '../providers/audio_list_provider.dart';
import 'song_list.dart';
import 'empty_state.dart';

class AudioListContent extends ConsumerWidget {
  final SongListData songList;
  final ScrollController scrollController;
  final Function(String songId, String songTitle)? onSongTap;

  const AudioListContent({
    super.key,
    required this.songList,
    required this.scrollController,
    this.onSongTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = songList.songs ?? [];
    final hasData = songs.isNotEmpty;
    final notifier = ref.read(songListNotifierProvider.notifier);

    return Container(
      color: context.backgroundColor,
      child: Column(
        children: [
          Expanded(
            child: hasData
                ? SongList(
                    songList: songList,
                    scrollController: scrollController,
                    onSongTap: onSongTap,
                    onRefresh: () => notifier.refresh(),
                  )
                : const EmptyState(),
          ),
        ],
      ),
    );
  }
}
