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

      comments = await CommunityService.getComments(postId);

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
    final data = await CommunityService.getReplies(commentId);
    replies[commentId] = data;

    emit(CommentsSuccess(List.from(comments)));
  }

  Future<void> addReply(String commentId, String content) async {
    await CommunityService.addReply(commentId, content);
    await getReplies(commentId);
  }

  void refresh() {
    emit(CommentsSuccess(List.from(comments)));
  }
}