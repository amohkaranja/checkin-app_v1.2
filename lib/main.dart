import 'package:checkin/screens/index_page.dart';
import 'package:flutter/material.dart';
import 'package:checkin/screens/login_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  MaterialColor buildMaterialColor(Color color) {
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Checkin',
        themeMode: ThemeMode.system,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 60, 59, 59),
        primaryColorLight: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
            bodySmall: TextStyle(
                fontFamily: 'OpenSans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
             fontStyle: FontStyle.italic,
             color: Colors.white,
          ),
              headlineLarge: TextStyle(
        fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
             fontStyle: FontStyle.italic
          ),
        )
      ),
      theme: ThemeData(
        primaryColor: Color(0xFFFFFFFF),
        highlightColor:Color(0xFF00836F) ,
        focusColor: Color(0xFF008346),
         textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14,
              color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
                fontFamily: 'OpenSans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
             fontStyle: FontStyle.italic,
             color: Colors.black,
          ),
          headlineLarge: TextStyle(
        fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
             fontStyle: FontStyle.italic
          ),

         )
      ),
      home: IndexPage(), 
    );
  }
}
  