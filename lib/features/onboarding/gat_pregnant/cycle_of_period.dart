import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../mother/step4_first_child.dart';
import '../../splash/views/background.dart';
import '../services/onboarding_data.dart';

class CycleOfPeriod extends StatefulWidget {
  const CycleOfPeriod({super.key});

  @override
  State<CycleOfPeriod> createState() => _CycleOfPeriodState();
}

class _CycleOfPeriodState extends State<CycleOfPeriod> {
  final TextEditingController lastPeriodController = TextEditingController();
  final TextEditingController periodLengthController = TextEditingController();
  final TextEditingController cycleLengthController = TextEditingController();

  @override
  void dispose() {
    lastPeriodController.dispose();
    periodLengthController.dispose();
    cycleLengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),

          // Last period
          Positioned(
            top: 171.h,
            left: 20.w,
            child: CustomTextField(
              controller: lastPeriodController,
              label: "Your last period",
              hintWidget: const Text("29-10-2025"),
              suffix2: const Icon(Icons.calendar_month),
              width: 342.w,
              height: 52.h,
              fontSize: 16.sp,
            ),
          ),

          // Period length
          Positioned(
            top: 366.h,
            left: 17.w,
            child: CustomTextField(
              controller: periodLengthController,
              label: "Your period length",
              hintWidget: const Text("Enter your period length"),
              suffix2: const Icon(Icons.water_drop),
              width: 342.w,
              height: 52.h,
              fontSize: 16.sp,
            ),
          ),

          // Cycle length
          Positioned(
            top: 455.h,
            left: 17.w,
            child: CustomTextField(
              controller: cycleLengthController,
              label: "Your cycle length",
              hintWidget: const Text("Enter your cycle length"),
              suffix2: const Icon(Icons.loop),
              width: 342.w,
              height: 52.h,
              fontSize: 16.sp,
            ),
          ),

          // Continue button
          Positioned(
            top: 671.h,
            left: 83.w,
            child: CustomButton(
              width: 240.w,
              height: 55.h,
              text: "Continue",
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
              ),
                onPressed: () {
                  final lastPeriod = lastPeriodController.text.trim();
                  final periodLengthText = periodLengthController.text.trim();
                  final cycleLengthText = cycleLengthController.text.trim();

                  // 1️⃣ Check empty fields
                  if (lastPeriod.isEmpty ||
                      periodLengthText.isEmpty ||
                      cycleLengthText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  // 2️⃣ Parse safely
                  final periodLength = int.tryParse(periodLengthText);
                  final cycleLength = int.tryParse(cycleLengthText);

                  if (periodLength == null || cycleLength == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter valid numbers")),
                    );
                    return;
                  }

                  // 3️⃣ Validate values
                  if (periodLength <= 0 || cycleLength <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Values must be greater than 0")),
                    );
                    return;
                  }

                  if (cycleLength < periodLength) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Cycle length cannot be less than period length"),
                      ),
                    );
                    return;
                  }

                  // 4️⃣ Save data
                  OnboardingData.lastMenstrualDate = lastPeriod;
                  OnboardingData.periodLength = periodLength;
                  OnboardingData.cycleLength = cycleLength;

                  // 5️⃣ Navigate
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Step4FirstChild()),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}