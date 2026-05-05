abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoginSuccess extends UserState {
  final dynamic data;
  UserLoginSuccess(this.data);
}

class UserLoginError extends UserState {
  final String message;
  UserLoginError(this.message);
}

class UserSignupSuccess extends UserState {
  final dynamic data;
  UserSignupSuccess(this.data);
}

class UserSignupError extends UserState {
  final String message;
  UserSignupError(this.message);
}

class UserImagePicked extends UserState {}

class UserTokenRefreshed extends UserState {
  final dynamic data;
  UserTokenRefreshed(this.data);
}

class UserRefreshTokenError extends UserState {
  final String message;
  UserRefreshTokenError(this.message);
}
class UserLogoutLoading extends UserState {}

class UserLogoutSuccess extends UserState {}

class UserLogoutError extends UserState {
  final String message;
  UserLogoutError(this.message);
}