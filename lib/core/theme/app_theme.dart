import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryOrange,
      secondary: AppColors.orangeLight,
      surface: AppColors.white,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.charcoal,
    ),

    scaffoldBackgroundColor: AppColors.offWhite,


    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.h2Heading,
      headlineMedium: AppTextStyles.h3Heading,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.buttonText,
      labelSmall: AppTextStyles.captionLabel,
    ),
  );
}