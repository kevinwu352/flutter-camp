import 'package:hive/hive.dart';

extension HiveBoxExt<E> on Box<E> {
  bool? getBool(String? key) {
    final value = key is String ? get(key) : null;
    return value is bool ? value : null;
  }

  int? getInt(String? key) {
    final value = key is String ? get(key) : null;
    return value is int ? value : null;
  }

  double? getDouble(String? key) {
    final value = key is String ? get(key) : null;
    return value is double ? value : null;
  }

  String? getString(String? key) {
    final value = key is String ? get(key) : null;
    return value is String ? value : null;
  }

  List<dynamic>? getList(String? key) {
    final value = key is String ? get(key) : null;
    return value is List ? value : null;
  }

  Map<String, dynamic>? getMap(String? key) {
    final value = key is String ? get(key) : null;
    return value is Map ? value.map((k, v) => MapEntry(k.toString(), v)) : null;
  }

  T? getObject<T>(String? key, T Function(Map<String, dynamic>) init) {
    final map = getMap(key);
    return map is Map<String, dynamic> ? init(map) : null;
  }
}
