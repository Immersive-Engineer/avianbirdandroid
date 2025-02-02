import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame/game.dart';

class GameBackground extends ParallaxComponent with HasGameRef<FlameGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.center;
    size = gameRef.size;
    parallax = await Parallax.load([
      ParallaxImageData('background/layer1-sky.png'),
      ParallaxImageData('background/layer2-clouds.png'),
      ParallaxImageData('background/layer3-clouds.png'),
      ParallaxImageData('background/layer4-clouds.png'),
      ParallaxImageData('background/layer5-huge-clouds.png'),
      ParallaxImageData('background/layer6-bushes.png'),
      ParallaxImageData('background/layer7-bushes.png'),
    ], baseVelocity: Vector2(2, 0), velocityMultiplierDelta: Vector2(1.6, 1.0));

  }
}
