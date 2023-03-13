import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/provider/user_provider.dart';

class ChatSection extends StatelessWidget {
  static const routeName = "/allChats";
  const ChatSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userP = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snappio"),
      ),
      body: Center(
        child: Text("This is your chat section: ${userP.user!.name!}"),
      ),
    );
  }
}
