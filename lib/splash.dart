import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool drop = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "images/logos/splashscreennewtwo.jpg", //delivoo logo
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
