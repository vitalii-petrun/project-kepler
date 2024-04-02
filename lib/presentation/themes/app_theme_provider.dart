import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  String currentTheme = 'system';

  // final ThemeData lightTheme = ThemeData(
  //   colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF546E7A)),
  //   textTheme: GoogleFonts.exo2TextTheme(),
  // );

  // final ThemeData darkTheme = ThemeData(
  //     colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF455A64)),
  //     textTheme: GoogleFonts.exo2TextTheme().apply(
  //       bodyColor: Colors.white,
  //       displayColor: Colors.white,
  //     ));

  final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF546E7A), // Slate Blue
      secondary: Color(0xFF607D8B), // Blue Grey
      background: Color(0xFFF5F5F5), // Light Grey
      surface: Colors.white, // White
      onPrimary: Colors.white, // White
      onSecondary: Colors.white, // White
      onBackground: Colors.black, // Black
      onError: Colors.white, // White
      error: Colors.redAccent, // Red Accent
    ),
    textTheme: GoogleFonts.exo2TextTheme(),
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF455A64), // Dark Slate Grey
      secondary: Color(0xFF546E7A), // Slate Blue
      background: Color(0xFF121212), // Dark Grey
      surface: Color(0xFF212121), // Darker Grey
      onPrimary: Colors.white, // White
      onSecondary: Colors.black, // Black
      onBackground: Colors.white, // White
      onError: Colors.white, // White
    ),
    textTheme: GoogleFonts.exo2TextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  changeTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('theme', theme);

    currentTheme = theme;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    currentTheme = prefs.getString('theme') ?? 'system';
    notifyListeners();
  }
}
