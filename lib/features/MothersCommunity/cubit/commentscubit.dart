import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/communityservice.dart';
import 'communitystate.dart';

class CommentsCubit extends Cubit<CommunityState> {
  CommentsCubit() : super(CommunityInitial());

  List comments = [];
  Map<String, List> replies = {};

  Future<void> getComments(String postId) async {
    try {
      emit(CommunityLoading());

      final data = await CommunityService.getComments(postId);

      comments = data.map((c) {
        return {
          ...c,
          "createdAt": DateTime.now().toIso8601String(),
        };
      }).toList();

      emit(CommentsSuccess(List.from(comments)));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> addComment(String postId, String content) async {
    try {
      await CommunityService.addComment(postId, content);
      await getComments(postId);
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> getReplies(String commentId) async {
    try {
      final data = await CommunityService.getReplies(commentId);

      replies[commentId] = data.map((r) {
        return {
          ...r,
          "createdAt": r["createdAt"] ?? DateTime.now().toIso8601String(),
        };
      }).toList();

      emit(CommentsSuccess(List.from(comments)));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> addReply(String commentId, String content) async {
    try {
      await CommunityService.addReply(commentId, content);

      await getReplies(commentId);
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }
}