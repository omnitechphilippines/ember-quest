import 'package:ember_quest/ember_quest.dart';
import 'package:flame/components.dart';

enum HeartState { available, unavailable }

class HeartHealthComponent extends SpriteGroupComponent<HeartState> with HasGameReference<EmberQuestGame> {
  final int heartNumber;

  HeartHealthComponent({required this.heartNumber, required super.position, required super.size, super.scale, super.angle, super.anchor, super.priority});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final Sprite availableSprite = await game.loadSprite('heart.png', srcSize: Vector2.all(32));
    final Sprite unavailableSprite = await game.loadSprite('heart_half.png', srcSize: Vector2.all(32));
    sprites = <HeartState, Sprite>{HeartState.available: availableSprite, HeartState.unavailable: unavailableSprite};
    current = HeartState.available;
  }

  @override
  void update(double dt) {
    if (game.health < heartNumber) {
      current = HeartState.unavailable;
    } else {
      current = HeartState.available;
    }
    super.update(dt);
  }
}
