import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/falling_object.dart';
import '../../widgets/trash_bin.dart';
import '../../widgets/score_panel.dart';
import 'game_over_page.dart';
import 'win_page.dart';

class JugarPage extends StatefulWidget {
  final String playerId;

  const JugarPage({super.key, this.playerId = "jugador1"});

  @override
  _JugarPageState createState() => _JugarPageState();
}

class _JugarPageState extends State<JugarPage> {
  int score = 0;
  int lives = 3;
  bool isPaused = false;
  final Random random = Random();
  double trashLeft = 100;
  final double trashWidth = 120;

  List<FallingObject> fallingObjects = [];
  List<GlobalKey<FallingObjectState>> objectKeys = [];

  @override
  void initState() {
    super.initState();
    // Generar un objeto cada 1.5 segundos
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (lives <= 0 || score >= 20) {
        timer.cancel();
        return;
      }
      spawnObject();
    });
  }

  void spawnObject() {
    final screenWidth = MediaQuery.of(context).size.width;
    final posX = random.nextDouble() * (screenWidth - 60);

    final objKey = GlobalKey<FallingObjectState>();

    final obj = FallingObject(
      key: objKey,
      initialX: posX,
      isPaused: isPaused,
      onObjectCaught: (isCorrect, objX, objY) {
        final screenHeight = MediaQuery.of(context).size.height;
        final trashTop = screenHeight - 160;
        final trashBottom = trashTop + 80;
        final trashRight = trashLeft + trashWidth;

        if (objY + 60 >= trashTop &&
            objY <= trashBottom &&
            objX + 60 >= trashLeft &&
            objX <= trashRight) {
          objKey.currentState?.markCaught();
          if (isCorrect) {
            increaseScore();
          } else {
            decreaseLives();
          }
        }
      },
    );

    setState(() {
      fallingObjects.add(obj);
      objectKeys.add(objKey);
    });
  }

  void increaseScore() {
    setState(() {
      score++;
      if (score >= 20) _goToWinScreen();
    });
  }

  void decreaseLives() {
    setState(() {
      lives--;
      if (lives <= 0) _goToGameOver();
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
      for (var key in objectKeys) {
        key.currentState?.setPaused(isPaused);
      }
    });
  }

  void moveTrashLeft() {
    setState(() {
      trashLeft = max(0, trashLeft - 30);
    });
  }

  void moveTrashRight() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      trashLeft = min(screenWidth - trashWidth, trashLeft + 30);
    });
  }

  void _goToGameOver() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GameOverPage()),
    );
  }

  void _goToWinScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WinPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Juego")),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ScorePanel(score: score, lives: lives),
          ),
          ...fallingObjects,
          Positioned(
            bottom: 80,
            left: trashLeft,
            child: TrashBin(width: trashWidth),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 80,
            child: Container(
              color: Colors.grey.shade200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: moveTrashLeft,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  ElevatedButton(
                    onPressed: togglePause,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPaused ? Colors.green : Colors.red,
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: Icon(
                      isPaused ? Icons.play_arrow : Icons.pause,
                      size: 28,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: moveTrashRight,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Icon(Icons.arrow_forward, size: 24),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
