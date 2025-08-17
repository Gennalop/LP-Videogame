import 'package:flutter/material.dart';

class JugarPage extends StatelessWidget {
  const JugarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jugar")),
      body: const Center(
        child: Text(
          "Pantalla de Juego",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
