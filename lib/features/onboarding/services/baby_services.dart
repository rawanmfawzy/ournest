import '../../../core/cubit/dio_interceptor.dart';

class BabyData {
  static String dateOfBirth = "";
  static String gender = "Boy";
  static double weight = 0.0;
  static String name = "";
}

class BabyService {
  static Future<void> createBaby() async {
    try {
      final response = await DioClient.dio.post(
        "/baby",
        data: {
          "name": BabyData.name,
          "dateOfBirth": BabyData.dateOfBirth,
          "gender": BabyData.gender,
          "birthWeight": BabyData.weight,
        },
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to add baby");
      }
    } catch (e) {
      throw Exception("Error adding baby: $e");
    }
  }
}