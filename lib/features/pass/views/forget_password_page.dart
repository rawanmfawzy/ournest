import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pass_cubit.dart';
import '../cubit/pass_state.dart';
import 'verify_code_page.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController recoveryEmailController = TextEditingController();

    return  GestureDetector(
        onTap: ()
        {
          FocusScope.of(context).unfocus();
        },
        child:Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFFB34962),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 58,
        title:  Text(
          "Forget Password",
          style: TextStyle(
            color: Color(0xFFB34962),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE5E5E5),
          ),
        ),
      ),

      body: BlocConsumer<PassCubit, PassState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const VerifyCodePage(),
              ),
            );
          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.h, vertical: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                 SizedBox(height: 80.h),

                CustomSvg(
                  path: AppIcons.heart_lock_bold,
                  width: 80.w,
                  height: 80.h,
                ),

                 SizedBox(height: 22.h),

                 Text(
                  "Please Enter Your Email To\nReceive a Verification Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFB34962),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                 SizedBox(height: 90.h),

                /// 🔹 Custom TextField for Registered Email
                CustomTextField(
                  label: "Enter Your Registered Email",
                  controller: emailController,
                  width: double.infinity,
                  height: 55.h,
                  suffix1: const Icon(
                    Icons.email,
                    color: AppColors.Pinky,
                  ),
                ),

                 SizedBox(height: 20.h),

                /// 🔹 Custom TextField for Recovery Gmail
                CustomTextField(
                  label: "Enter Your Recovery Gmail",
                  controller: recoveryEmailController,
                  width: double.infinity,
                  height: 55.h,
                  suffix1: const Icon(
                    Icons.email,
                    color: AppColors.Pinky,
                  ),
                ),

                 SizedBox(height: 40.h),

                /// 🔹 Custom Button
                state is PassLoading
                    ? CircularProgressIndicator(color: AppColors.Pinky)
                    : CustomButton(
                  text: "Send",
                  width: double.infinity,
                  height: 50.h,
                  textStyle: AppStyles.textStyle20w700AY.copyWith(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                  onPressed: () {
                    final email = emailController.text.trim();
                    final recoveryEmail = recoveryEmailController.text.trim();
                    if (email.isNotEmpty && recoveryEmail.isNotEmpty) {
                      context.read<PassCubit>().forgotPassword(email, recoveryEmail);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter both emails")));
                    }
                  },
                ),

                 SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      );
      },
      ),
        ),
    );
  }
}
