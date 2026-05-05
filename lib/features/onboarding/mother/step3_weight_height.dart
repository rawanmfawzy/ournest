import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../services/onboarding_data.dart';
import 'step4_first_child.dart';
import '../../splash/views/background.dart';

class Step3WeightHeight extends StatefulWidget {
  const Step3WeightHeight({super.key});

  @override
  State<Step3WeightHeight> createState() => _Step3WeightHeightState();
}

class _Step3WeightHeightState extends State<Step3WeightHeight> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            const SplashDecorations(),

            Positioned(
              top: 276.h,
              left: 31.w,
              child: Text(
                "Please enter your pre-pregnancy",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
                  fontSize: 18.sp,
                ),
              ),
            ),

            Positioned(
              top: 300.h,
              left: 105.w,
              child: Text(
                "weight and height",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
                  fontSize: 18.sp,
                ),
              ),
            ),

            // HEIGHT
            Positioned(
              top: 376.h,
              left: 18.w,
              child: CustomTextField(
                label: "Height",
                controller: heightController,
                hintWidget: const Text("Enter your height"),
                suffix2: const Text("cm"),
                width: 342.w,
                height: 52.h,
                fontSize: 16.sp,
              ),
            ),

            // WEIGHT
            Positioned(
              top: 462.h,
              left: 18.w,
              child: CustomTextField(
                label: "Weight",
                controller: weightController,
                hintWidget: const Text("Enter your Weight"),
                suffix2: const Text("kg"),
                width: 342.w,
                height: 52.h,
                fontSize: 16.sp,
              ),
            ),

            // SAVE BUTTON
            Positioned(
              top: 600.h,
              left: 70.w,
              child: CustomButton(
                width: 240.w,
                height: 55.h,
                text: "Save",
                textStyle: AppStyles.textStyle20w700AY.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
                onPressed: () {
                  final heightText =
                  heightController.text.trim().replaceAll(',', '.');
                  final weightText =
                  weightController.text.trim().replaceAll(',', '.');


                  // 1️⃣ Empty check
                  if (heightText.isEmpty || weightText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  // 2️⃣ Parse
                  final parsedHeight = double.tryParse(heightText);
                  final parsedWeight = double.tryParse(weightText);

                  if (parsedHeight == null || parsedWeight == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Height and Weight must be numbers (e.g. 165, 60)",
                        ),
                      ),
                    );
                    return;
                  }

                  // 3️⃣ Validate
                  if (parsedHeight <= 0 || parsedWeight <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Values must be greater than 0"),
                      ),
                    );
                    return;
                  }

                  // 4️⃣ Save globally
                  OnboardingData.height = parsedHeight;
                  OnboardingData.weight = parsedWeight;

                  // 5️⃣ Navigate
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Step4FirstChild(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}