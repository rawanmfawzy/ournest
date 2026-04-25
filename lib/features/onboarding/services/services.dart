import '../../../core/cubit/dio_interceptor.dart';
import 'model.dart';

class OnboardingService {
  static Future<void> submit(OnboardingRequest data) async {
    try {
      final response = await DioClient.dio.post(
        "/onboarding/submit",
        data: data.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to submit onboarding");
      }
    } catch (e) {
      throw Exception("Error during onboarding: $e");
    }
  }
}