import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/cubit/dio_interceptor.dart';

class FeedingAIService {
  Future<String> sendImage(File imageFile, String modelType) async {
    final formData = FormData.fromMap({
      "modelType": modelType,
      "image": await MultipartFile.fromFile(imageFile.path),
    });

    final response = await DioClient.dio.post(
      "/ai/food/analyze",
      data: formData,
    );
    final data = response.data;

    final label = data['label'] ?? "Unknown";

    final nutrition = data['nutrition'];

    String resultText = "🍽️ $label\n";

    if (nutrition != null) {
      final carb = nutrition['carb'] ??
          nutrition['carbs'] ??
          nutrition['carbohydrates'];

      final protein = nutrition['protein'];

      final fat = nutrition['fat'];

      final calories = nutrition['calories'];

      final sugar = nutrition['sugar'] ??
          nutrition['suger'];

      final nutrients = nutrition['nutrients'];

      final feedback = nutrition['feedback'];

      final pregnancyAdvice = nutrition['pregnancyAdvice'] ??
          nutrition['pregnancyadvice'];

      void addLine(String icon, String title, dynamic value) {
        if (value != null && value.toString().trim().isNotEmpty) {
          resultText += "\n$icon $title: $value";
        }
      }

      addLine("", "Carbs", carb);
      addLine("", "Protein", protein);
      addLine("", "Fat", fat);
      addLine("", "Calories", calories);
      addLine("", "Sugar", sugar);
      addLine("", "Nutrients", nutrients);
      addLine("", "Feedback", feedback);
      addLine("", "Pregnancy Advice", pregnancyAdvice);
    }

    return resultText;
  }
}