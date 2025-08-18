import 'package:flutter/material.dart';

class AcercadePage extends StatelessWidget {
  const AcercadePage({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.eco,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              const Text(
                "🌎 ¡Bienvenido a EchoCatch! 🌱",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Este juego fue creado para que los niños y niñas aprendan a cuidar el planeta mientras se divierten. "
                "Aquí descubrirás cómo separar la basura y por qué es importante reciclar.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                "♻️ Cuando reciclas, ayudas a que los ríos, el mar y los bosques estén limpios, "
                "y los animales vivan felices y sanos.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                "👩‍💻 Este juego fue creado por un equipo que quiere que los niños aprendan jugando.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                "✨ ¡Con tu ayuda podemos lograr un mundo más limpio y verde! 💚",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
