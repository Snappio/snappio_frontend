import 'package:flutter/material.dart';
import 'package:snappio_frontend/screens/login_page.dart';
import 'package:snappio_frontend/screens/signup_page.dart';
import 'package:snappio_frontend/screens/splash_screen.dart';
import 'package:snappio_frontend/widgets/bottom_navbar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );
    case LoginPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginPage());
    case SignupPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignupPage());
    case BottomNavBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomNavBar());
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text("This page doesn't exists"),
              )));
  }
}
