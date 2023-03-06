import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:snappio_frontend/constants/response_handler.dart';
import 'package:snappio_frontend/constants/utils.dart';

import '../screens/chat_section.dart';

class AuthServices {
  final Dio _dio = Dio();
  final String _baseUrl = "https://api-snappio.onrender.com/api/v1/users/";

  Future signupUser({
    required BuildContext context,
    required String username,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      Response response = await _dio.post(_baseUrl,
        data: {
          "username": username,
          "email": email,
          "name":  name,
          "password": password,
        },
      );
      showSnackBar(context, "Account created successfully");
    }
    on DioError catch(e) {
      showSnackBar(context, "User already exists");
    }
  }
}
