import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../entities/song_list_all/song_list_all_response.dart';
import '../providers/audio_player_provider.dart';

class SongItem extends ConsumerWidget {
  final Song song;
  final Function(String songId, String songTitle)? onTap;

  const SongItem({
    super.key,
    required this.song,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayerServiceAsync = ref.watch(audioPlayerNotifierProvider);
    
    return audioPlayerServiceAsync.when(
      data: (audioPlayerService) {
        final isCurrentSong = audioPlayerService.currentSongId == song.id;
        final isPlaying = isCurrentSong && audioPlayerService.isPlaying;
        
        return GestureDetector(
          onTap: () {
            if (isCurrentSong && isPlaying) {
              // 如果当前歌曲正在播放，则暂停
              ref.read(audioPlayerNotifierProvider.notifier).pause();
            } else if (isCurrentSong && !isPlaying) {
              // 如果当前歌曲已暂停，则继续播放
              ref.read(audioPlayerNotifierProvider.notifier).resume();
            } else {
              // 播放新歌曲
              onTap?.call(song.id ?? '', song.title ?? '未知标题');
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCurrentSong 
                  ? CupertinoColors.systemBlue.withOpacity(0.1)
                  : CupertinoColors.systemBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isCurrentSong 
                    ? CupertinoColors.systemBlue
                    : CupertinoColors.systemGrey4,
                width: isCurrentSong ? 2 : 1,
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
                Icon(
                  isPlaying ? CupertinoIcons.pause_circle_fill : CupertinoIcons.music_note,
                  size: 20,
                  color: isCurrentSong 
                      ? CupertinoColors.systemBlue
                      : CupertinoColors.systemGrey,
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
          ),
        );
      },
      loading: () => const CupertinoActivityIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
