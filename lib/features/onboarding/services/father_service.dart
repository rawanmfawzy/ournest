import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/utils/api_constants.dart';

class FatherService {
  /// POST /api/father
  /// Creates the father profile after onboarding.
  /// Weight / Height come from OnboardingData (already collected).
  static Future<Map<String, dynamic>> createProfile({
    required String token,
    double? weight,
    double? height,
    String? bloodType,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/father');

    final body = <String, dynamic>{};
    if (weight != null) body['weight'] = weight;
    if (height != null) body['height'] = height;
    if (bloodType != null && bloodType.isNotEmpty) body['bloodType'] = bloodType;

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 15));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) return data;
    // 400 means profile already exists — that is acceptable
    if (response.statusCode == 400) return data;

    throw Exception(data['error'] ?? 'Failed to create father profile');
  }
}
