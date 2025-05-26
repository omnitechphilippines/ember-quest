import 'package:flutter/material.dart';

import '../ember_quest.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final EmberQuestGame game;

  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const Color blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const Color whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 260,
          width: 310,
          decoration: const BoxDecoration(color: blackTextColor, borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Ember Quest', style: TextStyle(color: whiteTextColor, fontSize: 24)),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(onPressed: () => game.overlays.remove('MainMenu'), style: ElevatedButton.styleFrom(backgroundColor: whiteTextColor), child: const Text('Play', style: TextStyle(fontSize: 40.0, color: blackTextColor))),
              ),
              const SizedBox(height: 20),
              const Text('Use WASD or Arrow Keys for movement.',style: TextStyle(color: whiteTextColor, fontSize: 14)),
              const Text('Space bar to jump.',style: TextStyle(color: whiteTextColor, fontSize: 14)),
              const Text('Collect as many stars and avoid enemies!',style: TextStyle(color: whiteTextColor, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
