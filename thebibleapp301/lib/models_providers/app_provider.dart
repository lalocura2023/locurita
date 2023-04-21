import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  int _selectedPageIndex = 0;
  int get selectedPageIndex => _selectedPageIndex;

  set setSelectedPageIndex(int index) => _selectedPageIndex = index;
}
