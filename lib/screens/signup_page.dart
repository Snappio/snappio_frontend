import 'package:flutter/material.dart';
import 'package:snappio_frontend/themes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";

  bool validEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  signupPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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
                  const SizedBox(height: 60),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Username",
                            // labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            // filled: true,
                            contentPadding: EdgeInsets.all(14)),
                        validator: (value) {
                          if (value!.isEmpty) return "Field cannot be empty";
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Email",
                          // labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          // filled: true,
                          contentPadding: EdgeInsets.all(14),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                        validator: (value) {
                          return validEmail() ? null : "Invalid email";
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Password",
                            // labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            // filled: true,
                            contentPadding: EdgeInsets.all(14)),
                        obscureText: true,
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Password must be atleast 6 characters";
                          }
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
                                borderRadius: BorderRadius.circular(16)),
                            color: Theme.of(context).cardColor),
                        child: const Text("Sign Up",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.4)),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Already have an account? "),
                      Text(" Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Themes.darkAccent))
                    ],
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
