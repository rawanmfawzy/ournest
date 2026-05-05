
import '../../../../core/cubit/dio_interceptor.dart';

class BabyCareService {
  static Future<Map<String, dynamic>> getFeedingTips({String? age}) async {
    final response = await DioClient.dio.get(
      '/babycare/feeding',
      queryParameters: age != null ? {'age': age} : null,
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> getVitamins({String? age}) async {
    final response = await DioClient.dio.get(
      '/babycare/vitamins',
      queryParameters: age != null ? {'age': age} : null,
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> getVaccinations({String? age}) async {
    final response = await DioClient.dio.get(
      '/babycare/vaccinations',
      queryParameters: age != null ? {'age': age} : null,
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> getAll({String? age}) async {
    final response = await DioClient.dio.get(
      '/babycare/all',
      queryParameters: age != null ? {'age': age} : null,
    );
    return response.data;
  }
}