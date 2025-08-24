import 'package:flutter/material.dart';

class ComojugarPage extends StatelessWidget {
  const ComojugarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cómo Jugar"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "📖 Instrucciones",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              const Text(
                "1️⃣ Tu objetivo es atrapar los objetos de basura en el "
                "contenedor ubicado al final de la pantalla.\n",
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                "2️⃣ Usa los botones de izquierda y derecha para mover el objeto "
                "y atraparlos correctamente.\n",
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                "3️⃣ Si dejas caer un objeto de basura, perderás una vida.\n",
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                "4️⃣ Si atrapas un objeto incorrecto, perderás tanto un punto "
                "como una vida.\n",
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                "5️⃣ Puedes pausar y reanudar la partida en cualquier momento "
                "usando el botón del medio.\n",
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

