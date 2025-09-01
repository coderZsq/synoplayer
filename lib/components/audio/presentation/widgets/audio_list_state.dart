import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../base/theme/theme.dart';
import '../../entities/song_list_all/song_list_all_response.dart';
import 'loading_state.dart';
import 'error_state.dart';
import 'audio_list_content.dart';

class AudioList extends ConsumerWidget {
  final AsyncValue<SongListData?> songListState;
  final ScrollController scrollController;
  final VoidCallback onRetry;
  final Function(String songId, String songTitle)? onSongTap;

  const AudioList({
    super.key,
    required this.songListState,
    required this.scrollController,
    required this.onRetry,
    this.onSongTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return songListState.when(
      loading: () => const LoadingState(),
      error: (error, stackTrace) => ErrorState(
        error: error.toString(),
        onRetry: onRetry,
      ),
      data: (songList) => songList == null
          ? Container(
              color: context.backgroundColor,
              child: Center(
                child: Text(
                  '暂无数据',
                  style: TextStyle(color: context.tertiaryTextColor),
                ),
              ),
            )
          : AudioListContent(
              songList: songList,
              scrollController: scrollController,
              onSongTap: onSongTap,
            ),
    );
  }
}
