import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../core/cubit/token_storage_helper.dart';
import '../../../core/utils/api_constants.dart';

class SettingsService {
  // ── Profile ────────────────────────────────────────────────

  /// GET /api/users/profile
  static Future<Map<String, dynamic>> getProfile() async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/users/profile');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return jsonDecode(response.body);
    final error = jsonDecode(response.body);
    throw Exception(error['error'] ?? 'Failed to load profile');
  }

  /// PUT /api/users/profile
  static Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    String? dateOfBirth,
    String gender = 'Female',
    String? bio,
    String? country,
    String? city,
  }) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/users/profile');

    final body = <String, dynamic>{
      'fullName': fullName,
      'gender': gender,
    };
    if (dateOfBirth != null) body['dateOfBirth'] = dateOfBirth;
    if (bio != null) body['bio'] = bio;
    if (country != null) body['country'] = country;
    if (city != null) body['city'] = city;

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return jsonDecode(response.body);
    final error = jsonDecode(response.body);
    throw Exception(error['error'] ?? 'Failed to update profile');
  }

  /// PUT /api/users/profile/picture  (multipart)
  static Future<String> uploadProfilePicture(File image) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/users/profile/picture');

    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('image', image.path));

    final streamedResponse = await request.send()
        .timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['profilePictureUrl'] as String;
    }
    final error = jsonDecode(response.body);
    throw Exception(error['error'] ?? 'Failed to upload picture');
  }

  // ── Settings ───────────────────────────────────────────────

  /// GET /api/users/settings
  static Future<Map<String, dynamic>> getSettings() async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/users/settings');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return jsonDecode(response.body);
    final error = jsonDecode(response.body);
    throw Exception(error['error'] ?? 'Failed to load settings');
  }

  /// PUT /api/users/settings
  static Future<Map<String, dynamic>> updateSettings({
    required String language,
    required bool notificationsEnabled,
    required bool emailNotifications,
    required bool pushNotifications,
    required bool smsNotifications,
    required String theme,
    required bool privacyProfilePublic,
  }) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/users/settings');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'language': language,
        'notificationsEnabled': notificationsEnabled,
        'emailNotifications': emailNotifications,
        'pushNotifications': pushNotifications,
        'smsNotifications': smsNotifications,
        'theme': theme,
        'privacyProfilePublic': privacyProfilePublic,
      }),
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return jsonDecode(response.body);
    final error = jsonDecode(response.body);
    throw Exception(error['error'] ?? 'Failed to update settings');
  }

  /// POST /api/users/change-password
  static Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/users/change-password');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      }),
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) return;
    final error = jsonDecode(response.body);
    throw Exception(error['error'] ?? 'Failed to change password');
  }
}
