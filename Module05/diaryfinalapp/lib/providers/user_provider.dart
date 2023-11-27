import 'package:diaryapp/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get getUser => _user;

  set setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }
}
