import 'package:flutter/material.dart';
import '../../../core/helper/my_navgator.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../splash/views/background.dart';
import '../gat_pregnant/cycle_of_period.dart';
import '../baby/newborn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/onboarding_data.dart';


class Step2NotPregnant extends StatelessWidget {
  const Step2NotPregnant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),

          Positioned(
            top: 286.h,
            left: 98.w,
            child: SizedBox(
              child: Text(
                "Do you want to get",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
          Positioned(
            top: 310.h,
            left: 135.w,
            child: SizedBox(
              child: Text(
                "pregnant?",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
                  fontSize: 18.sp,
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
                  OnboardingData.wantsPregnancy = true;

                  MyNavigator.goTo(
                    context,
                    const CycleOfPeriod(),
                    type: NavigatorType.pushReplacement,
                  );
                }
            ),
          ),

          Positioned(
            top: 400.h,
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
                  OnboardingData.wantsPregnancy = false;

                  MyNavigator.goTo(
                    context,
                    const Newborn(),
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

