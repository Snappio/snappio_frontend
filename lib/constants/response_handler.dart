import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:snappio_frontend/constants/utils.dart';

void responseHandler ({
  required BuildContext context,
  required Response response,
}) {
  switch(response.statusCode) {
    case 200:
      showSnackBar(context, "Success: Account created");
      break;
    case 400:
      showSnackBar(context, "Error: User already exists");
      break;
    default:
      showSnackBar(context, response.data.toString());
  }
}
