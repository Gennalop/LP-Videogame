import 'package:flutter/material.dart';

class EstadisticasPage extends StatelessWidget {
  const EstadisticasPage({super.key});

  // Ejemplo de historial con fecha y hora
  final List<Stats> historial = const [
    Stats(jugador: "Alex", points: 120, vidas_restantes: 2, play_time: 45.5, objetos_reciclados: 15, objetos_toxicos: 3, errors: 1, fecha: "17/08/2025 14:35"),
    Stats(jugador: "Alex", points: 200, vidas_restantes: 3, play_time: 60, objetos_reciclados: 20, objetos_toxicos: 1, errors: 0, fecha: "16/08/2025 16:10"),
    Stats(jugador: "Alex", points: 90, vidas_restantes: 1, play_time: 30, objetos_reciclados: 10, objetos_toxicos: 2, errors: 2, fecha: "15/08/2025 18:50"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tus Estadísticas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ), 
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74ebd5), Color(0xFFACB6E5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: historial.length,
            itemBuilder: (context, index) {
              final partida = historial[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título de la partida
                      Text(
                        "Partida ${index + 1}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Fecha y hora
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            partida.fecha,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Estadísticas principales
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange),
                          const SizedBox(width: 6),
                          Text("${partida.points} puntos"),
                          const SizedBox(width: 16),
                          const Icon(Icons.favorite, color: Colors.red),
                          const SizedBox(width: 6),
                          Text("${partida.vidas_restantes} vidas"),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.blue),
                          const SizedBox(width: 6),
                          Text("${partida.play_time.toStringAsFixed(1)} seg"),
                          const SizedBox(width: 16),
                          const Icon(Icons.recycling, color: Colors.green),
                          const SizedBox(width: 6),
                          Text("${partida.objetos_reciclados} reciclados"),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.purple),
                          const SizedBox(width: 6),
                          Text("${partida.objetos_toxicos} tóxicos"),
                          const SizedBox(width: 16),
                          const Icon(Icons.error, color: Colors.black),
                          const SizedBox(width: 6),
                          Text("${partida.errors} errores"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Modelo Stats con fecha
class Stats {
  final String jugador;
  final int points;
  final int vidas_restantes;
  final double play_time;
  final int objetos_reciclados;
  final int objetos_toxicos;
  final int errors;
  final String fecha; // nuevo campo

  const Stats({
    required this.jugador,
    required this.points,
    required this.vidas_restantes,
    required this.play_time,
    required this.objetos_reciclados,
    required this.objetos_toxicos,
    required this.errors,
    required this.fecha,
  });
}
