import 'package:avianbirdandroid/components/elapsedtime.dart';
import 'package:avianbirdandroid/components/enemyship.dart';
import 'package:avianbirdandroid/components/gamebackground.dart';
import 'package:avianbirdandroid/gameover.dart';
import 'package:flame/camera.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class GameMainPage extends StatefulWidget {
  const GameMainPage({super.key});
  static const String id = 'game main page';

  @override
  State<GameMainPage> createState() => _GameMainPageState();
}

class _GameMainPageState extends State<GameMainPage> {
  @override
  Widget build(BuildContext context) {
    GameWorld game = GameWorld();
    return GameWidget(game: kDebugMode ? GameWorld() : game);
  }
}

class GameWorld extends FlameGame with HasCollisionDetection {
  GameWorld()
      : super(
          world: TheGameWorld(),
          camera: CameraComponent.withFixedResolution(width: 640, height: 360),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    //load all images before use
    await images.loadAllImages();
  }
}

class TheGameWorld extends World with HasGameRef<GameWorld> , HasCollisionDetection {
  late SpriteAnimationComponent bird;

  Vector2 velocity = Vector2(0, 0);
  final double gravity = 50;
  final double jumpForce = -50;

  Timer interval = Timer(6, repeat: true);
  Stopwatch elapsedTime = Stopwatch();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    elapsedTime.start();//load parallax background of the game
    add(GameBackground());

    final birdAnimation = await gameRef.loadSpriteAnimation(
      'birr.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        amountPerRow: 3,
        stepTime: 0.1,
        textureSize: Vector2(200, 200),
      ),
    );

    bird = SpriteAnimationComponent(
      // position: Vector2(gameRef.size.x / 40, gameRef.size.y /30),
      // position: gameRef.size / 2,
      size: Vector2(gameRef.size.x * 20 / 40, gameRef.size.y) * .5,
      anchor: Anchor.centerLeft,
      animation: birdAnimation,
    );

    bird = Bird(birdAnimation, this);
    add(bird);

    addEnemyShips();
    // bird.debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity.y += gravity * dt;
    bird.position.y += velocity.y * dt;

    if (bird.position.y > gameRef.size.y - bird.size.y / 2) {
      bird.position.y = gameRef.size.y - bird.size.y / 2;
      velocity.y = 0;
    }

    // if (bird.position.y < 0 || bird.position.y > gameRef.size.y) {
    //   gameOver(); // Bird is out of bounds
    // }

    interval.update(dt);
  }

  void addEnemyShips() {
    TimerComponent interval = TimerComponent(
      period: 5,
      repeat: true,
      onTick: () {
        add(EnemyShip());

        if (elapsedTime.elapsed.inSeconds > 20) {
          Future.delayed(const Duration(seconds: 3), () {
            add(EnemyShip());
          });
        }
      },
    );

    add(interval);
  }

  void makeBirdJump() {
    velocity.y = jumpForce;
  }

  void gameOver() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        gameRef.buildContext!,
        MaterialPageRoute(builder: (context) => GameOverPage()),
      );
    });
  }
}

class Bird extends SpriteAnimationComponent
    with TapCallbacks, CollisionCallbacks {
  final TheGameWorld world;

  Bird(SpriteAnimation animation, this.world)
      : super(
          animation: animation,
          size: Vector2(100, 100),
          anchor: Anchor.centerRight,
          position: Vector2(-80, 0),
        );

  @override
  void onLoad() async {
    await super.onLoad();
    add(RectangleHitbox.relative(Vector2(0.8, 0.3), parentSize: size),
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    world.makeBirdJump();
    super.onTapUp(event);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is EnemyShip) {
      world.gameOver();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

}
