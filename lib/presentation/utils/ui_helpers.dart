import 'package:flutter/material.dart';

void showConnectionError(
    ScaffoldMessengerState scaffoldMessenger, String message) {
  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}

class AppColors {
  //indigo
  static const Color eventCardColor = Color(0xFF3F51B5);
  //deep blue
  static const Color launchCardColor = Color(0xFF0D47A1);
  //blue
  static const Color newsCardColor = Color(0xFF2196F3);
}
