// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'river_app1.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(city)
final cityProvider = CityProvider._();

final class CityProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  CityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cityHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return city(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$cityHash() => r'6a5023a3aba119f1ecaee6c7db44b3f519e72759';

@ProviderFor(joke1)
final joke1Provider = Joke1Provider._();

final class Joke1Provider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  Joke1Provider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'joke1Provider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joke1Hash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return joke1(ref);
  }
}

String _$joke1Hash() => r'e1b0e2041f48d7ab937f5f65198fcd2d84af8c6f';
