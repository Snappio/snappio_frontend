import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:snappio_frontend/constants/snackbar.dart';
import 'package:snappio_frontend/screens/signup_page.dart';
import 'package:snappio_frontend/screens/splash_screen.dart';
import 'package:snappio_frontend/services/auth_services.dart';
import 'package:snappio_frontend/themes.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static String _username = '';
  static String _password = '';
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();

  void loginBtnPressed(BuildContext context) async {
    var res = AuthServices().loginUser(
      context: context,
      username: _username,
      password: _password,
    );

    if(await res){
      _controller.success();
      showSnackBar(context, "Login Successful");
      await Future.delayed(const Duration(milliseconds: 1000));
      Navigator.pushNamedAndRemoveUntil(context,
          SplashScreen.routeName, (route) => false);
    } else {
      _controller.error();
      showSnackBar(context, "Error: User doesn't exists");
      await Future.delayed(const Duration(milliseconds: 1500));
      _controller.reset();
    }
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
                padding: const EdgeInsets.symmetric(horizontal: 42),
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
                    RoundedLoadingButton(
                        controller: _controller,
                        onPressed: () => loginBtnPressed(context),
                        animateOnTap: true,
                        height: 52,
                        elevation: 3,
                        successColor: Colors.green,
                        color: Theme.of(context).cardColor,
                        child: const Text("Sign In",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.4),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context,
                              SignupPage.routeName),
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
