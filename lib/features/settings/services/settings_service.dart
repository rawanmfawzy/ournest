import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/cubit/dio_interceptor.dart';

class SettingsService {
  static Future<Map<String, dynamic>> getProfile() async {
    final response = await DioClient.dio.get('/users/profile');
    return response.data;
  }

  static Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    String? dateOfBirth,
    String gender = 'Female',
    String? bio,
    String? country,
    String? city,
  }) async {
    final body = <String, dynamic>{
      'fullName': fullName,
      'gender': gender,
    };
    if (dateOfBirth != null) body['dateOfBirth'] = dateOfBirth;
    if (bio != null) body['bio'] = bio;
    if (country != null) body['country'] = country;
    if (city != null) body['city'] = city;

    final response = await DioClient.dio.put('/users/profile', data: body);
    return response.data;
  }

  static Future<String> uploadProfilePicture(File image) async {
    final formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(image.path),
    });
    final response = await DioClient.dio.put('/users/profile/picture', data: formData);
    return response.data['profilePictureUrl'];
  }

  static Future<Map<String, dynamic>> getSettings() async {
    final response = await DioClient.dio.get('/users/settings');
    return response.data;
  }

  static Future<Map<String, dynamic>> updateSettings(Map<String, dynamic> settingsData) async {
    final response = await DioClient.dio.put('/users/settings', data: settingsData);
    return response.data;
  }

  static Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    await DioClient.dio.post(
      '/users/change-password',
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      },
    );
  }
}