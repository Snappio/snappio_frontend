import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snappio_frontend/constants/snackbar.dart';
import 'package:snappio_frontend/models/user_model.dart';
import 'package:snappio_frontend/provider/user_provider.dart';

class AuthServices {
  final String _baseUrl = "http://64.227.150.135/api/v1/";
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

      print(username);
      print(email);

      var reqData = FormData.fromMap({
          "username": username,
          "email": email,
          "name":  name,
          "password": password,
        })

      Response response = await _dio.post("${_baseUrl}users/",
        data: reqData,
      );
      print(response.data);
      if(response.statusCode! < 300) {
        fianl User user = User.fromJson(response.data);
        SharedPreferences prefsid = await SharedPreferences.getInstance();
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        await prefsid.setInt("x-uid", user.id!);
        return true;
      } else {
        print(response.statusCode.toString());
        return false;
      }
    } catch (e) {
      // log(e.toString());
      print(e.toString());
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
      if(response.statusCode! < 300) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("x-auth", jsonDecode(response.data)["access"]);
        return true;
      } else {
        print(response.statusCode.toString());
        return false;
      }
    } catch(e) {
      // log(e.toString());
      print(e.toString());
      showSnackBar(context, "Server Error 502");
      return false;
    }
  }

  void getUserData (BuildContext context) async {
    try {
      SharedPreferences prefsid = await SharedPreferences.getInstance();
      int? uid  = prefsid.getInt("x-uid");
      var userRes = await _dio.get("${_baseUrl}users/${uid}/");
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(userRes.data);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? access = prefs.getString("x-auth");
      if(access==null) prefs.setString("x-auth", "");
      Provider.of<UserProvider>(context, listen: false).setUser(User.fromJson(jsonDecode(access!)));
    }
    catch (e) {
      log(e.toString());
    }
  }
}
