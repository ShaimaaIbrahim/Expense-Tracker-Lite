import 'package:expense_tracker_lite/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'button_theme.dart';


class AppTheme {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.lightBackground,
      buttonTheme: buttonTheme,
      elevatedButtonTheme: elevatedButtonThemeData,
      floatingActionButtonTheme: floatingActionButtonThemeData,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      useMaterial3: false, 
      scaffoldBackgroundColor: AppColors.primaryColor,
      disabledColor: Colors.grey.shade400,
      buttonTheme: buttonTheme,
      elevatedButtonTheme: elevatedButtonThemeData,
      floatingActionButtonTheme: floatingActionButtonThemeData,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkPrimary,
      ),
    );
  }
}