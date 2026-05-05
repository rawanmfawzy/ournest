import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/features/onboarding/mother/step9_birth_date.dart';
import '../../../core/helper/my_navgator.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../services/onboarding_data.dart';
import 'step2_pregnant.dart';
import '../../splash/views/background.dart';
import '../services/model.dart';
import '../services/services.dart';
import '../services/father_service.dart';
import '../../auth/services/login_service.dart';
import '../../../core/cubit/token_storage_helper.dart';
import '../../home/home_router.dart';

class Step1Gender extends StatelessWidget {
  const Step1Gender({super.key});

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
              text: "Mother",
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.white,
                fontSize: 16.sp,
              ),
                onPressed: () {
                  OnboardingData.role = "Mother";

                  MyNavigator.goTo(
                    context,
                    const Step2Pregnant(),
                    type: NavigatorType.pushReplacement,
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
              text: "Father",
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
              ),
                onPressed: () {
                  OnboardingData.role = "Father";
                  MyNavigator.goTo(
                    context,
                    const Step9BirthDate(),
                    type: NavigatorType.pushReplacement,
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
