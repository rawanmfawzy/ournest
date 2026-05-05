import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/pass_service.dart';
import 'pass_state.dart';

class PassCubit extends Cubit<PassState> {
  PassCubit() : super(PassInitial());

  String _email = '';
  String _recoveryEmail = '';
  String _resetToken = '';

  String get email => _email;
  String get recoveryEmail => _recoveryEmail;

  Future<void> forgotPassword(String email, String recoveryEmail) async {
    emit(PassLoading());
    try {
      _email = email;
      _recoveryEmail = recoveryEmail;
      final response = await PassService.forgotPassword(email, recoveryEmail);
      emit(ForgotPasswordSuccess(response['message'] ?? 'Verification code sent'));
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  Future<void> verifyOtp(String otpCode) async {
    emit(PassLoading());
    try {
      final response = await PassService.verifyOtp(_email, otpCode);
      _resetToken = response['resetToken'] ?? '';
      emit(VerifyOtpSuccess(_resetToken));
    } catch (e) {
      emit(VerifyOtpFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String newPassword, String confirmNewPassword) async {
    emit(PassLoading());
    try {
      final response = await PassService.resetPassword(
        email: _email,
        resetToken: _resetToken,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      emit(ResetPasswordSuccess(response['message'] ?? 'Password reset successfully'));
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
