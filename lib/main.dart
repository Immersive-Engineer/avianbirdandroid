import 'package:avianbirdandroid/GameMainPage.dart';
import 'package:avianbirdandroid/splashpage.dart';
import 'package:avianbirdandroid/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  // await Flame.device.fullScreen();
  // await Flame.device.setLandscape();

  runApp(const AvianBirdApp());
}

class AvianBirdApp extends StatelessWidget {
  const AvianBirdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SplashPage(),

      routes: {
        SplashPage.id: (context) => SplashPage(),
        WelcomePage.id: (context) => WelcomePage(),
        GameMainPage.id: (context) => GameMainPage(),
      },
    );
  }
}

