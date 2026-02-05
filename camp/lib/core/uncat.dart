import 'dart:math';
import 'package:flutter/material.dart';

// withValue(getMap(key), (v) => v != null ? init(v) : null);
T2 withValue<T1, T2>(T1 v, T2 Function(T1 v) h) => h(v);

// time check
bool timeValid(DateTime? time, Duration duration) => time != null && time.add(duration).isAfter(DateTime.now());
bool timeExpired(DateTime? time, Duration duration) => time == null || time.add(duration).isBefore(DateTime.now());

// random color
extension ColorsExt on Colors {
  static Color rand() => Color((Random().nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: 1.0);
}
