import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/utils/api_constants.dart';

class BabyCareService {
  /// GET /api/babycare/feeding?age={age}
  static Future<Map<String, dynamic>> getFeedingTips({String? age}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/babycare/feeding')
        .replace(queryParameters: age != null ? {'age': age} : null);

    final response = await http
        .get(uri, headers: {'Content-Type': 'application/json'})
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return jsonDecode(response.body);
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Failed to load feeding tips');
  }

  /// GET /api/babycare/vitamins?age={age}
  static Future<Map<String, dynamic>> getVitamins({String? age}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/babycare/vitamins')
        .replace(queryParameters: age != null ? {'age': age} : null);

    final response = await http
        .get(uri, headers: {'Content-Type': 'application/json'})
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return jsonDecode(response.body);
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Failed to load vitamins');
  }

  /// GET /api/babycare/vaccinations?age={age}
  static Future<Map<String, dynamic>> getVaccinations({String? age}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/babycare/vaccinations')
        .replace(queryParameters: age != null ? {'age': age} : null);

    final response = await http
        .get(uri, headers: {'Content-Type': 'application/json'})
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return jsonDecode(response.body);
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Failed to load vaccinations');
  }

  /// GET /api/babycare/all?age={age}  — full bundle
  static Future<Map<String, dynamic>> getAll({String? age}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/babycare/all')
        .replace(queryParameters: age != null ? {'age': age} : null);

    final response = await http
        .get(uri, headers: {'Content-Type': 'application/json'})
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return jsonDecode(response.body);
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Failed to load baby care data');
  }
}
