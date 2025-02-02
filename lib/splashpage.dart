import 'package:avianbirdandroid/welcome.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const String id = 'splash page';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 1), () {
      Navigator.pushNamed(context, WelcomePage.id);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          backgroundImage: AssetImage('assets/images/output.jpg', ),
          radius: 50,
        ),
      ),
    );
  }
}
