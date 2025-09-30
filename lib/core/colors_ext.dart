import 'dart:math';
import 'package:flutter/material.dart';

extension ColorsExt on Colors {
  static Color rand() {
    final random = Random();
    return Color.fromARGB(random.nextInt(256), random.nextInt(256), random.nextInt(256), random.nextInt(256));
  }
}
