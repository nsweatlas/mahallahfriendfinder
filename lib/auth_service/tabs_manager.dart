import 'package:flutter/material.dart';

class TabsManager extends ChangeNotifier {
  int _page = 0;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }
}
