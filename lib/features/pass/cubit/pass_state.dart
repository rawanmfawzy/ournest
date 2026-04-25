abstract class PassState {}

class PassInitial extends PassState {}

class PassLoading extends PassState {}

class ForgotPasswordSuccess extends PassState {
  final String message;
  ForgotPasswordSuccess(this.message);
}

class ForgotPasswordFailure extends PassState {
  final String error;
  ForgotPasswordFailure(this.error);
}

class VerifyOtpSuccess extends PassState {
  final String resetToken;
  VerifyOtpSuccess(this.resetToken);
}

class VerifyOtpFailure extends PassState {
  final String error;
  VerifyOtpFailure(this.error);
}

class ResetPasswordSuccess extends PassState {
  final String message;
  ResetPasswordSuccess(this.message);
}

class ResetPasswordFailure extends PassState {
  final String error;
  ResetPasswordFailure(this.error);
}
