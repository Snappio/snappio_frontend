import 'package:flutter/material.dart';
import 'package:snappio_frontend/screens/signup_page.dart';
import 'package:snappio_frontend/services/auth_services.dart';
import 'package:snappio_frontend/themes.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static bool _load = false;
  static String _username = '';
  static String _password = '';

  void loginPressed(BuildContext context) async {
    setState( () { _load = true; } );
    AuthServices().loginUser(
      context: context,
      username: _username,
      password: _password,
    );
  }
  void signupTextPressed(){
    Navigator.pushNamed(context, SignupPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                      const SizedBox(height: 80),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Icons.account_circle_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                          // filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15)),
                        onChanged: (value) => _username = value,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.verified_user),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          // filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                        ),
                        obscureText: true,
                        onChanged: (value) => _password = value,
                      ),
                    const SizedBox(height: 70),
                    InkWell(
                      onTap: () => loginPressed(context),
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: _load
                                  ? Colors.transparent
                                  : Theme.of(context).cardColor),
                          child: _load
                              ? const CircularProgressIndicator()
                              : const Text("Sign In",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textScaleFactor: 1.4))
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        InkWell(
                          onTap: signupTextPressed,
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
          ),
        )
      );
  }
}
