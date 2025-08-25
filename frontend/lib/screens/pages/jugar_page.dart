import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/falling_object.dart';
import 'package:frontend/widgets/trash_bin.dart';
import '../services/trash_service.dart';
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
  String currentTrashColor = "verde";
  int elapsedTime = 0;

  final Random random = Random();
  double trashLeft = 100;
  final double trashWidth = 110;

  List<FallingObject> fallingObjects = [];
  List<GlobalKey<FallingObjectState>> objectKeys = [];

  Timer? spawnTimer;
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();

    spawnTimer = Timer.periodic(const Duration(milliseconds: 2700), (timer) {
      if (lives <= 0) {
        timer.cancel();
        return;
      }
      if (!isPaused) {
        spawnObject();
      }
    });

    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() => elapsedTime++);
      }
    });
  }

  @override
  void dispose() {
    spawnTimer?.cancel();
    gameTimer?.cancel();
    super.dispose();
  }

  void spawnObject() async {
    try {
      final trashData = await TrashService.fetchTrashData();
      final color = trashData["color"];
      final speed = trashData["speed"];

      final screenWidth = MediaQuery.of(context).size.width;

      double posX;
      bool validPos;
      int attempts = 0;
      do {
        posX = random.nextDouble() * (screenWidth - 60);
        validPos = true;
        for (var key in objectKeys) {
          final obj = key.currentState;
          if (obj != null && !obj.caught && !obj.reachedGround) {
            if ((obj.widget.initialX - posX).abs() < 140) {
              validPos = false;
              break;
            }
          }
        }
        attempts++;
      } while (!validPos && attempts < 15);

      final objKey = GlobalKey<FallingObjectState>();

      final obj = FallingObject(
        key: objKey,
        initialX: posX,
        speed: speed,
        color: color,
        onObjectCaught: (objColor, objX, objY) {
          final screenHeight = MediaQuery.of(context).size.height;
          final trashTop = screenHeight - 160;
          final trashBottom = trashTop + 80;
          final trashRight = trashLeft + trashWidth;

          if (objY + 60 >= trashTop &&
              objY <= trashBottom &&
              objX + 60 >= trashLeft &&
              objX <= trashRight) {
            objKey.currentState?.markCaught();
            if (objColor == currentTrashColor) {
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
    } catch (e) {
      print("Error generando basura: $e");
    }
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

  void moveTrashLeft() =>
      setState(() => trashLeft = max(0, trashLeft - 30));
  void moveTrashRight() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() => trashLeft = min(screenWidth - trashWidth, trashLeft + 30));
  }

  void _goToGameOver() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverPage(
          score: score,
          elapsedTime: elapsedTime,
        ),
      ),
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
      body: Stack(
        children: [
          // 🎨 Fondo con degradado cielo
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlueAccent, Colors.white],
              ),
            ),
          ),

          // 📊 Score Panel + Botón regresar
          Positioned(
            top: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black87.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔙 Botón regresar
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  // ❤️ Vidas
                  Row(
                    children: List.generate(
                      lives,
                      (index) => const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ),

                  // ⭐ Puntaje
                  Text(
                    "Score: $score",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),

                  // ⏱ Tiempo
                  Text(
                    "⏱ $elapsedTime s",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          // 🗑️ Basurero
          ...fallingObjects,
          Positioned(
            bottom: 100,
            left: trashLeft,
            child: TrashBin(width: trashWidth, color: currentTrashColor),
          ),

          // 🎮 Controles
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown[300], // 🌱 Color tierra
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: moveTrashLeft,
                  child: const Icon(Icons.arrow_back),
                ),
                ElevatedButton(
                  onPressed: togglePause,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPaused ? Colors.green : Colors.red,
                  ),
                  child: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                ),
                ElevatedButton(
                  onPressed: moveTrashRight,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      setState(() => currentTrashColor = "verde"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Verde"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => currentTrashColor = "azul"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Azul"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => currentTrashColor = "negro"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text("Negro",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
