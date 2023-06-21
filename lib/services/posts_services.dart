import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/constants/snackbar.dart';
import 'package:snappio_frontend/models/posts_model.dart';
import 'package:snappio_frontend/provider/post_provider.dart';

class PostsServices {
  final String _baseUrl = "https://api-snappio.onrender.com/api/v1/";
  final Dio _dio = Dio(BaseOptions(validateStatus: (status) => status! < 500));

  Future<bool> fetchPosts(BuildContext context) async {
    try {
      Response response = await _dio.get("${_baseUrl}posts/");
      print(response.statusCode.toString());
      print(response.data);

      if (response.statusCode! < 300) {
        final List jsonData = response.data;
        final List<PostsModel> postsList =
            jsonData.map((item) => PostsModel.fromJson(item)).toList();
        Provider.of<PostsProvider>(context, listen: false).setPosts(postsList);
        return true;
      } else {
        showSnackBar(context, "Something went wrong...");
        return false;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
      showSnackBar(context, "Error loading user posts");
      return false;
    }
  }
}
