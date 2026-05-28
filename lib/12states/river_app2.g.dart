// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'river_app2.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Tick)
final tickProvider = TickProvider._();

final class TickProvider extends $NotifierProvider<Tick, int> {
  TickProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tickProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tickHash();

  @$internal
  @override
  Tick create() => Tick();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$tickHash() => r'6f3ae74de6df96caa8db10a2172fe74e232ec5e4';

abstract class _$Tick extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(isDivisibleBy4)
final isDivisibleBy4Provider = IsDivisibleBy4Provider._();

final class IsDivisibleBy4Provider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsDivisibleBy4Provider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isDivisibleBy4Provider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isDivisibleBy4Hash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isDivisibleBy4(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isDivisibleBy4Hash() => r'cfa237515469769cef51753061821bbcaab497b0';

@ProviderFor(joke2)
final joke2Provider = Joke2Provider._();

final class Joke2Provider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  Joke2Provider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'joke2Provider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joke2Hash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return joke2(ref);
  }
}

String _$joke2Hash() => r'd7deb9905bf52e5ff4e87fd114f9bf2e73359595';
