import 'package:flutter/material.dart';
import '../models/posts_model.dart';

class PostsProvider extends ChangeNotifier {
  List<PostsModel> posts = [];

  void setPosts(List<PostsModel> postsList) {
    posts.clear();
    posts = postsList;
    notifyListeners();
  }
}
