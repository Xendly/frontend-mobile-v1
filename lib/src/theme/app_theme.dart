import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    fontFamily: "Plus Jakarta Sans",
    colorScheme: AppColorScheme.lightColorScheme,
    scaffoldBackgroundColor: AppColorScheme.lightColorScheme.background,
    buttonTheme: AppButtonTheme.buttonTheme,
    filledButtonTheme: AppButtonTheme.filledButtonTheme,
    textTheme: AppTextTheme.textTheme,
    dividerTheme: const DividerThemeData(
      thickness: 2,
      color: AppColors.grey,
    ),
  );
}

@immutable
class AppColorScheme {
  static const lightColorScheme = ColorScheme.light(
    primary: AppColors.white,
    secondary: AppColors.black,
    tertiary: AppColors.grey,
    background: AppColors.white,
  );
}

@immutable
class AppButtonTheme {
  // whole button theme styling
  static final buttonTheme = ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    buttonColor: AppColors.black,
  );

  // filled button styling
  static final filledButtonTheme = FilledButtonThemeData(
    style: AppButtonTheme.filledButtonStyle,
  );
  static final filledButtonStyle = FilledButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    textStyle: AppTextTheme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w500,
      color: AppColors.white,
      fontFamily: "Plus Jakarta Sans",
    ),
    padding: const EdgeInsets.only(bottom: 2),
    backgroundColor: AppColors.navy,
    minimumSize: const Size(double.infinity, 56),
  );
}

@immutable
class AppTextTheme {
  static const textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 56,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontSize: 40,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    headlineLarge: TextStyle(
      fontSize: 26,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    // subtitles
    titleLarge: TextStyle(
      fontSize: 16,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontSize: 13,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
    ),
  );
}

class AppColors {
  static const Color white = Color(0XFFFFFFFF);
  static const Color black = Color(0XFF212121);
  static const Color grey = Color(0XFFB7B7B7);
  static const Color navy = Color(0XFF0A114B);
}
