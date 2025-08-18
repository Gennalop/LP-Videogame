import 'package:flutter/material.dart';

class ScorePanel extends StatelessWidget {
  final int score;
  final int lives;

  const ScorePanel({
    super.key, 
    required this.score,
    this.lives = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Puntuación
          Text(
            "Puntos: $score",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          
          const SizedBox(width: 16),
          
          // Barra de vidas con corazones
          Row(
            children: List.generate(3, (index) {
              return Icon(
                Icons.favorite,
                size: 20,
                color: index < lives ? Colors.red : Colors.grey.shade300,
              );
            }),
          ),
        ],
      ),
    );
  }
}
