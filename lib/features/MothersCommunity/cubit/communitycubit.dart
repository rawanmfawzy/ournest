import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/communityservice.dart';
import 'communitystate.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(CommunityInitial());

  List posts = [];

  Future<void> getPosts() async {
    try {
      emit(CommunityLoading());

      posts = await CommunityService.getPosts();

      emit(PostsSuccess(posts));
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
      final res = await CommunityService.toggleLike(postId);

      posts = posts.map((post) {
        final p = Map<String, dynamic>.from(post);

        if (p["id"] == postId) {
          p["likesCount"] = res["likesCount"];
          p["isLikedByCurrentUser"] = res["liked"];
        }

        return p;
      }).toList();

      emit(PostsSuccess(posts));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }
  Future<void> deletePost(String postId) async {
    try {
      await CommunityService.deletePost(postId);
      await getPosts();
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }
}