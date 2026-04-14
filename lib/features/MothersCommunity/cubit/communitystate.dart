abstract class CommunityState {}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunitySuccess extends CommunityState {
  final List posts;
  CommunitySuccess(this.posts);
}

class CommunityError extends CommunityState {
  final String message;
  CommunityError(this.message);
}