import 'package:flutter/material.dart';
import '../../../core/helper/my_navgator.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../splash/views/background.dart';
import '../services/onboarding_data.dart';
import 'Step2_Not_Pregnant.dart';
import 'step3_weight_height.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Step2Pregnant extends StatelessWidget {
  const Step2Pregnant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),
          Positioned(
            top: 312.h,
            left: 92.w,
            child: SizedBox(
              child: Text(
                "Are You Pregnant?",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
                  fontSize: 20.sp,
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
              text: "Yes",
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.white,
                fontSize: 16.sp,
              ),
                onPressed: () {
                  OnboardingData.isPregnant = true;

                  MyNavigator.goTo(
                    context,
                    const Step3WeightHeight(),
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
              text: "No",
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
              ),
                onPressed: () {
                  OnboardingData.isPregnant = false;

                  MyNavigator.goTo(
                    context,
                    const Step2NotPregnant(),
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

