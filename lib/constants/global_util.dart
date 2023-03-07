import 'package:flutter/material.dart';

const String baseUrl = "https://api-snappio.onrender.com/api/v1/";

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text))
  );
}
