import 'package:flutter/material.dart';

class PostFeed extends StatelessWidget {
  const PostFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snappio"),
      ),
      body: const Center(
        child: Text("This is your post feed"),
      ),
    );
  }
}
