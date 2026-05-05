import 'package:dio/dio.dart';
import '../../../../core/cubit/dio_interceptor.dart';
import '../../../../core/cubit/token_storage_helper.dart';

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
  Future<List<dynamic>> getHistory() async {
    final res = await _dio.get("/ai/history");

    if (res.statusCode == 200) {
      return res.data;
    } else {
      throw Exception("FAILED_TO_LOAD_HISTORY");
    }
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
  Future<List<dynamic>> getConversations() async {
    final res = await _dio.get("/ai/conversations");

    if (res.statusCode == 200) {
      return res.data;
    } else {
      throw Exception("FAILED_TO_LOAD_CONVERSATIONS");
    }
  }
  Future<List<dynamic>> getMessagesByConversation(String conversationId) async {
    final res = await _dio.get("/ai/messages/$conversationId");

    if (res.statusCode == 200) {
      return res.data;
    } else {
      throw Exception("FAILED_TO_LOAD_MESSAGES");
    }
  }
}