import '../../../core/cubit/dio_interceptor.dart';

class MotherService {
  static Future<Map<String, dynamic>> createProfile({
    double? weight,
    double? height,
    String? bloodType,
  }) async {
    final body = <String, dynamic>{};
    if (weight != null) body['weight'] = weight;
    if (height != null) body['height'] = height;
    if (bloodType != null) body['bloodType'] = bloodType;

    final response = await DioClient.dio.post('/mother', data: body);
    return response.data;
  }
}