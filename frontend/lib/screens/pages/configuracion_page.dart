import 'package:flutter/material.dart';

class ConfiguracionPage extends StatelessWidget {
  const ConfiguracionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configuraciones")),
      body: const Center(
        child: Text(
          "Pantalla de configuraciones",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
