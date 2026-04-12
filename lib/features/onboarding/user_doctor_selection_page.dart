import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/features/onboarding/mother/step1_gender.dart';
import '../../core/helper/my_navgator.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../core/widgets/custom_buttom.dart';
import '../splash/views/background.dart';
import 'services/onboarding_data.dart';
class UserDoctorSelectionPage extends StatelessWidget {
  const UserDoctorSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),

          Positioned(
            top: 315.h,
            left: 142.w,
            child: SizedBox(
              child: Text(
                "Are You?",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
                  fontSize: 22.sp,
                ),

              ),
            ),
          ),

          Positioned(
            top: 358.h,
            left: 83.w,
            child: CustomButton(
              width: 209.w,
              height: 52.h,
              text: "User",
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.white,
                fontSize: 16.sp,
              ),
                onPressed: () {
                  OnboardingData.isDoctor = false;
                  OnboardingData.role = "Mother";
                  MyNavigator.goTo(
                    context,
                    const Step1Gender(),
                    type: NavigatorType.push,
                  );
                }
            ),
          ),

          Positioned(
            top: 410.h,
            left: 179.w,
            child: Text(
              "Or",
              style: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.Pinky,
                fontSize: 18.sp,
              ),
            ),
          ),
          Positioned(
            top: 435.h,
            left: 83.w,
            child: CustomButton(
              width: 209.w,
              height: 52.h,
              text: "Doctor",
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
              ),
                onPressed: () {
                  OnboardingData.isDoctor = true;
                  OnboardingData.role = "Doctor";

                }
            ),
          ),
        ],
      ),
    );
  }
}
