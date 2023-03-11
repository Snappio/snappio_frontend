import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snappio_frontend/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    username: '',
    email: '',
    name: '',
    password: '',
    access: '',
  );

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
