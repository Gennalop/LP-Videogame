import 'package:flutter/material.dart';

class ComojugarPage extends StatelessWidget {
  const ComojugarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cómo Jugar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.green,
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
                "1️⃣ Tu objetivo es atrapar los objetos de basura que caen en el "
                "contenedor ubicado en la parte inferior de la pantalla.\n",
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                "2️⃣ Usa los botones ⬅️ (izquierda) y ➡️ (derecha) para mover el contenedor "
                "y posicionarte debajo de los objetos.\n",
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                "3️⃣ El botón ⏸️ del medio te permite pausar y reanudar la partida en cualquier momento.\n",
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                "4️⃣ Cada objeto atrapado correctamente aumenta tu ⭐ puntaje.\n",
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                "5️⃣ Si dejas caer un objeto o atrapas algo incorrecto, perderás una ❤️ vida.\n",
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                "6️⃣ El juego termina cuando se acaban tus vidas o el tiempo ⏱️ llega a cero.\n",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
