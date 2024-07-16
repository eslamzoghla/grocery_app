import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay and then navigate to the login screen
    Timer(
      Duration(seconds: 2), // Adjust the duration as needed
      () {
        Navigator.pushReplacementNamed(context,
            initScreen == 0 || initScreen == null ? 'OnBoarding' : 'AuthPage');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/Grocery Plus.png',
          width: width,
          height: height,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
