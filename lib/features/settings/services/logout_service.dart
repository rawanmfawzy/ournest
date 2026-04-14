import '../../../core/cubit/dio_interceptor.dart';
class LogoutService {
  static Future<void> logout() async {
    final dio = DioClient.dio;

    await dio.post("/auth/logout"); // ✅ من غير /api
  }
}