import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/audio_player_provider.dart';

class AudioPlayerControls extends ConsumerWidget {
  const AudioPlayerControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayerService = ref.watch(audioPlayerNotifierProvider);
    final isPlaying = audioPlayerService.isPlaying;
    final isLoading = audioPlayerService.isLoading;
    final currentSongTitle = audioPlayerService.currentSongTitle;
    final position = audioPlayerService.position;
    final duration = audioPlayerService.duration;
    final error = audioPlayerService.error;

    if (currentSongTitle == null || currentSongTitle.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        border: Border(
          top: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 歌曲信息
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentSongTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (error != null)
                      Text(
                        error,
                        style: const TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemRed,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // 进度条
          if (duration.inSeconds > 0)
            Column(
              children: [
                CupertinoSlider(
                  value: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    ref.read(audioPlayerNotifierProvider.notifier).seekTo(
                      Duration(seconds: value.toInt()),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(position),
                      style: const TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    Text(
                      _formatDuration(duration),
                      style: const TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          
          const SizedBox(height: 12),
          
          // 控制按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                padding: const EdgeInsets.all(12),
                onPressed: isLoading ? null : () {
                  ref.read(audioPlayerNotifierProvider.notifier).stop();
                },
                child: const Icon(
                  CupertinoIcons.stop_fill,
                  size: 24,
                  color: CupertinoColors.systemRed,
                ),
              ),
              const SizedBox(width: 16),
              CupertinoButton(
                padding: const EdgeInsets.all(16),
                onPressed: isLoading ? null : () {
                  if (isPlaying) {
                    ref.read(audioPlayerNotifierProvider.notifier).pause();
                  } else {
                    ref.read(audioPlayerNotifierProvider.notifier).resume();
                  }
                },
                child: Icon(
                  isLoading
                      ? CupertinoIcons.clock
                      : isPlaying
                          ? CupertinoIcons.pause_fill
                          : CupertinoIcons.play_fill,
                  size: 32,
                  color: CupertinoColors.systemBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
