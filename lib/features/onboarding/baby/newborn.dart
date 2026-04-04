import 'package:flutter/material.dart';
import 'package:ournest/features/onboarding/baby/child_birth_date.dart';
import '../../../core/helper/my_navgator.dart';
import '../../../core/utils/appColor.dart';
import '../../../core/utils/appStyles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../splash/views/background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class newborn extends StatelessWidget {
  const newborn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),

          Positioned(
            top: 286.h,
            left: 95.w,
            child: Text(
              "Do you already have",
              textAlign: TextAlign.center,
              style: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.Pinky,
                fontSize: 18.sp,
              ),
            ),
          ),
          Positioned(
            top: 310.h,
            left: 110.w,
            child: Text(
              " a newborn baby?",
              textAlign: TextAlign.center,
              style: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.Pinky,
                fontSize: 18.sp,
              ),
            ),
          ),
          // 🔹 Button 1: Yes selection
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
                MyNavigator.goTo(
                  context,
                  const childBirthDate(),
                  type: NavigatorType.push,
                );
              },
            ),
          ),
          // 🔹 Text "Or"
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
          // 🔹 Button 2: No selection
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
                // MyNavigator.goTo(
                //   context,
                //   const Step2NotPregnant(),
                //   type: NavigatorType.push,
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}

