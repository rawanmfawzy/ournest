import '../../../core/cubit/dio_interceptor.dart';

class PregnancyService {
  // بدء حمل جديد (لو رجعت للمود ده)
  static Future<void> startPregnancy(String lastPeriodDate) async {
    await DioClient.dio.post('/pregnancy/start', data: {
      "lastPeriodDate": lastPeriodDate
    });
  }

  // إنهاء الحمل (الولادة أو محاولة الحمل)
  static Future<void> endPregnancy() async {
    await DioClient.dio.post('/pregnancy/end');
  }
}