import 'package:flutter/material.dart';
import 'package:ournest/features/onboarding/baby/child_birth_date.dart';
import '../../../core/helper/my_navgator.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../splash/views/background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/onboarding_data.dart';
import '../services/model.dart';
import '../services/mother_services.dart';
import '../services/services.dart';
import '../../period_tracking/views/period_tracking.dart';
class Newborn extends StatelessWidget {
  const Newborn({super.key});

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
                  const ChildBirthDate(),
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
              onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(child: CircularProgressIndicator(color: AppColors.Pinky)),
                  );

                  try {
                    final onboarding = OnboardingRequest(
                      role: OnboardingData.role,
                      isPregnant: false,
                      height: 0,
                      weight: 0,
                      isFirstChild: false,
                      knowledgeType: "",
                      dateOfBirth: DateTime.now().toIso8601String().split("T").first,
                    );

                    await MotherService.createProfile(weight: 0, height: 0);
                    await OnboardingService.submit(onboarding);

                    if (context.mounted) {
                      Navigator.pop(context); // hide loading
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const Periodtracking()),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      Navigator.pop(context); // hide loading
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
                    }
                  }
              },
            ),
          ),
        ],
      ),
    );
  }
}

