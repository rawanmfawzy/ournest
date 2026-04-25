import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/cubit/dio_interceptor.dart';

class MedicineService {
  final Dio dio = DioClient.dio;

  Future<dynamic> scanMedicine(File image) async {
    try {
      final formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final response = await dio.post(
        "/medicine/scan",
        data: formData,
      );

      return response.data;
    } catch (e) {
      return {"error": e.toString()};
    }
  }

  String _parse(dynamic data) {
    if (data is Map) {
      if (data["result"] != null) return data["result"].toString();
      if (data["message"] != null) return data["message"].toString();
      if (data["error"] != null) return data["error"].toString();
    }
    return data.toString();
  }
}