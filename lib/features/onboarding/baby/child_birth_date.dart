import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/appIcons.dart';
import 'package:ournest/core/widgets/custom_svg.dart';
import 'package:ournest/features/onboarding/baby/baby_gender.dart';
import '../../../core/helper/my_navgator.dart';
import '../../../core/utils/appColor.dart';
import '../../../core/utils/appStyles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../splash/views/background.dart';


class childBirthDate extends StatefulWidget {
  const childBirthDate({super.key});

  @override
  State<childBirthDate> createState() => _childBirthDate();
}

class _childBirthDate extends State<childBirthDate> {
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
            top: 266.h,
            left: 36.w,
            child: Row(
              children: [
                Text(
                  "Select your child’s birth date",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle20w700AY.copyWith(
                    color: AppColors.Pinky,
                  ),
                ),
                SizedBox(width: 6.w),
                CustomSvg(
                  path: AppIcons.birthday_cake,
                  width: 22.w,
                  height: 22.h,
                ),
              ],
            ),
          ),

          // Pickers
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

          // Continue button
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
                  const babygender(),
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
      width: width.w,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 30.h,
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
