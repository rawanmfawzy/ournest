import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/utils/api_constants.dart';

class SignupService {
  static Future signup({
    required String phone,
    required String password,
    required String confirmPassword,
    required String username,


  }) async {
    var url = Uri.parse("${ApiConstants.baseUrl}/auth/register");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
        "phoneNumber": phone,
      }),
    ).timeout(const Duration(seconds: 15));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception("Signup failed: ${response.body}");
  }
}
