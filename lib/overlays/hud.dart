import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../ember_quest.dart';
import 'heart.dart';

class Hud extends PositionComponent with HasGameReference<EmberQuestGame> {
  late TextComponent<TextPaint> _scoreTextComponent;

  Hud({super.position, super.size, super.scale, super.angle, super.anchor, super.children, super.priority = 5});

  @override
  Future<void> onLoad() async {
    _scoreTextComponent = TextComponent<TextPaint>(
      text: '${game.starsCollected}',
      textRenderer: TextPaint(style: const TextStyle(fontSize: 32, color: Color.fromRGBO(10, 10, 10, 1))),
      anchor: Anchor.center,
      position: Vector2(game.size.x - 60, 20),
    );
    add(_scoreTextComponent);
    final Sprite starSprite = await game.loadSprite('star.png');
    add(SpriteComponent(sprite: starSprite, position: Vector2(game.size.x - 100, 20), size: Vector2.all(32), anchor: Anchor.center));
    for (int i = 1; i <= game.health; i++) {
      final int positionX = 40 * i;
      await add(HeartHealthComponent(heartNumber: i, position: Vector2(positionX.toDouble(), 20), size: Vector2.all(32)));
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _scoreTextComponent.text = '${game.starsCollected}';
    super.update(dt);
  }
}
