import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snappio_frontend/themes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SvgPicture.asset("assets/images/login.svg"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Welcome to Snappio",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2.5),
                    const SizedBox(height: 80),
                    TextFormField(
                      decoration: const InputDecoration(
                      labelText: "Username",
                      // labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      // filled: true,
                      contentPadding: EdgeInsets.all(14),
                      )),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                      labelText: "Password",
                      // labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      // filled: true,
                      contentPadding: EdgeInsets.all(14),
                      ),
                      obscureText: true),
                    const SizedBox(height: 60),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                        color: Theme.of(context).cardColor
                      ),
                      child: const Text("Sign In",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.4)
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Don't have an account? "),
                        Text(" Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold,
                            color: Themes.darkAccent))
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
