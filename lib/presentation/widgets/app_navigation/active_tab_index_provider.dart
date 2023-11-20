import 'package:flutter/material.dart';

class ActiveTabIndexProvider extends ChangeNotifier {
  int _activeTabIndex = 0;

  int get activeTabIndex => _activeTabIndex;

  set activeTabIndex(int index) {
    _activeTabIndex = index;
    notifyListeners();
  }
}
