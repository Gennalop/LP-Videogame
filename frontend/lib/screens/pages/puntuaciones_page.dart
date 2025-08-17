import 'package:flutter/material.dart';

class PuntuacionesPage extends StatelessWidget {
  const PuntuacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mejores Puntuaciones")),
      body: const Center(
        child: Text(
          "Pantalla de Puntuaciones",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
