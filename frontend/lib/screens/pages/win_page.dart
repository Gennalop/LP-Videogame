import 'package:flutter/material.dart';
import 'jugar_page.dart';

class WinPage extends StatelessWidget {
  const WinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events,
                size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "¡Ganaste!",
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
              child: const Text("Jugar de nuevo"),
            )
          ],
        ),
      ),
    );
  }
}
