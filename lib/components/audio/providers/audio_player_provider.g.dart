// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioPlayerServiceHash() =>
    r'deb28a8b570aa4da62d8852133cedcfd77a313c9';

/// See also [audioPlayerService].
@ProviderFor(audioPlayerService)
final audioPlayerServiceProvider =
    AutoDisposeProvider<AudioPlayerService>.internal(
  audioPlayerService,
  name: r'audioPlayerServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioPlayerServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AudioPlayerServiceRef = AutoDisposeProviderRef<AudioPlayerService>;
String _$audioPlayerNotifierHash() =>
    r'd38608fe05a008569c6fcc4f3ffb52dad7d1bf7b';

/// See also [AudioPlayerNotifier].
@ProviderFor(AudioPlayerNotifier)
final audioPlayerNotifierProvider = AutoDisposeNotifierProvider<
    AudioPlayerNotifier, AudioPlayerService>.internal(
  AudioPlayerNotifier.new,
  name: r'audioPlayerNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioPlayerNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudioPlayerNotifier = AutoDisposeNotifier<AudioPlayerService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
