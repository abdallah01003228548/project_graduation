import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  /// H2 - Heading
  static const TextStyle h2Heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  /// H3 - Heading
  static const TextStyle h3Heading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.125,
  );

  /// Body - Large
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1,
  );

  /// Body - Medium
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 0.875,
  );

  /// Body - Small
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 0.75,
  );

  /// Button Text
  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 0.875,
  );

  /// Caption / Label
  static const TextStyle captionLabel = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 0.625,
  );
}
