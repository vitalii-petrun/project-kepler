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

Color darkenColor(Color color, {double factor = 0.2}) {
  int red = (color.red * (1 - factor)).round();
  int green = (color.green * (1 - factor)).round();
  int blue = (color.blue * (1 - factor)).round();

  red = red.clamp(0, 255);
  green = green.clamp(0, 255);
  blue = blue.clamp(0, 255);

  return Color.fromRGBO(red, green, blue, 1);
}

String getEmojiForRefreshRate(double refreshRate) {
  if (refreshRate >= 120) {
    return '🚀'; // High refresh rate, indicating very smooth
  } else if (refreshRate >= 90) {
    return '✨'; // Moderately high, indicating good smoothness
  } else {
    return '🔋'; // Standard refresh rate
  }
}

class AppColors {
  static const Color primaryColor = Color(0xFF0D47A1);
  static const Color secondaryColor = Color(0xFF2196F3);
  static const Color tertiaryColor = Color(0xFF00BFA5);
  static const Color quaternaryColor = Color(0xFF7f4bd7);
  static const Color quinaryColor = Color(0xFF3F51B5);
  static const Color senaryColor = Color(0xFFD49114);
  //indigo
  static const Color eventCardColor = Color(0xFF3F51B5);
  //deep blue
  static const Color launchCardColor = Color(0xFF0D47A1);
  //blue
  static const Color newsCardColor = Color(0xFF2196F3);
  static const Color spaceTitleColor = Color(0xFF7f4bd7);
  static const Color aiChatBubbleColor = Color(0xFF3F51B5);

  static const Color presentFunction = Color(0xFF0D47A1);
  static const Color presentFunction2 = Color(0xFF2196F3);
  static const Color presentFunction4 = Color(0xFF00BFA5);
}
