import 'package:ecobin/core/presentation/themes/colors.dart';
import 'package:flutter/material.dart';

class AppThemesData {
  static lightTheme() => ThemeData(
    scaffoldBackgroundColor: AppColors.kWhite,
    primaryColor: AppColors.kPrimary,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.kPrimary,
      onPrimary: AppColors.kWhite,
      onSurfaceVariant: AppColors.kSlateGray,
      surface: AppColors.kWhite,
      onSecondary: AppColors.kPayneGray,
      secondary: AppColors.kPayneGray,
      onError: AppColors.kError500,
      error: AppColors.kError500,
      onSurface: AppColors.kPayneGray,
    ),
  );
}
