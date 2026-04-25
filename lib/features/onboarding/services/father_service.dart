import '../../../core/cubit/dio_interceptor.dart';

class FatherService {
  static Future<Map<String, dynamic>> createProfile({
    double? weight,
    double? height,
    String? bloodType,
  }) async {
    final body = <String, dynamic>{};
    if (weight != null) body['weight'] = weight;
    if (height != null) body['height'] = height;
    if (bloodType != null && bloodType.isNotEmpty) body['bloodType'] = bloodType;

    try {
      final response = await DioClient.dio.post(
        '/father',
        data: body,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create father profile: $e');
    }
  }
}