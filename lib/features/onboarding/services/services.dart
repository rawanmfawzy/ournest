import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

class OnboardingService {
  static const baseUrl = "http://10.0.2.2:5038/api";

  static Future<void> submit(OnboardingRequest data, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/onboarding/submit"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200) {
      print("Success");
    } else {
      print(response.body);
      throw Exception("Failed");
    }
  }
}