import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/audio_player_provider.dart';

class AudioPlayerControls extends ConsumerWidget {
  const AudioPlayerControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayerState = ref.watch(audioPlayerNotifierProvider);
    
    return audioPlayerState.when(
      data: (audioPlayerState) {
        final isPlaying = audioPlayerState.isPlaying;
        final isLoading = audioPlayerState.isLoading;
        final currentSongTitle = audioPlayerState.currentSongTitle;
        final position = audioPlayerState.position;
        final duration = audioPlayerState.duration;
        final error = audioPlayerState.error;
        final displayTitle = currentSongTitle ?? '未选择歌曲';
        final displayStatus = isPlaying ? '播放中' : (isLoading ? '加载中' : '已停止');

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
                          displayTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          displayStatus,
                          style: const TextStyle(
                            fontSize: 12,
                            color: CupertinoColors.systemGrey,
                          ),
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
              
              // 倍速选择器
              Column(
                children: [
                  const Text(
                    '倍速: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    children: [1.0, 1.25, 1.5, 2.0, 3.0, 4.0, 5.0].map((speed) {
                      final isSelected = (audioPlayerState.playbackSpeed - speed).abs() < 0.01;
                      return CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        minimumSize: Size.zero,
                        onPressed: isLoading ? null : () {
                          ref.read(audioPlayerNotifierProvider.notifier).setPlaybackSpeed(speed);
                        },
                        child: Text(
                          '${speed}x',
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected 
                                ? CupertinoColors.systemBlue 
                                : CupertinoColors.systemGrey,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
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
      },
      loading: () => const CupertinoActivityIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
