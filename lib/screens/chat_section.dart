import 'package:flutter/material.dart';

class ChatSection extends StatelessWidget {
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
