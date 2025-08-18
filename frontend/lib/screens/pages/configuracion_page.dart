import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({super.key});

  @override
  State<ConfiguracionPage> createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  String _dificultad = 'medio';
  List<Map<String, dynamic>> _ranking = [];
  bool _isLoading = true;
  final List<String> _opcionesDificultad = ['fácil', 'medio', 'difícil'];

  @override
  void initState() {
    super.initState();
    _cargarRanking();
  }

  Future<void> _cargarRanking() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/scores/top'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          _ranking = data.map((item) => {
            'nombre': 'Jugador ${item['player_id']}',
            'puntaje': item['score'],
          }).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Error al cargar el ranking');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selector de dificultad
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Nivel de Dificultad",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: _dificultad,
                  isExpanded: true,
                  items: _opcionesDificultad.map((String opcion) {
                    return DropdownMenuItem<String>(
                      value: opcion,
                      child: Text(opcion.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (String? nuevaDificultad) {
                    setState(() {
                      _dificultad = nuevaDificultad!;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Dificultad cambiada a $_dificultad'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Título del ranking
            const Text(
              "Mejores Puntajes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Lista de ranking
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _ranking.isEmpty
                      ? const Center(child: Text("No hay datos disponibles"))
                      : ListView.builder(
                          itemCount: _ranking.length,
                          itemBuilder: (context, index) {
                            final jugador = _ranking[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text((index + 1).toString()),
                                ),
                                title: Text(jugador['nombre']),
                                trailing: Text(
                                  jugador['puntaje'].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}