import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/cubit/token_storage_helper.dart';
import '../../../core/utils/api_constants.dart';

class PeriodService {
  /// GET /api/period  — last 12 period entries
  static Future<List<Map<String, dynamic>>> getPeriods() async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/period');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    }

    final error = jsonDecode(response.body);
    throw Exception(error['error'] ?? 'Failed to load period history');
  }

  /// POST /api/period  — log a new period entry
  static Future<Map<String, dynamic>> addPeriod({
    required String startDate,
    String? endDate,
    int? cycleLengthDays,
    int? periodLengthDays,
    String? flowIntensity,
    String? symptoms,
    String? notes,
  }) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/period');

    final body = <String, dynamic>{
      'startDate': startDate,
    };
    if (endDate != null) body['endDate'] = endDate;
    if (cycleLengthDays != null) body['cycleLengthDays'] = cycleLengthDays;
    if (periodLengthDays != null) body['periodLengthDays'] = periodLengthDays;
    if (flowIntensity != null) body['flowIntensity'] = flowIntensity;
    if (symptoms != null) body['symptoms'] = symptoms;
    if (notes != null) body['notes'] = notes;

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return jsonDecode(response.body);

    final error = jsonDecode(response.body);
    throw Exception(error['error'] ?? 'Failed to log period');
  }

  /// GET /api/period/predictions  — next period prediction
  static Future<Map<String, dynamic>> getPredictions() async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/period/predictions');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return jsonDecode(response.body);

    final error = jsonDecode(response.body);
    throw Exception(error['error'] ?? 'Failed to load predictions');
  }
}
