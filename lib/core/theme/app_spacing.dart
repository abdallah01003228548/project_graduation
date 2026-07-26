import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double base1x = 8.0;
  static const double base2x = 16.0;
  static const double base3x = 24.0;
  static const double base4x = 32.0;
  static const double base5x = 40.0;
  static const double base6x = 48.0;
  static const EdgeInsets screenHorizontal =
      EdgeInsets.symmetric(horizontal: base3x);

  static const EdgeInsets screenAll =
      EdgeInsets.all(base6x);
}