import 'package:flutter/material.dart';
import 'package:ournest/core/utils/appIcons.dart';
import 'package:ournest/features/onboarding/mother/step7_gestational_age.dart';
import 'package:ournest/features/onboarding/mother/step8_estimated_conception.dart';
import '../../../core/helper/my_navgator.dart';
import '../../../core/utils/appColor.dart';
import '../../../core/utils/appStyles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../splash/views/background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../gat_pregnant/step6_last_period.dart';
class Step5Knowledge extends StatelessWidget {
  const Step5Knowledge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),

          Positioned(
            top: 276.h,
            left: 95.w,
            child: Text(
              "Which of these do you",
              textAlign: TextAlign.center,
              style: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.Pinky,
                fontSize: 18.sp,
              ),
            ),
          ),
          Positioned(
            top: 300.h,
            left: 165.w,
            child: Text(
              "Know?",
              textAlign: TextAlign.center,
              style: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.Pinky,
                fontSize: 18.sp,
              ),
            ),
          ),

          Positioned(
            top: 350.h,
            left: (MediaQuery.of(context).size.width - 294.w) / 2,
            child: Column(
              children: [
                CustomButton(
                  text: "Date of Last menstruation",
                  onPressed: () {
                    MyNavigator.goTo(
                      context,
                      const Step6LastPeriod(),
                      type: NavigatorType.push,
                    );
                  },
                  textStyle: AppStyles.textStyle20w700AY.copyWith(
                    color: AppColors.white,
                    fontSize: 14.sp,
                  ),
                  width: 294.w,
                  height: 52.h,
                  suffixAsset: AppIcons.blood,
                ),

                SizedBox(height: 16.h),

                CustomButton(
                  text: "Number of weeks of pregnant",
                  onPressed: () {
                    MyNavigator.goTo(
                      context,
                      const Step7GestationalAge(),
                      type: NavigatorType.push,
                    );
                  },
                  textStyle: AppStyles.textStyle20w700AY.copyWith(
                    color: AppColors.white,
                    fontSize: 14.sp,
                  ),
                  width: 294.w,
                  height: 52.h,
                  suffixAsset: AppIcons.pregnant_woman2,

                ),
                SizedBox(height: 16.h),

                CustomButton(
                  text: "Estimated due date",
                  onPressed: () {
                    MyNavigator.goTo(
                      context,
                      const Step8EstimatedConception(),
                      type: NavigatorType.push,
                    );
                  },
                  textStyle: AppStyles.textStyle20w700AY.copyWith(
                    color: AppColors.white,
                    fontSize: 14.sp,
                  ),
                  width: 294.w,
                  height: 52.h,
                  suffixAsset: AppIcons.mdi_mother_nurse,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
