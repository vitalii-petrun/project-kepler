import 'package:flutter/material.dart';

abstract class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
    ),
  );

  static final ThemeData dark = ThemeData.dark();
}
