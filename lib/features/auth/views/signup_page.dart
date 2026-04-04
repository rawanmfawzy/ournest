import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/cubit/user_cubit.dart';
import '../../../core/cubit/user_state.dart';
import '../../../core/utils/appColor.dart';
import '../../../core/utils/appIcons.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../onboarding/welcome_services_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSignupSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const WelcomeServicesPage()),
            );
          } else if (state is UserSignupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Text(
                  "Welcome to Our App!",
                  style: TextStyle(fontSize: 14.sp, color: Color(0xFFB34962)),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFB34962),
                  ),
                ),
                SizedBox(height: 40.h),

                // USER NAME
                CustomTextField(
                  label: "User Name",
                  controller: cubit.signUpName,
                  suffix1: const Icon(Icons.person_outline, color: Color(0xFFB34962)),
                ),
                SizedBox(height: 18.h),

                // PHONE NUMBER
                CustomTextField(
                  label: "Phone Number",
                  controller: cubit.signUpPhoneNumber,
                  suffix1: const Icon(Icons.phone_outlined, color: Color(0xFFB34962)),
                ),
                SizedBox(height: 18.h),

                // PASSWORD
                CustomTextField(
                  label: "Password",
                  controller: cubit.signUpPassword,
                  obscureText: hidePassword,
                  suffix1: const Icon(Icons.lock_outline, color: Color(0xFFB34962)),
                  suffix2: IconButton(
                    icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility, color: Color(0xFFB34962)),
                    onPressed: () => setState(() => hidePassword = !hidePassword),
                  ),
                ),
                SizedBox(height: 18.h),

                // CONFIRM PASSWORD
                CustomTextField(
                  label: "Confirm Password",
                  controller: cubit.confirmPassword,
                  obscureText: hideConfirmPassword,
                  suffix1: const Icon(Icons.lock_outline, color: Color(0xFFB34962)),
                  suffix2: IconButton(
                    icon: Icon(hideConfirmPassword ? Icons.visibility_off : Icons.visibility, color: Color(0xFFB34962)),
                    onPressed: () => setState(() => hideConfirmPassword = !hideConfirmPassword),
                  ),
                ),
                SizedBox(height: 30.h),

                // SIGN UP BUTTON
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(color: AppColors.Pinky, strokeWidth: 3),
                        ),
                      );
                    }
                    return CustomButton(
                      text: "Sign Up",
                      width: double.infinity,
                      onPressed: () {
                        final name = cubit.signUpName.text.trim();
                        final phone = cubit.signUpPhoneNumber.text.trim();
                        final password = cubit.signUpPassword.text.trim();
                        final confirmPassword = cubit.confirmPassword.text.trim();

                        if (name.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill all fields")),
                          );
                          return;
                        }

                        if (!RegExp(r'^\d{11}$').hasMatch(phone)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please enter a valid phone number")),
                          );
                          return;
                        }

                        if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}[\]:;<>,.?~\\/-]).{6,}$').hasMatch(password)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Password must be at least 6 characters and include a number and a special character")),
                          );
                          return;
                        }

                        if (password != confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Passwords do not match")),
                          );
                          return;
                        }

                        // Call Cubit signup
                        cubit.signup();
                      },
                      textStyle: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
                    );
                  },
                ),
                SizedBox(height: 25.h),

                // OR DIVIDER
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: Text("or", style: TextStyle(color: Color(0xFFB34962), fontSize: 14.sp, fontWeight: FontWeight.w500)),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                SizedBox(height: 25.h),

                // SOCIAL ICONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => cubit.socialLogin("facebook"),
                      child: CustomSvg(path: AppIcons.face_icon, width: 26.w, height: 26.h),
                    ),
                    SizedBox(width: 35.w),
                    GestureDetector(
                      onTap: () => cubit.socialLogin("google"),
                      child: CustomSvg(path: AppIcons.icons_google, width: 24.w, height: 24.h),
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