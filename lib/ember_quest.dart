import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'actors/ember.dart';
import 'actors/water_enemy.dart';
import 'managers/segment_manager.dart';
import 'objects/ground_block.dart';
import 'objects/platform_block.dart';
import 'objects/star.dart';
import 'overlays/hud.dart';

class EmberQuestGame extends FlameGame<World> with HasCollisionDetection<Broadphase<ShapeHitbox>>, HasKeyboardHandlerComponents<World> {
  EmberQuestGame();

  late EmberPlayer _ember;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;
  int starsCollected = 0, health = 3;
  double cloudSpeed = 0.0, objectSpeed = 0.0;

  @override
  Future<void> onLoad() async {
    //debugMode = true; // Uncomment to see the bounding boxes
    await images.loadAll(<String>['block.png', 'ember.png', 'ground.png', 'heart_half.png', 'heart.png', 'star.png', 'water_enemy.png']);
    // Everything in this tutorial assumes that the position
    // of the `CameraComponent`s viewfinder (where the camera is looking)
    // is in the top left corner, that's why we set the anchor here.
    camera.viewfinder.anchor = Anchor.topLeft;
    initializeGame(loadHud: true);
  }

  @override
  void update(double dt) {
    if (health <= 0) {
      overlays.add('GameOver');
    }
    super.update(dt);
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      // final component = switch (block.blockType) {
      //   GroundBlock _ => GroundBlock(gridPosition: block.gridPosition, xOffset: xPositionOffset),
      //   PlatformBlock _ => PlatformBlock(gridPosition: block.gridPosition, xOffset: xPositionOffset),
      //   Star _ => Star(gridPosition: block.gridPosition, xOffset: xPositionOffset),
      //   WaterEnemy _ => WaterEnemy(gridPosition: block.gridPosition, xOffset: xPositionOffset),
      //   _ => throw UnimplementedError(),
      // };
      // world.add(component);

      switch (block.blockType) {
        case const (GroundBlock):
          final GroundBlock component = GroundBlock(gridPosition: block.gridPosition, xOffset: xPositionOffset);
          world.add(component);
        case const (PlatformBlock):
          final PlatformBlock component = PlatformBlock(gridPosition: block.gridPosition, xOffset: xPositionOffset);
          world.add(component);
        case const (Star):
          final Star component = Star(gridPosition: block.gridPosition, xOffset: xPositionOffset);
          world.add(component);
        case const (WaterEnemy):
          final WaterEnemy component = WaterEnemy(gridPosition: block.gridPosition, xOffset: xPositionOffset);
          world.add(component);
      }
    }
  }

  void initializeGame({required bool loadHud}) {
    // Assume that size.x < 3200
    final int segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);
    for (int i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }
    _ember = EmberPlayer(position: Vector2(128, canvasSize.y - 128));
    world.add(_ember);
    if (loadHud) {
      camera.viewport.add(Hud());
    }
  }

  void reset() {
    starsCollected = 0;
    health = 3;
    initializeGame(loadHud: false);
  }
}
