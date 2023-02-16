import 'package:flutter/material.dart';

class TabProvider with ChangeNotifier {
  int _currentIndex = 0;
  int _currentIndexOwner = 0;

  int get currentIndex => _currentIndex;
  int get currentIndexOwner => _currentIndexOwner;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  set currentIndexOwner(int index) {
    _currentIndexOwner = index;
    notifyListeners();
  }
}
