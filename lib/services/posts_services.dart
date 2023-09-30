import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/constants/snackbar.dart';
import 'package:snappio_frontend/models/posts_model.dart';
import 'package:snappio_frontend/provider/post_provider.dart';

class PostsServices {
  final String _baseUrl = "https://api-snappio.onrender.com/api/v1/posts/";
  final Dio _dio = Dio(BaseOptions(validateStatus: (status) => status! < 500));

  Future<bool> fetchPosts(BuildContext context) async {
    try {
      Response response = await _dio.get(_baseUrl);
      if (response.statusCode! < 300) {
        final List jsonData = response.data;
        final List<PostsModel> postsList =
            jsonData.map((item) => PostsModel.fromJson(item)).toList();
        Provider.of<PostsProvider>(context, listen: false).setPosts(postsList);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      showSnackBar(context, "Error loading user posts");
      return false;
    }
  }

  Future<bool> getUserPosts(BuildContext context, String? username) async {
    try {
      Response response =
          await _dio.get(_baseUrl, queryParameters: {"username": username});
      if (response.statusCode! < 300) {
        final List jsonData = response.data;
        final List<PostsModel> postsList =
            jsonData.map((item) => PostsModel.fromJson(item)).toList();
        Provider.of<PostsProvider>(context, listen: false).setPosts(postsList);
        return true;
      } else {
        showSnackBar(context, "Sorry couldn't find user at the moment");
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> post(
      BuildContext context, String caption, File file, String? token) async {
    try {
      String filename = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "content": caption,
        "uploadImage":
            await MultipartFile.fromFile(file.path, filename: filename),
      });
      Response response = await _dio.post(_baseUrl,
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode! < 300) {
        showSnackBar(context, "Posted Successfully");
        return true;
      } else {
        showSnackBar(context, "Posting Failed");
        return false;
      }
    } catch (e) {
      log(e.toString());
      showSnackBar(context, "Posting Failed");
      return false;
    }
  }
}
