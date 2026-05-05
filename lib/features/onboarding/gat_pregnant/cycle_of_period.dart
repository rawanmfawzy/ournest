import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/app_Icons.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../mother/step4_first_child.dart';
import '../../splash/views/background.dart';
import '../services/onboarding_data.dart';
import '../../../../core/utils/app_colors.dart';
import '../services/model.dart';
import '../services/mother_services.dart';
import '../services/services.dart';
import '../../period_tracking/views/period_tracking.dart';

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
    return  GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),

          // Last period
          Positioned(
            top: 277.h,
            left: 20.w,
            child: GestureDetector(
              onTap: () async {
                DateTime now = DateTime.now();
                DateTime fiveMonthsAgo = now.subtract(const Duration(days: 150));

                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: fiveMonthsAgo,
                  lastDate: now,
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        dialogBackgroundColor: Colors.white,
                        colorScheme: ColorScheme.light(
                          primary: AppColors.Pinky,
                          onPrimary: Colors.white,
                          onSurface: Colors.black87,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.Pinky,
                          ),
                        ),
                        datePickerTheme: DatePickerThemeData(
                          backgroundColor: Colors.white,
                          headerBackgroundColor: AppColors.Pinky,
                          headerForegroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (pickedDate != null) {
                  String formattedDate =
                      "${pickedDate.day.toString().padLeft(2, '0')}-"
                      "${pickedDate.month.toString().padLeft(2, '0')}-"
                      "${pickedDate.year}";

                  setState(() {
                    lastPeriodController.text = formattedDate;
                  });
                }
              },

              // ✅ هنا مكان الـ AbsorbPointer الصح
              child: AbsorbPointer(
                child: CustomTextField(
                  controller: lastPeriodController,
                  label: "Your last period",
                  hintWidget: Text("29-10-2025"),
                  suffix2: CustomSvg(
                    path: AppIcons.calender,
                    width: 24.w,
                    height: 24.h,
                  ),
                  width: 342.w,
                  height: 52.h,
                  fontSize: 16.sp,
                ),
              ),
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
              suffix2:CustomSvg(
                path: AppIcons.blood_drops,
                width: 24.w,
                height: 24.h,
              ),
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
              suffix2:CustomSvg(
                path: AppIcons.cycle,
                width: 24.w,
                height: 24.h,
              ),
              width: 342.w,
              height: 52.h,
              fontSize: 16.sp,
            ),
          ),

          // Continue button
          Positioned(
            top: 671.h,
            left: 70.w,
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

                  // 5️⃣ Submit and Navigate
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
                      lastMenstrualDate: lastPeriod,
                      dateOfBirth: DateTime.now().toIso8601String().split("T").first,
                    );

                     MotherService.createProfile(weight: 0, height: 0);
                     OnboardingService.submit(onboarding);

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
                }
            ),
          ),
        ],
      ),
        ),
    );
  }
}