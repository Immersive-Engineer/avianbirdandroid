import 'dart:math';
import 'package:avianbirdandroid/GameMainPage.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class EnemyShip extends SpriteComponent with HasGameRef<GameWorld> {

  // EnemyShip(): super (){
  //   debugMode = true;
  // }

  final _random = Random();

  @override
  void onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('enemyship.png');
    size = Vector2(gameRef.size.y * 800/469, gameRef.size.y) * 0.13;
    flipHorizontallyAroundCenter();
    double yPosition = _random.nextDouble() * gameRef.size.y;
    position  = Vector2(gameRef.size.x * 0.4, yPosition);
    // add(CircleHitbox(anchor: Anchor.center, radius: size.y * 0.45, position: size / 2),);
    add(RectangleHitbox());
  }


  @override
  void update(double dt){
    super.update(dt);
    x = x-100 * dt;
  }
}
