import 'package:flutter/material.dart';
import 'package:ournest/features/onboarding/mother/step8_estimated_conception.dart';
import '../../../core/helper/my_navgator.dart';
import '../../../core/utils/appColor.dart';
import '../../../core/utils/appStyles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../splash/views/background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Step7GestationalAge extends StatefulWidget {
  const Step7GestationalAge({super.key});

  @override
  State<Step7GestationalAge> createState() => _Step7GestationalAgeState();
}

class _Step7GestationalAgeState extends State<Step7GestationalAge> {
  final List<int> weeks = List.generate(43, (i) => i);
  final List<int> days = List.generate(7, (i) => i);

  FixedExtentScrollController weekController =
  FixedExtentScrollController(initialItem: 10);

  FixedExtentScrollController dayController =
  FixedExtentScrollController(initialItem: 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),

          // TITLE
          Positioned(
            top: 266.h,
            left: 45.w,
            child: Text(
              "Select your gestational age.",
              style: AppStyles.textStyle20w700AY.copyWith(
                color: AppColors.Pinky,
              ),
            ),
          ),

          // PICKERS
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
                    color: const Color(0xFFEFA5B4).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),

                SizedBox(
                  height: 180.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPicker(
                        weeks.map((e) => "$e weeks").toList(),
                        weekController,
                        155.w,
                      ),
                      _buildPicker(
                        days.map((e) => "$e days").toList(),
                        dayController,
                        150.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // BUTTON
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
                MyNavigator.goTo(
                  context,
                  const Step8EstimatedConception(),
                  type: NavigatorType.push,
                );
              },
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
      width: width,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 30,
        perspective: 0.001,
        physics: const FixedExtentScrollPhysics(),
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
