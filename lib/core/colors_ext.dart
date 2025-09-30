import 'dart:math';
import 'package:flutter/material.dart';

extension ColorsExt on Colors {
  static Color rand() => Color((Random().nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: 1.0);
}
