import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  String currentLocale = 'en';

  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    currentLocale = _prefs.getString('locale') ?? 'en';
    notifyListeners();
  }

  changeLocale(String locale) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    await _prefs.setString('locale', locale);

    currentLocale = locale;
    notifyListeners();
  }
}
