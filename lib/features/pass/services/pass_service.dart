import '../../../core/cubit/dio_interceptor.dart';

class PassService {
  static Future<Map<String, dynamic>> forgotPassword(String email, String recoveryEmail) async {
    try {
      final response = await DioClient.dio.post(
        "/auth/forgot-password",
        data: {"email": email, "recoveryEmail": recoveryEmail},
      );
      return response.data;
    } catch (e) {
      throw Exception("Failed to send verification code");
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(String email, String otpCode) async {
    try {
      final response = await DioClient.dio.post(
        "/auth/verify-otp",
        data: {"email": email, "otpCode": otpCode},
      );
      return response.data;
    } catch (e) {
      throw Exception("Failed to verify code");
    }
  }

  static Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await DioClient.dio.post(
        "/auth/reset-password",
        data: {
          "email": email,
          "resetToken": resetToken,
          "newPassword": newPassword,
          "confirmNewPassword": confirmNewPassword,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception("Failed to reset password");
    }
  }
}