import 'package:flutter/material.dart';
import 'jugar_page.dart';

class GameOverPage extends StatelessWidget {
  final int score;
  final int elapsedTime;

  const GameOverPage({
    super.key,
    required this.score,
    required this.elapsedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sentiment_dissatisfied,
                size: 100, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              "Game Over",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const JugarPage()),
                );
              },
              child: const Text("Reintentar"),
            )
          ],
        ),
      ),
    );
  }
}
