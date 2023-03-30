import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  String currentLocale = 'en';

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    currentLocale = prefs.getString('locale') ?? 'en';
    notifyListeners();
  }

  changeLocale(String locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('locale', locale);

    currentLocale = locale;
    notifyListeners();
  }
}
