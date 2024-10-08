import 'package:flutter/material.dart';
import 'package:flutter_chant_social_task/config/extensions/context_extension.dart';

import '../items/colors/app_colors.dart';

class AppTheme {
  const AppTheme._();
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: AppColors.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: context.dynamicHeight(0.037),
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: context.dynamicHeight(0.032),
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: context.dynamicHeight(0.027),
        ),
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: context.dynamicHeight(0.037),
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: context.dynamicHeight(0.027),
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.022),
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: context.dynamicHeight(0.037),
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.027),
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.022),
        ),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: context.dynamicHeight(0.027),
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: context.dynamicHeight(0.022),
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: context.dynamicHeight(0.017),
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.027),
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.022),
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.017),
        ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: AppColors.scaffoldBackgroundColor,
          backgroundColor: AppColors.scaffoldBackgroundColor,
          elevation: 0,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: context.dynamicHeight(0.037),
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: context.dynamicHeight(0.032),
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: context.dynamicHeight(0.027),
          ),
          headlineLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: context.dynamicHeight(0.037),
          ),
          headlineSmall: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: context.dynamicHeight(0.027),
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: context.dynamicHeight(0.022),
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: context.dynamicHeight(0.037),
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: context.dynamicHeight(0.027),
          ),
          titleSmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: context.dynamicHeight(0.022),
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: context.dynamicHeight(0.027),
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: context.dynamicHeight(0.022),
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: context.dynamicHeight(0.017),
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: context.dynamicHeight(0.027),
          ),
          labelMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: context.dynamicHeight(0.022),
          ),
          labelSmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: context.dynamicHeight(0.017),
          ),
        ),
      );
}
