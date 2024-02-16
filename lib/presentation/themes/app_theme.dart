import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
    ),
  );

  static final ThemeData dark = ThemeData.dark().copyWith(
    textTheme: GoogleFonts.comicNeueTextTheme(),
  );
}
