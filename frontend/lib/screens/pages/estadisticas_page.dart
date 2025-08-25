import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EstadisticasPage extends StatefulWidget {
  final String jugador;
  const EstadisticasPage({super.key, required this.jugador});

  @override
  _EstadisticasPageState createState() => _EstadisticasPageState();
}

class _EstadisticasPageState extends State<EstadisticasPage> {
  List<Stats> historial = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistorial();
  }

  Future<void> fetchHistorial() async {
    try {
      final url = Uri.parse("http://localhost:8000/stats/?jugador=${widget.jugador}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Stats> loadedStats = [];

        if (data is List) {
          for (var item in data) {
            loadedStats.add(
              Stats(
                jugador: item['jugador'] ?? '',
                points: item['points'] ?? 0,
                vidas_restantes: item['vidas_restantes'] ?? 0,
                play_time: (item['play_time'] ?? 0).toDouble(),
                objetos_reciclados: item['objetos_reciclados'] ?? 0,
                errors: item['errors'] ?? 0,
                fecha: item['fecha'] ?? '',
              ),
            );
          }
        }

        setState(() {
          historial = loadedStats.reversed.toList(); // mostrar el más reciente primero
          isLoading = false;
        });
      } else {
        print("Error al obtener estadísticas: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error en la conexión: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tus Estadísticas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : historial.isEmpty
                  ? const Center(child: Text("No hay registros disponibles"))
                  : ListView.builder(
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
                                    const Icon(Icons.calendar_today,
                                        size: 16, color: Colors.grey),
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

// Modelo Stats
class Stats {
  final String jugador;
  final int points;
  final int vidas_restantes;
  final double play_time;
  final int objetos_reciclados;
  final int errors;
  final String fecha;

  const Stats({
    required this.jugador,
    required this.points,
    required this.vidas_restantes,
    required this.play_time,
    required this.objetos_reciclados,
    required this.errors,
    required this.fecha,
  });
}

