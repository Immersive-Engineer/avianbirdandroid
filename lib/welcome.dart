import 'package:avianbirdandroid/GameMainPage.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  static const String id = 'welcome page';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('gotit.mp4', volume: 0.2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/output.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: [0.4, 9.0],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 85, // Optional padding from the bottom
              left: 18,
              right: 18,
              child: Text(
            'Fly as an AvianBird, Don\'t Let enemies kill you, collect super points and be the master of the game ',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Gilroy',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
          Positioned(
            bottom: 30, // Optional padding from the bottom
            left: 18,
            right: 18,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, GameMainPage.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffa7004d),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Play Game',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Gilroy',
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
