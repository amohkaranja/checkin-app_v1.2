import 'package:checkin/themes/app_theme.dart';
import 'package:flutter/material.dart';

class MainTheme {
  MainTheme._();
  static ThemeData create() {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: AppTheme.fontName,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: AppTheme.primarySwatch,
        accentColor: AppTheme.secondaryColor,
        backgroundColor: AppTheme.bgColor,
        cardColor: AppTheme.cardColor,
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
