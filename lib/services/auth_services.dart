import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snappio_frontend/constants/snackbar.dart';
import 'package:snappio_frontend/models/user_model.dart';
import 'package:snappio_frontend/provider/user_provider.dart';
import 'package:snappio_frontend/screens/login_page.dart';
import 'package:snappio_frontend/widgets/bottom_navbar.dart';

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
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      showSnackBar(context, "Server Error");
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
      showSnackBar(context, "Server Error");
      return false;
    }
  }

  Future<void> getUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access = prefs.getString("x-auth");

    if(access != null) {
      Response res = await _dio.get("${_baseUrl}users/profile/",
        options: Options(
          headers: {
            'Authorization': 'Bearer $access',
          }
        )
      );

      if(res.statusCode! < 300) {

        User user = User.fromJson(res.data);
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.pushNamedAndRemoveUntil(context,
            BottomNavBar.routeName, (route) => false);
      
      } else {

        prefs.remove("x-auth");
        showSnackBar(context, "Something went wrong\nPlease login again");
        Navigator.pushNamedAndRemoveUntil(context,
            LoginPage.routeName, (route) => false);
      }
    }
    else{
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamedAndRemoveUntil(context,
          LoginPage.routeName, (route) => false);
    }
  }

  Future<void> logout(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('x-auth');
    showSnackBar(context, "Please Login");
    Navigator.of(context).pushNamedAndRemoveUntil('/login',
            (Route<dynamic> route) => false);
  
  }

  Future<void> deleteUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access = prefs.getString("x-auth");

    try {
      Response res = await _dio.delete("${_baseUrl}users/profile/",
        options: Options(
          headers: {
            'Authorization': 'Bearer $access',
            }
        ));

      if(res.statusCode! < 300) {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('x-auth');
        showSnackBar(context, "Account deleted successfully");
        Navigator.of(context).pushNamedAndRemoveUntil('/login',
                (Route<dynamic> route) => false);
      
      } else {
        showSnackBar(context, "Something went wrong\nTry again later");
      }
    } catch(e) {
      log(e.toString());
      showSnackBar(context, "Server Error\nTry again later");
    }
  }
}
