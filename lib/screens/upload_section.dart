import 'package:flutter/material.dart';

class UploadSection extends StatelessWidget {
  const UploadSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Snappio")),
      body: const Center(
        child: Text("This is posts upload section"),
      ),
    );
  }
}
