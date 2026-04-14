import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/utils/api_constants.dart';
import '../../../core/cubit/token_storage_helper.dart';

class CommunityService {

  static Future<List<dynamic>> getPosts() async {
    final token = await TokenStorage.getToken();

    final url = Uri.parse("${ApiConstants.baseUrl}/community/posts");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data is List) {
      return data;
    }

    throw Exception(response.body);
  }

  static Future<Map<String, dynamic>> createPost({
    required String content,
    String? imageUrl,
    required String category,
  }) async {
    final token = await TokenStorage.getToken();

    final url = Uri.parse("${ApiConstants.baseUrl}/community/posts");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "content": content,
        "imageUrl": imageUrl,
        "category": category,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    }

    throw Exception(response.body);
  }

  static Future<Map<String, dynamic>> toggleLike(String postId) async {
    final token = await TokenStorage.getToken();

    final url = Uri.parse(
      "${ApiConstants.baseUrl}/community/posts/$postId/like",
    );

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return jsonDecode(response.body);
  }

  static Future<void> addComment(String postId, String content) async {
    final token = await TokenStorage.getToken();

    final url = Uri.parse(
      "${ApiConstants.baseUrl}/community/posts/$postId/comments",
    );

    await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"content": content}),
    );
  }

  static Future<void> addReply(String commentId, String content) async {
    final token = await TokenStorage.getToken();

    final url = Uri.parse(
      "${ApiConstants.baseUrl}/community/comments/$commentId/replies",
    );

    await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"content": content}),
    );
  }
}