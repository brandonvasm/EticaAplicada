import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://infog.onrender.com/api';

  static Future<List<dynamic>> getInstituciones(String languageCode) async {
    final response = await http.get(
      Uri.parse('$baseUrl/instituciones'),
      headers: {'Accept-Language': languageCode},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar instituciones');
    }
  }


  static Future<List<dynamic>> getTramitesPorInstitucion(
      String codigoInstitucion, String languageCode) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tramites?institucion_codigo=$codigoInstitucion'),
      headers: {'Accept-Language': languageCode},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar lista de trámites');
    }
  }

 
  static Future<Map<String, dynamic>?> getTramitePorId(
      int id, String languageCode) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tramites/$id'),
      headers: {'Accept-Language': languageCode},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }


  static Future<List<dynamic>> getSedes() async {
    final response = await http.get(Uri.parse('$baseUrl/sedes'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener las sedes');
    }
  }
}