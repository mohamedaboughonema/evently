import 'package:evently/model/app_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  AppUser? currentUser;

  void updateUser(AppUser user) {
    currentUser = user;
    notifyListeners();
  }
}
