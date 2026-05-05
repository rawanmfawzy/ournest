import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/cubit/token_storage_helper.dart';
import '../../../core/utils/api_constants.dart';

class LoginService {

  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/auth/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {

      await TokenStorage.saveToken(data["token"]);
      await TokenStorage.saveRefreshToken(data["refreshToken"]);
      await TokenStorage.saveUserId(data["user"]["id"]);

      return data;
    }

    throw Exception(data["error"] ?? "Login failed");
  }
  static Future<Map<String, dynamic>> loginWithGoogle(String token, String role) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/auth/google");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"token": token, "role": role}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      return data;
    }

    throw Exception(data["error"] ?? "Google login failed");
  }

  static Future<Map<String, dynamic>> loginWithFacebook(String token, String role) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/auth/facebook");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"token": token, "role": role}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      return data;
    }

    throw Exception(data["error"] ?? "Facebook login failed");
  }

  static Future<Map<String, dynamic>> refreshToken(
      String token,
      String refreshToken,
      ) async {

    final url = Uri.parse("${ApiConstants.baseUrl}/auth/refresh");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "token": token,
        "refreshToken": refreshToken,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      return data;
    }

    throw Exception(data["error"] ?? "Refresh token failed");
  }
}