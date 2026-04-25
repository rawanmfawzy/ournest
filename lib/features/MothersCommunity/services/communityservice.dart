import '../../../core/cubit/dio_interceptor.dart';

class CommunityService {
  static Future<List<dynamic>> getPosts() async {
    final response = await DioClient.dio.get("/community/posts");
    return response.data;
  }

  static Future<Map<String, dynamic>> createPost({
    required String content,
    required String category,
    String? imageUrl,
  }) async {
    final response = await DioClient.dio.post(
      "/community/posts",
      data: {
        "content": content,
        "category": category,
        "imageUrl": imageUrl,
      },
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> toggleLike(String postId) async {
    final response = await DioClient.dio.post("/community/posts/$postId/like");
    return response.data;
  }

  static Future<void> addComment(String postId, String content) async {
    await DioClient.dio.post(
      "/community/posts/$postId/comments",
      data: {"content": content},
    );
  }

  static Future<List<dynamic>> getComments(String postId) async {
    final response = await DioClient.dio.get("/community/posts/$postId/comments");
    return response.data;
  }

  static Future<List<dynamic>> getReplies(String commentId) async {
    final response = await DioClient.dio.get("/community/comments/$commentId/replies");
    return response.data;
  }

  static Future<void> addReply(String commentId, String content) async {
    await DioClient.dio.post(
      "/community/comments/$commentId/replies",
      data: {"content": content},
    );
  }

  static Future<void> deletePost(String postId) async {
    await DioClient.dio.delete("/community/posts/$postId");
  }
}