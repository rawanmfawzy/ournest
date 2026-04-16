import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/utils/api_constants.dart';
import '../../../core/cubit/token_storage_helper.dart';

class CommunityService {

  static Future<List<dynamic>> getPosts() async {
    final token = await TokenStorage.getToken();

    final response = await http.get(
      Uri.parse("${ApiConstants.baseUrl}/community/posts"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(jsonDecode(response.body)["message"] ?? "Error");
    }
  }

  static Future<Map<String, dynamic>> createPost({
    required String content,
    String? imageUrl,
    required String category,
  }) async {
    final token = await TokenStorage.getToken();

    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/community/posts"),
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

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(jsonDecode(response.body)["message"] ?? "Error");
    }
  }

  static Future<Map<String, dynamic>> toggleLike(String postId) async {
    final token = await TokenStorage.getToken();

    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/community/posts/$postId/like"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(jsonDecode(response.body)["message"] ?? "Error");
    }
  }

  static Future<void> addComment(String postId, String content) async {
    final token = await TokenStorage.getToken();

    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/community/posts/$postId/comments"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"content": content}),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)["message"] ?? "Error");
    }
  }

  static Future<List<dynamic>> getComments(String postId) async {
    final token = await TokenStorage.getToken();

    final res = await http.get(
      Uri.parse("${ApiConstants.baseUrl}/community/posts/$postId/comments"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception(jsonDecode(res.body)["message"] ?? "Error");
    }
  }

  static Future<List<dynamic>> getReplies(String commentId) async {
    final token = await TokenStorage.getToken();

    final res = await http.get(
      Uri.parse("${ApiConstants.baseUrl}/community/comments/$commentId/replies"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception(jsonDecode(res.body)["message"] ?? "Error");
    }
  }

  static Future<void> addReply(String commentId, String content) async {
    final token = await TokenStorage.getToken();

    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/community/comments/$commentId/replies"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"content": content}),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)["message"] ?? "Error");
    }
  }
}