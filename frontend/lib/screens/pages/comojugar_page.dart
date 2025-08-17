import 'package:flutter/material.dart';

class ComojugarPage extends StatelessWidget {
  const ComojugarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cómo Jugar")),
      body: const Center(
        child: Text(
          "Pantalla de manual",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
