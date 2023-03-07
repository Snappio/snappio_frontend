import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:snappio_frontend/constants/response_handler.dart';
import 'package:snappio_frontend/constants/global_util.dart';

class AuthServices {
  final Dio _dio = Dio();

  Future signupUser ({
    required BuildContext context,
    required String username,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      Response response = await _dio.post("${baseUrl}users/",
        data: {
          "username": username,
          "email": email,
          "name":  name,
          "password": password,
        },
      );
      responseHandler(
          context: context,
          response: response,
          message: "Success: Account created"
      );
    }
    on DioError catch(e) {
      // print("status: ${e.response!.statusCode}");
      responseHandler(context: context, response: e.response!, message: "");
    }
  }

  Future loginUser ({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      Response response = await _dio.post("${baseUrl}auth/",
        data: {
          "username": username,
          "password": password,
        },
      );
      responseHandler(
        context: context,
        response: response,
        message: "Login Successful"
      );
    }
    on DioError catch(e) {
      // print("status: ${e.response!.statusCode}");
      responseHandler(context: context, response: e.response!, message: "");
    }
  }
}
