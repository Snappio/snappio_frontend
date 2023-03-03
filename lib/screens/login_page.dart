import 'package:flutter/material.dart';
import 'package:snappio_frontend/screens/signup_page.dart';
import 'package:snappio_frontend/themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool login = false;
  loginPressed(BuildContext context) async {
    setState(() {
      login = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Image.asset("assets/images/login.png"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Welcome to Snappio",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2.4),
                    const SizedBox(height: 75),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Username",
                        prefixIcon: Icon(Icons.account_circle_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                        // filled: true,
                        contentPadding: EdgeInsets.all(15),
                      )),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.verified_user),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        // filled: true,
                        contentPadding: EdgeInsets.all(15),
                      ),
                      obscureText: true),
                  const SizedBox(height: 60),
                  InkWell(
                    onTap: () => loginPressed(context),
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            color: login
                                ? Colors.transparent
                                : Theme.of(context).cardColor),
                        child: login
                            ? const CircularProgressIndicator()
                            : const Text("Sign In",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textScaleFactor: 1.4)),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SignupPage())),
                        child: const Text(" Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Themes.darkAccent)),
                      ),
                    ],
                  ),
                ],
              )),
          ],
          ),
        )
      ));
  }
}
