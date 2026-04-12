abstract class UserState {}

/// الحالة الابتدائية
class UserInitial extends UserState {}

/// حالة التحميل أثناء العمليات (Login / Signup / Social login / Refresh token)
class UserLoading extends UserState {}

/// حالة نجاح اللوجين
class UserLoginSuccess extends UserState {
  final dynamic data;
  UserLoginSuccess(this.data);
}

/// حالة فشل اللوجين
class UserLoginError extends UserState {
  final String message;
  UserLoginError(this.message);
}

/// حالة نجاح التسجيل (Signup)
class UserSignupSuccess extends UserState {
  final dynamic data;
  UserSignupSuccess(this.data);
}

/// حالة فشل التسجيل
class UserSignupError extends UserState {
  final String message;
  UserSignupError(this.message);
}

/// حالة اختيار صورة البروفايل
class UserImagePicked extends UserState {}

/// حالة نجاح تجديد التوكن
class UserTokenRefreshed extends UserState {
  final dynamic data;
  UserTokenRefreshed(this.data);
}

/// حالة فشل تجديد التوكن
class UserRefreshTokenError extends UserState {
  final String message;
  UserRefreshTokenError(this.message);
}
