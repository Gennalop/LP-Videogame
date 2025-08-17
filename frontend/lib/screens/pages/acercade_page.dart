import 'package:flutter/material.dart';

class AcercadePage extends StatelessWidget {
  const AcercadePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acerca de")),
      body: const Center(
        child: Text(
          "Pantalla de Informacion",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
