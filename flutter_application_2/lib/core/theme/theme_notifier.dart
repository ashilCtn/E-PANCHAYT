import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/theme/theme.dart'; // Import your AppTheme

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme =>
      _isDarkMode ? AppTheme.darkThemeMode : AppTheme.lightThemeMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
