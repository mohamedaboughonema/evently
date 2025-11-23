import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  String currentLanguageCode = 'en';

  void setLanguage(String newlanguageCode) {
    if (newlanguageCode == currentLanguageCode) {
      return;
    }
    currentLanguageCode = newlanguageCode;
    notifyListeners();
  }
}
