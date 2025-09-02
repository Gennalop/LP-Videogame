import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/falling_object.dart';
import 'package:frontend/widgets/trash_bin.dart';
import '../services/trash_service.dart';
import '../services/stats_service.dart';
import 'game_over_page.dart';
import 'win_page.dart';

class JugarPage extends StatefulWidget {
  const JugarPage({super.key});
  @override
  JugarPageState createState() => JugarPageState();
}

class JugarPageState extends State<JugarPage> {
  final Random random = Random();
  String currentTrashColor = "verde";
  bool isPaused = false;

  int score = 0;
  int score_verdes = 0;
  int score_azules = 0;
  int score_negros = 0;
  int lives = 3;
  int elapsedTime = 0;

  final double objectWidth = 60.0;
  final double trashWidth = 110;
  final double trashHeight = 100;
  double trashLeft = 100; //posición horizontal (X) del basurero en la pantalla.

  List<FallingObject> fallingObjects = [];
  List<GlobalKey<FallingObjectState>> objectKeys = [];

  Timer? spawnTimer;
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    // Genera basura periódicamente
    spawnTimer = Timer.periodic(const Duration(milliseconds: 3200), (timer) {
      if (lives <= 0) {
        timer.cancel();
        return;
      }
      if (!isPaused) {
        spawnObject();
      }
    });
    // Aumenta el tiempo jugado cada segundo
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
      final speed = (trashData["speed"] as num).toDouble();
      final image = "assets/images/${trashData["image"]}";
      final category = trashData["category"];

      final screenWidth = MediaQuery.of(context).size.width;

      double posX;
      bool validPos;
      int attempts = 0;
      double margin = 5.0;

      do {
        posX = random.nextDouble() * (screenWidth - objectWidth);
        validPos = true;
        for (var key in objectKeys) {
          final obj = key.currentState;
          if (obj != null && !obj.caught && !obj.reachedGround) {
            final existingX = obj.widget.initialX;
            final leftLimit = existingX - margin;
            final rightLimit = existingX + (objectWidth + margin);

            if (posX > leftLimit && posX < rightLimit) {
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
        image: image,
        category: category,
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
              increaseScore(currentTrashColor);
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

  void increaseScore(String color) {
    setState(() {
      score++;
      if (color == "verde") {
        score_verdes++;
      } else if (color == "azul") {
        score_azules++;
      } else if (color == "negro") {
        score_negros++;
      }
      if (score >= 5) _goToWinScreen();
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

  void moveTrashLeft() => setState(() => trashLeft = max(0, trashLeft - 30));
  
  void moveTrashRight() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() => trashLeft = min(screenWidth - trashWidth, trashLeft + 30));
  }

  void _goToGameOver() {
    StatsService().saveStats(
      win: false,
      points: score,
      vidasRestantes: lives,
      playTime: elapsedTime.toDouble(),
      objetosVerdes: score_verdes,
      objetosAzules: score_azules,
      objetosNegros: score_negros,
    );
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
    StatsService().saveStats(
      win: true,
      points: score,
      vidasRestantes: lives,
      playTime: elapsedTime.toDouble(),
      objetosVerdes: score_verdes,
      objetosAzules: score_azules,
      objetosNegros: score_negros,
    );
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
          // Fondo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height - 90,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,          
              alignment: Alignment.bottomLeft,
            ),
          ),

          ...fallingObjects,

          // Score Panel + Botón regresar
          Positioned(
            top: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón regresar
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  // Vidas
                  Row(
                    children: List.generate(
                      lives,
                      (index) => const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ),

                  // Puntaje
                  Text(
                    "Score: $score",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),

                  // Tiempo
                  Text(
                    "⏱ $elapsedTime s",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          // Basurero
          Positioned(
            bottom: 90,
            left: trashLeft,
            child: TrashBin(width: trashWidth, height: trashHeight, color: currentTrashColor),
          ),

          // Controles
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
      height: 90,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ground.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.topLeft,
          ),
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
