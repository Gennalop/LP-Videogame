import 'package:flutter/material.dart';
import 'package:frontend/screens/pages/jugar_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({super.key});

  @override
  State<ConfiguracionPage> createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  // Example state variables for the settings
  double _volume = 0.5;
  bool _soundEffectsEnabled = true;
  String _difficultyLevel = 'Medio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Configuraciones",
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
      ), 
      body: Container(
        color: const Color(0xFFF1F8E9), // Very light green background
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Sound settings
            _buildSectionTitle('Audio'),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Efectos de sonido', style: TextStyle(fontSize: 16)),
                        Switch(
                          value: _soundEffectsEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _soundEffectsEnabled = value;
                            });
                          },
                          activeColor: const Color(0xFF8BC34A), // Green
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.volume_up, color: Color(0xFF689F38)), // Dark green icon
                        Expanded(
                          child: Slider(
                            value: _volume,
                            min: 0.0,
                            max: 1.0,
                            divisions: 10,
                            label: (_volume * 100).round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _volume = value;
                              });
                            },
                            activeColor: const Color(0xFF8BC34A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Game settings
            _buildSectionTitle('Juego'),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nivel de dificultad', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDifficultyButton('Fácil'),
                        _buildDifficultyButton('Medio'),
                        _buildDifficultyButton('Difícil'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Additional customizable options
            _buildSectionTitle('Otras Opciones'),
            _buildOptionTile(
              context,
              'Modo sin internet',
              'El juego se puede jugar sin conexión.',
              Icons.wifi_off,
            ),
            _buildOptionTile(
              context,
              'Sincronizar progreso',
              'Guarda automáticamente tu avance en la nube.',
              Icons.cloud_upload,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JugarPage(
                      //playerId: "jugador1", // Cambia esto según corresponda
                      difficulty: _difficultyLevel, // Pasa la dificultad seleccionada
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color(0xFF8BC34A), // White text
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ), 
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: const Text(
                  'JUGAR',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a title for a settings section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF689F38), // Dark green
        ),
      ),
    );
  }

  // Helper method to create difficulty buttons
  Widget _buildDifficultyButton(String level) {
    final bool isSelected = _difficultyLevel == level;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _difficultyLevel = level;
        });
        // Save the difficulty level to the server
        saveDifficulty("jugador1", level); // Cambia "jugador1" según corresponda
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF8BC34A) : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(level),
    );
  }

  // Helper method to create a list tile for an option
  Widget _buildOptionTile(
      BuildContext context, String title, String subtitle, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF689F38)),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        subtitle: Text(subtitle),
        onTap: () {
          // Action for the tile
        },
      ),
    );
  }

  Future<void> saveDifficulty(String playerId, String difficulty) async {
    final url = Uri.parse("http://127.0.0.1:8000/player/$playerId/difficulty");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"player_id": playerId, "difficulty": difficulty}),
    );

    if (response.statusCode == 200) {
      print("Dificultad guardada correctamente");
    } else {
      print("Error guardando dificultad: ${response.statusCode}");
    }
  }
}
