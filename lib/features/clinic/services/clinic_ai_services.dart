import 'package:dio/dio.dart';
import '../../../core/cubit/dio_interceptor.dart';
import '../../../core/cubit/token_storage_helper.dart';

class ClinicAIService {
  final Dio _dio = DioClient.dio;

  Future<String> createConversation() async {
    final userId = await TokenStorage.getUserId();

    final res = await _dio.post(
      "/ai/conversations",
      data: {
        "userId": userId,
        "title": "New Conversation",
      },
    );

    return res.data["id"];
  }

  Future<String> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final res = await _dio.post(
      "/ai/messages",
      data: {
        "conversationId": conversationId,
        "content": content,
      },
    );

    final data = res.data;

    final responseText = data["content"] ?? "";

    if (res.statusCode != 200) {
      throw Exception("AI_FAILED");
    }

    return responseText;
  }
}