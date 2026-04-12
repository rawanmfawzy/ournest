import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/features/onboarding/baby/baby_weight.dart';
import '../../../core/helper/my_navgator.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../splash/views/background.dart';

class BabyGender extends StatelessWidget {
  const BabyGender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),
          Positioned(
            top: 286.h,
            left: 100.w,
            child: Text(
              "What is the baby’s",
              textAlign: TextAlign.center,
              style: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.Pinky,
                fontSize: 18.sp,
              ),
            ),
          ),
          Positioned(
            top: 310.h,
            left: 150.w,
            child: Text(
              "gender?",
              textAlign: TextAlign.center,
              style: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.Pinky,
                fontSize: 18.sp,
              ),
            ),
          ),

          Positioned(
            top: 358.h,
            left: 83.w,
            child: CustomButton(
              width: 209.w,
              height: 52.h,
              text: "Girl",
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.white,
                fontSize: 16.sp,
              ),
              onPressed: () {
                MyNavigator.goTo(
                  context,
                  const BabyWeight(),
                  type: NavigatorType.push,
                );
              },
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
              text: "Boy",
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              onPressed: () {
                MyNavigator.goTo(
                  context,
                  const BabyWeight(),
                  type: NavigatorType.push,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
