import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:snappio_frontend/services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthServices authServices = AuthServices();
  @override
  void initState() {
    super.initState();
    authServices.getUserData(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff000000),
              Color(0xff00001a),
            ]
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox( height: 100 ),
            Image.asset("assets/images/logo.png",
              height: 160,
              width: 160,
            ),
            const SizedBox( height: 150 ),
            LoadingAnimationWidget.staggeredDotsWave(
              color: const Color(0xffffa500),
              size: 70 )
          ],
        )
      ),
    );
  }
}
