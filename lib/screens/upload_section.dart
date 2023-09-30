import 'dart:io';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snappio_frontend/constants/snackbar.dart';
import 'package:snappio_frontend/services/posts_services.dart';

class UploadSection extends StatefulWidget {
  static const String routeName = '/upload';
  const UploadSection({Key? key}) : super(key: key);

  @override
  State<UploadSection> createState() => _UploadSectionState();
}

class _UploadSectionState extends State<UploadSection> {
  static XFile? _file;
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _controller = TextEditingController();
  final RoundedLoadingButtonController _button =
      RoundedLoadingButtonController();
  static bool _loading = false;

  @override
  void dispose() {
    _file = null;
    super.dispose();
  }

  void selectImage(bool opt) async {
    if (opt) {
      XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _file = file;
      });
    } else {
      XFile? file = await _imagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _file = file;
      });
    }
  }

  void uploadPost() async {
    if (_controller.text.isEmpty) {
      setState(() {
        _loading = true;
      });
      _button.error();
      await Future.delayed(const Duration(milliseconds: 1200));
      _button.reset();
      showSnackBar(context, "Caption cannot be empty");
      setState(() {
        _loading = false;
      });
    } else {
      setState(() {
        _loading = true;
      });
      File imageFile = File(_file!.path);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth");
      bool status = await PostsServices()
          .post(context, _controller.text, imageFile, token);
      if (status) {
        _button.success();
        await Future.delayed(const Duration(milliseconds: 1400));
        Navigator.pop(context);
      } else {
        _button.error();
        await Future.delayed(const Duration(milliseconds: 1400));
        _button.reset();
        setState(() {
          _loading = false;
        });
        setState(() {
          _file = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Snappio"),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 35),
                    const Image(image: AssetImage("assets/images/selfie.png")),
                    const SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: InkWell(
                        onTap: () => selectImage(false),
                        splashColor: Theme.of(context).cardColor,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Theme.of(context).cardColor),
                          child: const Text("Click a picture",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: InkWell(
                        onTap: () => selectImage(true),
                        splashColor: Theme.of(context).cardColor,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Theme.of(context).cardColor),
                          child: const Text("Choose from gallery",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Upload Post"),
              centerTitle: true,
            ),
            body: Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      child: Image(
                        image: XFileImage(_file!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: const InputDecoration(
                        hintText: "Write a caption:",
                        contentPadding: EdgeInsets.all(5)),
                  ),
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? Expanded(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 60),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: _loading
                                      ? Colors.transparent
                                      : Theme.of(context).cardColor),
                              child: RoundedLoadingButton(
                                  controller: _button,
                                  onPressed: uploadPost,
                                  animateOnTap: true,
                                  elevation: 0,
                                  height: 51,
                                  successColor: Colors.green,
                                  color: Colors.transparent,
                                  child: const Text("Post",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
  }
}
