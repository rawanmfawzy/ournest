import 'package:flutter/material.dart';
import 'package:ournest/features/onboarding/mother/step7_gestational_age.dart';
import 'package:ournest/features/onboarding/mother/step8_estimated_conception.dart';
import '../../../core/helper/my_navgator.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../splash/views/background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../gat_pregnant/step6_last_period.dart';
import '../services/onboarding_data.dart';
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
                OnboardingData.knowledgeType = "last_menstrual";

                MyNavigator.goTo(
                  context,
                  const Step6LastPeriod(),
                  type: NavigatorType.pushReplacement,
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
                    OnboardingData.knowledgeType = "gestational";

                    MyNavigator.goTo(
                      context,
                      const Step7GestationalAge(),
                      type: NavigatorType.pushReplacement,
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
                    OnboardingData.knowledgeType = "conception";

                    MyNavigator.goTo(
                      context,
                      const Step8EstimatedConception(),
                      type: NavigatorType.pushReplacement,
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
