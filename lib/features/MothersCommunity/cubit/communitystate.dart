abstract class CommunityState {}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityError extends CommunityState {
  final String message;
  CommunityError(this.message);
}

/// POSTS
class PostsSuccess extends CommunityState {
  final List posts;
  PostsSuccess(this.posts);
}

/// COMMENTS
class CommentsSuccess extends CommunityState {
  final List comments;
  CommentsSuccess(this.comments);
}