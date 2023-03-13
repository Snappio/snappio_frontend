import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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
    required BuildContext context,
    required String username,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      var requestData = FormData.fromMap({
        "username": username,
        "email": email,
        "name":  name,
        "password": password,
      });

      Response response = await _dio.post("${_baseUrl}users/",
        data: requestData,
      );

      if(response.statusCode! < 300){
        final User user = User.fromJson(response.data);
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      showSnackBar(context, "Server Error 502");
      return false;
    }
  }

  Future<bool> loginUser ({
    required BuildContext context,
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
      if(response.statusCode! < 300){
        final User user = User.fromJson(response.data);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("x-auth", user.access!);
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        return true;
      }
      else {
        return false;
      }
    } catch(e) {
      log(e.toString());
      showSnackBar(context, "Server Error 502");
      return false;
    }
  }
}
