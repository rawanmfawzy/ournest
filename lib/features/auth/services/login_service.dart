import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/utils/api_constants.dart';

class LoginService {
  static Future login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse("${ApiConstants.baseUrl}/auth/login");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception("Login failed: ${response.body}");
  }

  static Future<Map<String, dynamic>> loginWithGoogle() async {
    var url = Uri.parse("${ApiConstants.baseUrl}/auth/google");

    var response = await http.post(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception("Google login failed: ${response.body}");
  }

  static Future<Map<String, dynamic>> loginWithFacebook() async {
    var url = Uri.parse("${ApiConstants.baseUrl}/auth/facebook");

    var response = await http.post(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception("Facebook login failed: ${response.body}");
  }

  static Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    var url = Uri.parse("${ApiConstants.baseUrl}/auth/refresh");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception("Refresh token failed: ${response.body}");
  }
}
