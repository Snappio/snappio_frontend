import 'package:flutter/material.dart';
import 'package:snappio_frontend/themes.dart';
import 'package:snappio_frontend/screens/signup_page.dart';
import 'package:snappio_frontend/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: Themes.lightMode(context),
      darkTheme: Themes.darkMode(context),
      title: "Snappio_frontend",
      home: const LoginPage(),
      // home: const SignupPage(),
    );
  }
}
