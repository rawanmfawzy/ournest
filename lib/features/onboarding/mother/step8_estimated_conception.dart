import 'package:flutter/material.dart';
import 'package:ournest/features/onboarding/mother/step9_birth_date.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/my_navgator.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../splash/views/background.dart';
import '../services/onboarding_data.dart';


class Step8EstimatedConception extends StatefulWidget {
  const Step8EstimatedConception({super.key});

  @override
  State<Step8EstimatedConception> createState() =>
      _Step8EstimatedConceptionState();
}

class _Step8EstimatedConceptionState extends State<Step8EstimatedConception> {
  final List<int> days = List.generate(31, (i) => i + 1);

  final List<String> months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  late final int currentYear = DateTime.now().year;
  late final List<int> years = [currentYear - 1, currentYear];

  final dayController = FixedExtentScrollController(initialItem: 10);
  final monthController = FixedExtentScrollController(initialItem: 5);
  final yearController = FixedExtentScrollController(initialItem: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),

          Positioned(
            top: 276.h,
            left: 55.w,
            child: SizedBox(
              child: Text(
                "Select your estimated date of",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
          Positioned(
            top: 300.h,
            left: 130.w,
            child: SizedBox(
              child: Text(
                "conception.",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),


          Positioned(
            top: 347.h,
            left: 16.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 35.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFA5B4).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),

                SizedBox(
                  height: 180.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPicker(
                        days.map((e) => e.toString()).toList(),
                        dayController,
                        60,
                      ),
                      _buildPicker(months, monthController, 120),
                      _buildPicker(
                        years.map((e) => e.toString()).toList(),
                        yearController,
                        80,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 671.h,
            left: 41.w,
            child: CustomButton(
              text: "Continue",
              width: 294.w,
              height: 52.h,
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
              ),
                onPressed: () {
                  try {
                    final dayIndex = dayController.selectedItem;
                    final monthIndex = monthController.selectedItem;
                    final yearIndex = yearController.selectedItem;

                    // 1️⃣ تأكد إن فيه اختيار منطقي
                    if (days.isEmpty || years.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a valid date")),
                      );
                      return;
                    }

                    final day = int.parse(days[dayIndex].toString());
                    final month = monthIndex + 1;
                    final year = years[yearIndex];

                    final date = DateTime(year, month, day);

                    // 2️⃣ منع أي تاريخ غير منطقي (احتياطي)
                    if (date.isAfter(DateTime.now())) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Date cannot be in the future")),
                      );
                      return;
                    }

                    // 3️⃣ حفظ البيانات
                    OnboardingData.conceptionDate =
                        date.toIso8601String().split("T").first;

                    // 4️⃣ الانتقال
                    MyNavigator.goTo(
                      context,
                      const Step9BirthDate(),
                      type: NavigatorType.pushReplacement,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a valid date")),
                    );
                  }
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPicker(
      List<String> items,
      FixedExtentScrollController controller,
      double width,
      ) {
    return SizedBox(
      width: width.w,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 28.h,
        physics: const FixedExtentScrollPhysics(),
        perspective: 0.001,
        overAndUnderCenterOpacity: 0.3,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (_, index) {
            return Center(
              child: Text(
                items[index],
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
                  fontSize: 16.sp,
                ),
              ),
            );
          },
          childCount: items.length,
        ),
      ),
    );
  }
}
