import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class RefreshRateProvider with ChangeNotifier {
  List<DisplayMode> availableModes = [];
  DisplayMode? selectedMode;

  RefreshRateProvider() {
    fetchAvailableDisplayModes();
  }

  Future<void> fetchAvailableDisplayModes() async {
    availableModes = await FlutterDisplayMode.supported;
    selectedMode = await FlutterDisplayMode.active;
    notifyListeners();
  }

  void setDisplayMode(DisplayMode mode) async {
    await FlutterDisplayMode.setPreferredMode(mode);
    selectedMode = mode;
    notifyListeners();
  }
}
