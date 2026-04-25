import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/utils/api_constants.dart';

class PassService {
  static Future<Map<String, dynamic>> forgotPassword(String email, String recoveryEmail) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/auth/forgot-password");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "recoveryEmail": recoveryEmail}),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["success"] == true) {
      return data;
    }
    throw Exception(data["error"] ?? "Failed to send verification code");
  }

  static Future<Map<String, dynamic>> verifyOtp(String email, String otpCode) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/auth/verify-otp");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "otpCode": otpCode}),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["success"] == true) {
      return data;
    }
    throw Exception(data["error"] ?? "Failed to verify code");
  }

  static Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/auth/reset-password");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "resetToken": resetToken,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword,
      }),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["success"] == true) {
      return data;
    }
    throw Exception(data["error"] ?? "Failed to reset password");
  }
}
