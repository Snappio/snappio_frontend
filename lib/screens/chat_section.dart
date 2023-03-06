import 'package:flutter/material.dart';

class ChatSection extends StatelessWidget {
  static const routeName = "/allChats";
  const ChatSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snappio"),
      ),
      body: const Center(
        child: Text("This is your chat section"),
      ),
    );
  }
}
