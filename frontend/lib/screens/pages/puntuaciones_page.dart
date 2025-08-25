import 'package:flutter/material.dart';

// Modelo de datos para una puntuación
class Puntuacion {
  final String nombreJugador;
  final int puntuacion;

  Puntuacion({
    required this.nombreJugador,
    required this.puntuacion,
  });
}

// Clase principal de la pantalla de puntuaciones
class PuntuacionesPage extends StatefulWidget {
  const PuntuacionesPage({super.key});

  @override
  State<PuntuacionesPage> createState() => _PuntuacionesPageState();
}

class _PuntuacionesPageState extends State<PuntuacionesPage> {
  late Future<List<Puntuacion>> _futurePuntuaciones;

  @override
  void initState() {
    super.initState();
    _futurePuntuaciones = _obtenerPuntuaciones();
  }

  // Simula una llamada a una API para obtener las puntuaciones
  Future<List<Puntuacion>> _obtenerPuntuaciones() async {
    // Retraso de 2 segundos para simular una carga de red
    await Future.delayed(const Duration(seconds: 2));

    // Datos de ejemplo para el ranking
    return [
      Puntuacion(nombreJugador: "Estrella", puntuacion: 2500),
      Puntuacion(nombreJugador: "Génesis", puntuacion: 2350),
      Puntuacion(nombreJugador: "Christopher", puntuacion: 2100),
      Puntuacion(nombreJugador: "Austin", puntuacion: 1980),
      Puntuacion(nombreJugador: "Jugador Anónimo", puntuacion: 1700),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mejores Puntuaciones",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {
                _futurePuntuaciones = _obtenerPuntuaciones();
              });
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF1F8E9),
        child: FutureBuilder<List<Puntuacion>>(
          future: _futurePuntuaciones,
          builder: (context, snapshot) {
            // Muestra un indicador de carga mientras se obtienen los datos
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Maneja el caso de error
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // Muestra un mensaje si no hay datos
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No hay puntuaciones disponibles."));
            }

            // Si los datos están listos, construye la lista de puntuaciones
            final puntuaciones = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: puntuaciones.length,
              itemBuilder: (context, index) {
                final puntuacion = puntuaciones[index];
                return _buildPuntuacionCard(index, puntuacion);
              },
            );
          },
        ),
      ),
    );
  }

  // Widget para construir cada tarjeta de puntuación
  Widget _buildPuntuacionCard(int index, Puntuacion puntuacion) {
    final rank = index + 1;
    Color rankColor = const Color(0xFF689F38); // Verde oscuro por defecto
    if (rank == 1) rankColor = Colors.amber; // Oro para el 1er lugar
    if (rank == 2) rankColor = Colors.grey; // Plata para el 2do lugar
    if (rank == 3) rankColor = const Color(0xFFCD7F32); // Bronce para el 3er lugar

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: rankColor,
          child: Text(
            '$rank',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ), 
        title: Text(
          puntuacion.nombreJugador,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          puntuacion.puntuacion.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}