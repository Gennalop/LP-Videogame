import 'dart:convert';
import 'package:http/http.dart' as http;

class Stats {
  final String createdAt;
  final bool win;
  final int points;
  final int vidasRestantes;
  final double playTime;
  final int objetosVerdes;
  final int objetosAzules;
  final int objetosNegros;

  Stats({
    required this.createdAt,
    required this.win,
    required this.points,
    required this.vidasRestantes,
    required this.playTime,
    required this.objetosVerdes,
    required this.objetosAzules,
    required this.objetosNegros,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      createdAt: json['created_at'] ?? '',
      win: json['win'] ?? false,
      points: json['points'] ?? 0,
      vidasRestantes: json['vidas_restantes'] ?? 0,
      playTime: (json['play_time'] ?? 0).toDouble(),
      objetosVerdes: json['objetos_verdes'] ?? 0,
      objetosAzules: json['objetos_azules'] ?? 0,
      objetosNegros: json['objetos_negros'] ?? 0,
    );
  }
}

class StatsService {
  /// Guarda estadísticas en el backend
  Future<void> saveStats({
    required bool win,
    required int points,
    required int vidasRestantes,
    required double playTime,
    required int objetosVerdes,
    required int objetosAzules,
    required int objetosNegros,
  }) async {
    final stats = {
      "created_at": DateTime.now().toIso8601String(),
      "win": win,
      "points": points,
      "vidas_restantes": vidasRestantes,
      "play_time": playTime,
      "objetos_verdes": objetosVerdes,
      "objetos_azules": objetosAzules,
      "objetos_negros": objetosNegros,
    };

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8000/stats/add"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(stats),
      );

      if (response.statusCode == 200) {
        print("Estadísticas guardadas correctamente");
      } else {
        print("Error guardando estadísticas: ${response.statusCode}");
      }
    } catch (e) {
      print("Error enviando estadísticas: $e");
    }
  }

  /// Obtiene el historial completo de estadísticas
  Future<List<Stats>> fetchHistorial() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:8000/stats/"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Stats> loadedStats = [];

        if (data is List) {
          for (var item in data) {
            loadedStats.add(Stats.fromJson(item));
          }
        }

        // Devolver más recientes primero
        return loadedStats.reversed.toList();
      } else {
        print("Error al obtener estadísticas: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error en la conexión: $e");
      return [];
    }
  }
}
