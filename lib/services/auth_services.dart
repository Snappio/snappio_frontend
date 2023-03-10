import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snappio_frontend/constants/snackbar.dart';
import 'package:snappio_frontend/models/user_model.dart';
import 'package:snappio_frontend/provider/user_provider.dart';

class AuthServices {
  final String _baseUrl = "https://api-snappio.onrender.com/api/v1/";
  final Dio _dio = Dio(BaseOptions(
    validateStatus: (status) => status! < 500,
  ));

  Future<bool> signupUser ({
    required String username,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
          id: 0,
          username: username,
          email: email,
          name: name,
          password: password,
          access: '',
      );

      Response response = await _dio.post("${_baseUrl}users/",
        data: {
          "username": username,
          "email": email,
          "name":  name,
          "password": password,
        },
      );
      // final userProvider = StateNotifierProvider<UserProvider, User>(ref => ());
      return (response.statusCode! < 300) ? true : false;
    }
    on DioError catch(e) {
      return false;
    }
  }

  Future<bool> loginUser ({
    required String username,
    required String password,
  }) async {
    try {
      Response response = await _dio.post("${_baseUrl}auth/",
        data: {
          "username": username,
          "password": password,
        },
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', jsonDecode(response.data)['access']);
      return (response.statusCode! < 300) ? true : false;
    }
    on DioError catch(e) {
      return false;
    }
  }

  void getUserData (BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? access = prefs.getString("x-auth-token");
      if (access == null) {
        prefs.setString('x-auth-token', '');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
