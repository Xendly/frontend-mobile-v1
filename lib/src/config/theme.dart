import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

Size btnSize = const Size(double.infinity, 54);
var btnShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(6),
);

ThemeData themeData = ThemeData(
  fontFamily: "Plus Jakarta Sans",
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: XMColors.primary0,
  colorScheme: const ColorScheme.light(
    primary: XMColors.primary0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: XMColors.primary0,
      elevation: 0,
      minimumSize: btnSize,
      shape: btnShape,
      side: const BorderSide(
        color: XMColors.primary0,
        width: 1.2,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: XMColors.none,
      minimumSize: btnSize,
      shape: btnShape,
      side: const BorderSide(
        color: XMColors.primary0,
        width: 1.2,
      ),
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 48,
      letterSpacing: 0.4,
      color: XMColors.shade0,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 34,
      letterSpacing: 0.2,
      color: XMColors.shade0,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 28,
      letterSpacing: 0.2,
      color: XMColors.shade0,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 26,
      letterSpacing: 0.2,
      color: XMColors.shade0,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      letterSpacing: 0.2,
      color: XMColors.shade0,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      letterSpacing: 0.1,
      height: 1.4,
      color: XMColors.shade0,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.1,
      height: 1.4,
      color: XMColors.shade0,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0.1,
      color: XMColors.shade0,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0.1,
      color: XMColors.shade0,
    ),
  ),
);
