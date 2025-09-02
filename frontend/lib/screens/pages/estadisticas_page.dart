import 'package:flutter/material.dart';
import '../services/stats_service.dart'; 

class EstadisticasPage extends StatefulWidget {
  const EstadisticasPage({super.key});

  @override
  _EstadisticasPageState createState() => _EstadisticasPageState();
}

class _EstadisticasPageState extends State<EstadisticasPage> {
  final StatsService statsService = StatsService();
  List<Stats> historial = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistorial();
  }

  Future<void> _loadHistorial() async {
    final data = await statsService.fetchHistorial();
    setState(() {
      historial = data;
      isLoading = false;
    });
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
                          color: partida.win
                              ? Colors.white.withOpacity(0.9)
                              : Colors.red.shade100.withOpacity(0.8), // 👈 más rojizo si perdió
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Título de la partida
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Partida ${index + 1}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      partida.win
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: partida.win
                                          ? Colors.green
                                          : Colors.red,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 4),
                                // Fecha y hora
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      partida.createdAt,
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
                                    const Icon(Icons.star,
                                        color: Colors.orange),
                                    const SizedBox(width: 6),
                                    Text("${partida.points} puntos"),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.favorite,
                                        color: Colors.red),
                                    const SizedBox(width: 6),
                                    Text("${partida.vidasRestantes} vidas"),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.timer, color: Colors.blue),
                                    const SizedBox(width: 6),
                                    Text("${partida.playTime.toStringAsFixed(1)} seg"),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                // Objetos reciclados por color
                                Row(
                                  children: [
                                    const Icon(Icons.delete,
                                        color: Colors.green),
                                    const SizedBox(width: 6),
                                    Text("${partida.objetosVerdes} verdes"),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.delete,
                                        color: Colors.blue),
                                    const SizedBox(width: 6),
                                    Text("${partida.objetosAzules} azules"),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.delete,
                                        color: Colors.black),
                                    const SizedBox(width: 6),
                                    Text("${partida.objetosNegros} negros"),
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
