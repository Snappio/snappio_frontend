import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:snappio_frontend/constants/global_util.dart';
import 'package:snappio_frontend/screens/chat_section.dart';

void responseHandler ({
  required BuildContext context,
  required Response response,
  required String message,
}) {
  switch(response.statusCode) {
    case 200:
      showSnackBar(context, message);
      Navigator.pushReplacementNamed(context, ChatSection.routeName);
      break;
    case 400:
      showSnackBar(context, "Error: User already exists");
      break;
    case 401:
      showSnackBar(context, "Error: User doesn't exists");
      break;
    default:
      showSnackBar(context, response.data.toString());
  }
}
