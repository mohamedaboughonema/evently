import 'package:flutter/material.dart';

class AppThemeProvider with ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentThemeName = 'Light';

  void setTheme(ThemeMode theme, String themeName) {
    if (theme == currentTheme) {
      return;
    }
    currentTheme = theme;
    currentThemeName = themeName;
    notifyListeners();
  }
}
