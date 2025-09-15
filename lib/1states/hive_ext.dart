import 'package:hive/hive.dart';

import '/core/core.dart';

extension HiveBoxExt<E> on Box<E> {
  Future<void> setValue(String? key, E? value) async {
    if (key is String) {
      if (value is E) {
        await put(key, value);
      } else {
        await delete(key);
      }
    }
  }

  E? getValue(String? key) => key is String ? get(key) : null;

  // ================================================================================

  bool? getBool(String? key) => getValue(key).asOr<bool>();
  int? getInt(String? key) => getValue(key).asOr<int>();
  double? getDouble(String? key) => getValue(key).asOr<double>();
  String? getString(String? key) => getValue(key).asOr<String>();

  List<Object?>? getList(String? key) => getValue(key).asOr<List<Object?>>();

  Map<String, Object?>? getMap(String? key) => getValue(key).asOr<Map>()?.keyed().whereType<Object?>();

  // ================================================================================

  // List<dynamic>? getList(String? key) {
  //   final value = key is String ? get(key) : null;
  //   return value is List ? value : null;
  // }

  // Map<String, dynamic>? getMap(String? key) {
  //   final value = key is String ? get(key) : null;
  //   return value is Map ? value.map((k, v) => MapEntry(k.toString(), v)) : null;
  // }

  // T? getObject<T>(String? key, T Function(Map<String, dynamic>) init) {
  //   final map = getMap(key);
  //   return map is Map<String, dynamic> ? init(map) : null;
  // }
}
