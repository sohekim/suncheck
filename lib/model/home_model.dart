import 'package:flutter/material.dart';

class HomeModel with ChangeNotifier {
  int _homeCounter = 0;

  int get homeCounter => _homeCounter;

  set homeCounter(int count) {
    _homeCounter = count;
    notifyListeners();
  }

  void reset() => _homeCounter = 0;
}
