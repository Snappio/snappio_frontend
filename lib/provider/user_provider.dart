import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snappio_frontend/models/user_model.dart';
import 'package:snappio_frontend/services/auth_services.dart';

class UserProvider extends StateNotifier<User> {
  UserProvider(super.state);

  User _user = User(
      id: 0,
      username: '',
      email: '',
      name: '',
      password: '',
      access: '',
  );

  User get user => _user;

  void setUser(Map<String, dynamic> user) {
    _user = User.fromJson(user);
    state = _user;
  }
}
