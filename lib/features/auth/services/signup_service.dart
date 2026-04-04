import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/utils/api_constants.dart';

class SignupService {
  static Future signup({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
  }) async {
    var url = Uri.parse("${ApiConstants.baseUrl}/auth/register");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "name": name,
        "role": "Mother"
      }),
    );

    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception("Signup failed: ${response.body}");
  }
}