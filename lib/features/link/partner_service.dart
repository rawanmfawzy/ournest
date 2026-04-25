import '../../../core/cubit/dio_interceptor.dart';

class PartnerService {
  // إرسال دعوة للشريك (بيحتاج إيميل الشريك)
  static Future<Map<String, dynamic>> sendInvite(String partnerEmail) async {
    final response = await DioClient.dio.post(
      '/partner/invite',
      data: {'partnerEmail': partnerEmail},
    );
    return response.data;
  }

  // قبول الدعوة (بياخد الكود اللي وصل للأم/الأب)
  static Future<Map<String, dynamic>> acceptInvite(String token) async {
    final response = await DioClient.dio.post('/partner/accept/$token');
    return response.data;
  }
}