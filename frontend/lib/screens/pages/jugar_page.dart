import 'package:flutter/material.dart';
import '../../widgets/falling_object.dart';
import '../../widgets/trash_bin.dart';
import '../../widgets/score_panel.dart';

class JugarPage extends StatefulWidget {
  final String playerId;

  const JugarPage({super.key, this.playerId = "jugador1"});

  @override
  _JugarPageState createState() => _JugarPageState();
}

class _JugarPageState extends State<JugarPage> {
  int score = 0;
  int lives = 3;

  void increaseScore() {
    setState(() {
      score++;
    });
  }

  void decreaseLives() {
    setState(() {
      if (lives > 0) {
        lives--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Juego")),
      body: Stack(
        children: [
          // Panel de puntuación
          Align(
            alignment: Alignment.topCenter,
            child: ScorePanel(score: score, lives: lives),
          ),

          // Objeto que cae
          FallingObject(onCatch: increaseScore),

          // Basurero en el fondo
          Align(
            alignment: Alignment.bottomCenter,
            child: TrashBin(),
          ),
        ],
      ),
    );
  }
}