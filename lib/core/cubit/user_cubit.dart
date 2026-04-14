import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ournest/core/cubit/token_storage_helper.dart';
import '../../features/auth/services/login_service.dart';
import '../../features/auth/services/signup_service.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final TextEditingController signInEmail = TextEditingController();
  final TextEditingController signInPassword = TextEditingController();

  final TextEditingController signUpEmail = TextEditingController();
  final TextEditingController signUpPhoneNumber = TextEditingController();
  final TextEditingController signUpPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  bool rememberMe = false;
  XFile? profilePic;

  /// LOGIN
  Future<void> login() async {
    if (signInEmail.text.isEmpty || signInPassword.text.isEmpty) {
      emit(UserLoginError("Please fill all fields"));
      return;
    }

    try {
      emit(UserLoading());

      final result = await LoginService.login(
        email: signInEmail.text.trim(),
        password: signInPassword.text.trim(),
      );

      await TokenStorage.saveToken(result["token"]);

      if (result["refreshToken"] != null) {
        await TokenStorage.saveRefreshToken(result["refreshToken"]);
      }

      emit(UserLoginSuccess(result));
    } catch (e) {
      emit(UserLoginError(e.toString()));
    }
  }

  /// SIGNUP
  Future<void> signup() async {
    try {
      emit(UserLoading());

      final result = await SignupService.signup(
        email: signUpEmail.text.trim(),
        phone: signUpPhoneNumber.text.trim(),
        password: signUpPassword.text.trim(),
        confirmPassword: confirmPassword.text.trim(),
      );

      if (result["token"] != null) {
        await TokenStorage.saveToken(result["token"]);
      }

      if (result["refreshToken"] != null) {
        await TokenStorage.saveRefreshToken(result["refreshToken"]);
      }

      emit(UserSignupSuccess(result));
    } catch (e) {
      emit(UserSignupError(e.toString()));
    }
  }

  /// SOCIAL LOGIN
  Future<void> socialLogin(String provider) async {
    try {
      emit(UserLoading());

      final result = provider == "google"
          ? await LoginService.loginWithGoogle()
          : await LoginService.loginWithFacebook();

      if (result["success"] == true) {
        await TokenStorage.saveToken(result["token"]);

        if (result["refreshToken"] != null) {
          await TokenStorage.saveRefreshToken(result["refreshToken"]);
        }

        emit(UserLoginSuccess(result));
      } else {
        emit(UserLoginError(result["error"] ?? "Social login failed"));
      }
    } catch (e) {
      emit(UserLoginError(e.toString()));
    }
  }
  ///user logout
  Future<void> logout() async {
    emit(UserLogoutLoading());

    await TokenStorage.clear(); // 👈 أهم خطوة

    emit(UserLogoutSuccess());
  }

  /// REFRESH TOKEN
  Future<void> refreshToken() async {
    try {
      final token = await TokenStorage.getToken();
      final refresh = await TokenStorage.getRefreshToken();

      if (token == null || refresh == null) return;

      final result = await LoginService.refreshToken(token, refresh);

      await TokenStorage.saveToken(result["token"]);

      if (result["refreshToken"] != null) {
        await TokenStorage.saveRefreshToken(result["refreshToken"]);
      }

      emit(UserTokenRefreshed(result));
    } catch (e) {
      emit(UserRefreshTokenError(e.toString()));
    }
  }

  /// IMAGE PICKER
  Future<void> pickProfilePic() async {
    final picker = ImagePicker();
    profilePic = await picker.pickImage(source: ImageSource.gallery);
    emit(UserImagePicked());
  }

  @override
  Future<void> close() {
    signInEmail.dispose();
    signInPassword.dispose();
    signUpEmail.dispose();
    signUpPhoneNumber.dispose();
    signUpPassword.dispose();
    confirmPassword.dispose();
    return super.close();
  }
}