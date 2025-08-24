import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/falling_object.dart';
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
  final List<FallingObject> fallingObjects = [];

  double trashX = 0;
  Timer? spawnTimer;
  bool gameEnded = false; // evita múltiples redirecciones

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      trashX = MediaQuery.of(context).size.width / 2 - 40;
      startGame();
    });
  }

  @override
  void dispose() {
    spawnTimer?.cancel();
    super.dispose();
  }

  void startGame() {
    spawnTimer = Timer.periodic(const Duration(milliseconds: 1500), (_) {
      if (lives <= 0 || score >= 20) {
        spawnTimer?.cancel();
        return;
      }
      spawnObject();
    });
  }

  void spawnObject() {
    final screenWidth = MediaQuery.of(context).size.width;
    double posX = random.nextDouble() * (screenWidth - 60);

    final key = UniqueKey();
    setState(() {
      fallingObjects.add(
        FallingObject(
          key: key,
          initialX: posX,
          isPaused: isPaused,
          onObjectCaught: (isCorrect, objX, objY) {
            if (gameEnded) return;

            final screenHeight = MediaQuery.of(context).size.height;
            final trashTop = screenHeight - 140;

            // Rect del objeto
            final objectRect = Rect.fromLTWH(objX, objY, 60, 60);
            // Rect del tacho
            final trashRect = Rect.fromLTWH(trashX, trashTop, 80, 60);

            if (objectRect.overlaps(trashRect)) {
              if (isCorrect) {
                increaseScore();
              } else {
                decreaseLives();
              }

              // Remover el objeto atrapado
              setState(() {
                fallingObjects.removeWhere((f) => f.key == key);
              });
            } else if (objY > screenHeight) {
              // Salió de la pantalla, eliminar objeto
              setState(() {
                fallingObjects.removeWhere((f) => f.key == key);
              });
            }
          },
        ),
      );
    });
  }

  void increaseScore() {
    if (gameEnded) return;
    setState(() {
      score += 1;
      if (score >= 20) {
        gameEnded = true;
        spawnTimer?.cancel();
        _goToWinScreen();
      }
    });
  }

  void decreaseLives() {
    if (gameEnded) return;
    setState(() {
      lives--;
      if (lives <= 0) {
        gameEnded = true;
        spawnTimer?.cancel();
        _goToGameOver();
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void moveTrashLeft() {
    setState(() {
      trashX -= 30;
      if (trashX < 0) trashX = 0;
    });
  }

  void moveTrashRight() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      trashX += 30;
      if (trashX > screenWidth - 80) trashX = screenWidth - 80;
    });
  }

  void _goToGameOver() {
    if (!gameEnded) gameEnded = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GameOverPage()),
    );
  }

  void _goToWinScreen() {
    if (!gameEnded) gameEnded = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WinPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EchoCatch - Jugar")),
      body: Stack(
        children: [
          ...fallingObjects,
          Align(
            alignment: Alignment.topCenter,
            child: ScorePanel(score: score, lives: lives),
          ),
          Positioned(
            bottom: 100,
            left: trashX,
            child: Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.delete, size: 40, color: Colors.white),
            ),
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
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15)),
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  ElevatedButton(
                    onPressed: togglePause,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isPaused ? Colors.green : Colors.red,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20)),
                    child: Icon(isPaused ? Icons.play_arrow : Icons.pause, size: 28),
                  ),
                  ElevatedButton(
                    onPressed: moveTrashRight,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15)),
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
