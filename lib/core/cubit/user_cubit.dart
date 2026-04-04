import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../../features/auth/services/login_service.dart';
import '../../features/auth/services/signup_service.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  @override
  Future<void> close() {
    signInEmail.dispose();
    signInPassword.dispose();
    signUpName.dispose();
    signUpPhoneNumber.dispose();
    signUpPassword.dispose();
    confirmPassword.dispose();
    return super.close();
  }

  /// Sign In Controllers
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();

  /// Sign Up Controllers
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpPhoneNumber = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  /// Remember Me
  bool rememberMe = false;

  /// Profile Image
  XFile? profilePic;

  /// Pick Profile Image
  Future<void> pickProfilePic() async {
    final ImagePicker picker = ImagePicker();
    profilePic = await picker.pickImage(source: ImageSource.gallery);
    emit(UserImagePicked());
  }

  /// LOGIN FUNCTION
  Future<void> login() async {
    try {
      emit(UserLoading());

      final result = await LoginService.login(
        email: signInEmail.text.trim(),
        password: signInPassword.text.trim(),
      );

      /// Save token if login successful
      if (result.containsKey("token")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", result["token"]);

        if (rememberMe) {
          await prefs.setString("email", signInEmail.text.trim());
        }
      }

      emit(UserLoginSuccess(result));
    } catch (e) {
      emit(UserLoginError(e.toString()));
    }
  }

  /// SIGNUP FUNCTION
  Future<void> signup() async {
    try {
      emit(UserLoading());

      final result = await SignupService.signup(
        email: signUpPhoneNumber.text.trim(),
        password: signUpPassword.text.trim(),
        confirmPassword: confirmPassword.text.trim(),
        name: signUpName.text.trim(),
      );

      if (result.containsKey("token")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString("token", result["token"]);

        if (result.containsKey("refreshToken")) {
          await prefs.setString("refreshToken", result["refreshToken"]);
        }
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

      Map<String, dynamic> result;

      if (provider == "google") {
        result = await LoginService.loginWithGoogle();
      } else if (provider == "facebook") {
        result = await LoginService.loginWithFacebook();
      } else {
        throw Exception("Unknown social provider");
      }

      if (result.containsKey("token")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString("token", result["token"]);

        if (result.containsKey("refreshToken")) {
          await prefs.setString("refreshToken", result["refreshToken"]);
        }

        if (rememberMe) {
          await prefs.setString("email", signInEmail.text.trim());
        }
      }

      emit(UserLoginSuccess(result));
    } catch (e) {
      emit(UserLoginError(e.toString()));
    }
  }

  /// REFRESH TOKEN
  Future<void> refreshToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? refreshToken = prefs.getString("refreshToken");

      if (refreshToken == null) return;

      final newToken = await LoginService.refreshToken(refreshToken);

      if (newToken.containsKey("token")) {
        await prefs.setString("token", newToken["token"]);
      }

      emit(UserTokenRefreshed(newToken));
    } catch (e) {
      emit(UserRefreshTokenError(e.toString()));
    }
  }
}