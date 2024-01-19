import 'package:flutter/material.dart';

import 'app_theme.dart';

class DarkTheme {
  DarkTheme._();
  static const Color primaryColor = Color(0xFF312783);
  static ThemeData create() {
    return ThemeData(
      useMaterial3: true,
      //  brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: AppTheme.fontName,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: AppTheme.primarySwatch,
        accentColor: AppTheme.secondaryColor,
        backgroundColor: AppTheme.navBgColor,
        cardColor: AppTheme.darkColor,
        errorColor: AppTheme.errorColor,
      ),
      appBarTheme: const AppBarTheme(
        color: AppTheme.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: AppTheme.nearlyWhite,
          fontSize: 20,
          fontFamily: AppTheme.fontName,
        ),
      ),
      textTheme: AppTheme.textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(style: AppTheme.buttonStyle),
      textButtonTheme: AppTheme.textButtonTheme,
      outlinedButtonTheme: AppTheme.outlinedButtonTheme,
    );
  }
}
