// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeServiceHash() => r'b66070108bd53fa9a711625ecf5fc04ecc6d862d';

/// 主题服务 Provider
///
/// Copied from [themeService].
@ProviderFor(themeService)
final themeServiceProvider = AutoDisposeProvider<ThemeService>.internal(
  themeService,
  name: r'themeServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$themeServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ThemeServiceRef = AutoDisposeProviderRef<ThemeService>;
String _$currentThemeModeHash() => r'0ec6685944a9272ce28b6e92aa0ae250fc124a8c';

/// Flutter ThemeMode Provider（用于 MaterialApp）
///
/// Copied from [currentThemeMode].
@ProviderFor(currentThemeMode)
final currentThemeModeProvider = AutoDisposeProvider<ThemeMode>.internal(
  currentThemeMode,
  name: r'currentThemeModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentThemeModeRef = AutoDisposeProviderRef<ThemeMode>;
String _$isDarkModeHash() => r'3a376d9c1fe77627dd41f4d9dfedb711e7e8d349';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 当前是否为暗黑模式 Provider
///
/// Copied from [isDarkMode].
@ProviderFor(isDarkMode)
const isDarkModeProvider = IsDarkModeFamily();

/// 当前是否为暗黑模式 Provider
///
/// Copied from [isDarkMode].
class IsDarkModeFamily extends Family<bool> {
  /// 当前是否为暗黑模式 Provider
  ///
  /// Copied from [isDarkMode].
  const IsDarkModeFamily();

  /// 当前是否为暗黑模式 Provider
  ///
  /// Copied from [isDarkMode].
  IsDarkModeProvider call(
    BuildContext context,
  ) {
    return IsDarkModeProvider(
      context,
    );
  }

  @override
  IsDarkModeProvider getProviderOverride(
    covariant IsDarkModeProvider provider,
  ) {
    return call(
      provider.context,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isDarkModeProvider';
}

/// 当前是否为暗黑模式 Provider
///
/// Copied from [isDarkMode].
class IsDarkModeProvider extends AutoDisposeProvider<bool> {
  /// 当前是否为暗黑模式 Provider
  ///
  /// Copied from [isDarkMode].
  IsDarkModeProvider(
    BuildContext context,
  ) : this._internal(
          (ref) => isDarkMode(
            ref as IsDarkModeRef,
            context,
          ),
          from: isDarkModeProvider,
          name: r'isDarkModeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isDarkModeHash,
          dependencies: IsDarkModeFamily._dependencies,
          allTransitiveDependencies:
              IsDarkModeFamily._allTransitiveDependencies,
          context: context,
        );

  IsDarkModeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final BuildContext context;

  @override
  Override overrideWith(
    bool Function(IsDarkModeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsDarkModeProvider._internal(
        (ref) => create(ref as IsDarkModeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsDarkModeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsDarkModeProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsDarkModeRef on AutoDisposeProviderRef<bool> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _IsDarkModeProviderElement extends AutoDisposeProviderElement<bool>
    with IsDarkModeRef {
  _IsDarkModeProviderElement(super.provider);

  @override
  BuildContext get context => (origin as IsDarkModeProvider).context;
}

String _$themeNotifierHash() => r'3f897d5a320214cf7d358dbf5b099c1273e315c7';

/// 当前主题模式 Provider
///
/// Copied from [ThemeNotifier].
@ProviderFor(ThemeNotifier)
final themeNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ThemeNotifier, AppThemeMode>.internal(
  ThemeNotifier.new,
  name: r'themeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeNotifier = AutoDisposeAsyncNotifier<AppThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
