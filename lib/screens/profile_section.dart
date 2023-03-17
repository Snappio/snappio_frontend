import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Snappio")),
      body: const Center(
        child: Text("This is your profile section"),
      ),
    );
  }
}
