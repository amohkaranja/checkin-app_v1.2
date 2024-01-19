import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF008346);
  static const Color secondaryColor = Color.fromARGB(255, 23, 145, 246);
  static MaterialColor primarySwatch =
      createMaterialColor(const Color(0xFF008346));
  static const String fontName = 'Poppins';

  static const Color bgColor = Colors.white;
  static const Color darkColor = Color.fromARGB(255, 24, 24, 25);
  static const Color navBgColor = Color(0x41FFFFFF);
  static const Color lavenderPurple = Color(0xFFDFDBFF);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFAE0047);
  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color darkGrey = Color(0xFF313A44);
  static const Color inputBorder = Color(0xFFB8B8B8);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color hintTextColor = Color(0xFF999999);

  static const TextTheme textTheme = TextTheme(
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleSmall: titleSmall,
    bodyMedium: bodyMedium,
    bodyLarge: bodyLarge,
    bodySmall: bodySmall,
  );

  static const TextStyle headlineMedium = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headlineSmall = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 19,
    // letterSpacing: 0.27,
    color: primaryColor,
  );

  static const TextStyle titleLarge = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle titleSmall = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle bodyMedium = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle bodyLarge = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle bodySmall = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: AppTheme.bgColor,
    backgroundColor: AppTheme.primaryColor,
    minimumSize: const Size(110, 40),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    ),
    textStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  static ElevatedButtonThemeData buttonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppTheme.bgColor,
      backgroundColor: AppTheme.primaryColor,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    ),
  );

  static TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(AppTheme.primaryColor),
    ),
  );

  static const OutlinedButtonThemeData outlinedButtonTheme =
      OutlinedButtonThemeData();

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
