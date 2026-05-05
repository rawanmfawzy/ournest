import '../../../core/cubit/dio_interceptor.dart';
import '../../../core/cubit/token_storage_helper.dart';

class FamilyService {
  static Future<Map<String, dynamic>> getDashboard() async {
    try {
      final response = await DioClient.dio.get('/family/dashboard');
      
      // Cache isPregnant if available
      if (response.data != null && response.data['isPregnant'] != null) {
        await TokenStorage.saveIsPregnant(response.data['isPregnant']);
      }
      
      return response.data;
    } catch (e) {
      throw Exception('Failed to load family dashboard: $e');
    }
  }
}
