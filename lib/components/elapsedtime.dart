

import 'dart:ui';

import 'package:avianbirdandroid/GameMainPage.dart';
import 'package:flame/components.dart';

class ElapsedTime extends TextComponent with HasGameRef<GameWorld> {

  @override
  Future<void> onLoad() async{
    await super.onLoad();
    scale = Vector2.all(1.4);
    position = Vector2(gameRef.size.x * 0.3, 4);

  }

  @override
  void update(double dt) {
    // text =  gameRef.elapsedTime.elapsed.inSeconds.toString();
  }
}