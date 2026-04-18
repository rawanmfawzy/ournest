import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/cubit/user_cubit.dart';
import '../../../core/cubit/user_state.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/utils/app_Icons.dart';
import '../../../core/utils/app_Styles.dart';
import '../../../core/widgets/buttom_navigation_bar_mother.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../onboarding/welcome_services_page.dart';
import '../../pass/views/forget_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool hidePassword = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ButtomNavigationBarmother(),
              ),
            );
          }

          if (state is UserLoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 40.h),

                Text(
                  "Welcome Back!!",
                  style: AppStyles.textStyle14w400hints.copyWith(
                    color: AppColors.Pinky,
                    fontSize: 15.sp,
                  ),
                ),

                Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFB34962),
                  ),
                ),

                SizedBox(height: 80.h),

                /// USERNAME
                CustomTextField(
                  label: "User Name",
                  controller: cubit.signInUsername,
                  width: double.infinity,
                  height: 48.h,
                  suffix1: const Icon(
                    Icons.person_outline,
                    color: Color(0xFFB34962),
                  ),
                ),

                SizedBox(height: 20.h),

                /// PASSWORD
                CustomTextField(
                  label: "Password",
                  controller: cubit.signInPassword,
                  width: double.infinity,
                  height: 48.h,
                  obscureText: hidePassword,
                  suffix1: const Icon(Icons.lock_outline, color: Color(0xFFB34962)),
                  suffix2: IconButton(
                    icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility, color: Color(0xFFB34962)),
                    onPressed: () => setState(() => hidePassword = !hidePassword),
                  ),
                ),
                SizedBox(height: 12.h,),

                /// REMEMBER + FORGET
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rememberMe = !rememberMe;
                              cubit.rememberMe = rememberMe;
                            });
                          },
                          child: Icon(
                            rememberMe
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            size: 20.sp,
                            color: const Color(0xFFB34962),
                          ),
                        ),

                        SizedBox(width: 6.w),

                        Text(
                          "Remember me",
                          style: AppStyles.textStyle14w400hints.copyWith(
                            color: AppColors.Pinky,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgetPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Forget password ?",
                        style: AppStyles.textStyle14w400hints.copyWith(
                          color: AppColors.Pinky,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 62.h),

                /// LOGIN BUTTON
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.Pinky,
                          ),
                        ),
                      );
                    }
                    return CustomButton(
                      text: "Log In",
                      onPressed: () {
                        context.read<UserCubit>().login();
                      },
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      width: double.infinity,
                      height: 48.h,
                      backgroundColor: const Color(0xFFB34962),
                      borderRadius: 6.r,
                    );
                  },
                ),

                SizedBox(height: 30.h),

                /// OR DIVIDER
                Row(
                  children: [

                    const Expanded(
                      child: Divider(color: Color(0xFFB34962)),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Text(
                        "or",
                        style: TextStyle(
                          color: const Color(0xFFB34962),
                          fontSize: 13.sp,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Divider(color: Color(0xFFB34962)),
                    ),
                  ],
                ),

                SizedBox(height: 25.h),

                /// GOOGLE
                _socialButton(
                  logo: CustomSvg(
                    height: 24.h,
                    width: 24.w,
                    path: AppIcons.icons_google,
                  ),
                  text: "Sign In with Google",
                  onTap: () {
                    context.read<UserCubit>().socialLogin("google");
                  },
                ),
                SizedBox(height: 25.h),
                _socialButton(
                  logo: CustomSvg(
                    height: 24.h,
                    width: 24.w,
                    path: AppIcons.facebook_circle,
                  ),
                  text: "Sign In with Facebook",
                  onTap: () {
                    context.read<UserCubit>().socialLogin("facebook");
                  },
                ),

                SizedBox(height: 25.h),

                /// SIGN UP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      "Don’t have an account?",
                      style: TextStyle(color: Colors.black54),
                    ),

                    SizedBox(width: 5.w),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WelcomeServicesPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Color(0xFFB34962),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 40.h),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

  /// SOCIAL BUTTON
  Widget _socialButton({
    required Widget logo,
    required String text,
    required VoidCallback onTap, // ✅ اضفنا onTap
  }) {
    return GestureDetector( // ✅ Wrap with GestureDetector
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFB34962)),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              logo,
              SizedBox(width: 12.w),
              Text(
                text,
                style: TextStyle(
                  color: const Color(0xFFB34962),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
