import 'package:flutter/material.dart';
import '../../../core/helper/my_navgator.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../services/onboarding_data.dart';
import 'step5_knowledge.dart';
import '../../splash/views/background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Step4FirstChild extends StatelessWidget {
  const Step4FirstChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),
          Positioned(
            top: 310.h,
            left: 80.w,
            child: SizedBox(
              child: Text(
                "Is this your first child?",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
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
                  OnboardingData.isFirstChild = true;

                  MyNavigator.goTo(
                    context,
                    const Step5Knowledge(),
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
                  OnboardingData.isFirstChild = false;

                  MyNavigator.goTo(
                    context,
                    const Step5Knowledge(),
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
