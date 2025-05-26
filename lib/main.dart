import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'ember_quest.dart';
import 'overlays/game_over.dart';
import 'overlays/main_menu.dart';

void main() {
  runApp(
    SafeArea(
      child: GameWidget<EmberQuestGame>.controlled(
        gameFactory: EmberQuestGame.new,
        overlayBuilderMap: <String, OverlayWidgetBuilder<EmberQuestGame>>{'MainMenu': (_, EmberQuestGame game) => MainMenu(game: game), 'GameOver': (_, EmberQuestGame game) => GameOver(game: game)},
        initialActiveOverlays: const <String>['MainMenu'],
      ),
    ),
  );
}
