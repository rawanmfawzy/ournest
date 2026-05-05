import '../../../core/cubit/dio_interceptor.dart';

class PeriodService {
  static Future<List<Map<String, dynamic>>> getPeriods() async {
    final response = await DioClient.dio.get('/period');
    return (response.data as List).cast<Map<String, dynamic>>();
  }

  static Future<Map<String, dynamic>> addPeriod({
    required String startDate,
    String? endDate,
    int? cycleLengthDays,
    int? periodLengthDays,
    String? flowIntensity,
    String? symptoms,
    String? notes,
  }) async {
    final body = <String, dynamic>{'startDate': startDate};
    if (endDate != null) body['endDate'] = endDate;
    if (cycleLengthDays != null) body['cycleLengthDays'] = cycleLengthDays;
    if (periodLengthDays != null) body['periodLengthDays'] = periodLengthDays;
    if (flowIntensity != null) body['flowIntensity'] = flowIntensity;
    if (symptoms != null) body['symptoms'] = symptoms;
    if (notes != null) body['notes'] = notes;

    final response = await DioClient.dio.post('/period', data: body);
    return response.data;
  }

  static Future<Map<String, dynamic>> getPredictions() async {
    final response = await DioClient.dio.get('/period/predictions');
    return response.data;
  }
}