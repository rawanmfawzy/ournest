import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/communityservice.dart';
import 'communitystate.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(CommunityInitial());

  List posts = [];

  // ================= POSTS =================
  Future<void> getPosts() async {
    try {
      emit(CommunityLoading());

      posts = await CommunityService.getPosts();

      emit(CommunitySuccess(posts));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> createPost({
    required String content,
    String? imageUrl,
    required String category,
  }) async {
    try {
      emit(CommunityLoading());

      await CommunityService.createPost(
        content: content,
        imageUrl: imageUrl,
        category: category,
      );

      await getPosts();
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> likePost(String postId) async {
    try {
      final response = await CommunityService.toggleLike(postId);

      posts = posts.map((post) {
        final p = Map<String, dynamic>.from(post);

        if (p["id"] == postId) {
          p["liked"] = response["liked"];
          p["likesCount"] = response["likesCount"];
        }

        return p;
      }).toList();

      emit(CommunitySuccess(posts));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> addComment(String postId, String content) async {
    try {
      await CommunityService.addComment(postId, content);

      await getPosts();
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> addReply(String commentId, String content) async {
    try {
      await CommunityService.addReply(commentId, content);

      await getPosts();
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }
}