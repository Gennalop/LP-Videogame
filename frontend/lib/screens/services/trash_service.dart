import 'dart:convert';
import 'package:http/http.dart' as http;

class TrashService {
  static Future<Map<String, dynamic>> fetchTrashData() async {
    final url = Uri.parse("http://localhost:8000/generate_trash");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Error al obtener basura");
    }
  }
}
