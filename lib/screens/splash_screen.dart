import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    // Simulate some startup delay
    Future.delayed(Duration(seconds: 2), navigateToLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 51, 51, 1),
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 400,
        ),
      ),
    );
  }
}
