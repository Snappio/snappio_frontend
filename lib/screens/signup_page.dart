import 'package:flutter/material.dart';
import 'package:snappio_frontend/themes.dart';
import 'package:snappio_frontend/services/auth_services.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = "/signup";
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  static String _username = "";
  static String _email = "";
  static String _name = "";
  static String _password = "";

  bool validEmail() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(_email);
  }
  bool validUsername() {
    return RegExp(r"^(?=[a-z0-9]{4,10}$)").hasMatch(_username);
  }
  signupPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {});
      AuthServices().signupUser(
        context: context,
        username: _username,
        email: _email,
        name: _name,
        password: _password,
      );
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
            Image.asset("assets/images/signup.png"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Join Snappio",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2.6),
                  const SizedBox(height: 50),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_box_outlined),
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                        // filled: true,
                        contentPadding: EdgeInsets.all(15)),
                        onChanged: (value) => _name = value,
                        validator: (value) {
                          if (value!.isEmpty) return "Please provide your name";
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_rounded),
                          labelText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                          // filled: true,
                          contentPadding: EdgeInsets.all(15)),
                          onChanged: (value) => _username = value,
                          validator: (value) {
                            if (value!.length < 4 || value.length > 10) {
                              return "Username should be 4-10 characters long";
                            } else if(!validUsername()) {
                              return "Only lowercase alphabets and numbers supported";
                            }
                            return null;
                          },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          // filled: true,
                          contentPadding: EdgeInsets.all(15),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => _email = value,
                        validator: (value) {
                          return validEmail() ? null : "Invalid email";
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.verified_user),
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            // filled: true,
                            contentPadding: EdgeInsets.all(15)),
                        obscureText: true,
                        onChanged: (value) => _password = value,
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Password must be atleast 6 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock_rounded),
                            hintText: "Confirm password",
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                            // filled: true,
                            contentPadding: EdgeInsets.all(15)),
                        obscureText: true,
                        validator: (value) {
                          if(value != _password) return "Passwords don't match";
                          return null;
                        },
                      ),
                    ]),
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () => signupPressed(context),
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            color: Theme.of(context).cardColor),
                        child: const Text("Sign Up",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.4)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Text(" Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                                color: Themes.darkAccent)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
          ),
        ),
      ),
    );
  }
}
