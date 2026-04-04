import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/appIcons.dart';
import 'package:ournest/core/widgets/custom_svg.dart';
import '../../../core/helper/my_navgator.dart';
import '../../../core/utils/appColor.dart';
import '../../../core/utils/appStyles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../auth/views/signup_page.dart';
import '../../splash/views/background.dart';
class Step9BirthDate extends StatefulWidget {
  const Step9BirthDate({super.key});

  @override
  State<Step9BirthDate> createState() => _Step9BirthDateState();
}

class _Step9BirthDateState extends State<Step9BirthDate> {
  List<int> days = [];

  int selectedDay = 1;
  int selectedMonth = 1;
  int selectedYear = DateTime.now().year;

  final List<String> months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  void updateDays() {
    final maxDays = getDaysInMonth(selectedYear, selectedMonth);

    setState(() {
      days = List.generate(maxDays, (i) => i + 1);

      if (selectedDay > maxDays) {
        selectedDay = maxDays;
        dayController.jumpToItem(maxDays - 1);
      }
    });
  }
  @override
  void initState() {
    super.initState();

    selectedYear = currentYear;
    selectedMonth = 1;

    days = List.generate(
      getDaysInMonth(selectedYear, selectedMonth),
          (i) => i + 1,
    );

    dayController = FixedExtentScrollController(initialItem: selectedDay - 1);
    monthController = FixedExtentScrollController(initialItem: selectedMonth - 1);
    yearController = FixedExtentScrollController(
      initialItem: years.indexOf(selectedYear),
    );
  }
  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }
  late final int currentYear = DateTime.now().year;

  late final List<int> years =
  List.generate(currentYear - 1949, (index) => 1950 + index);
  late FixedExtentScrollController dayController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),

          Positioned(
            top: 266.h,
            left: 55.w,
            child: Row(
              children: [
                Text(
                  "Select your date of birth.",
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
                            (index) {
                          selectedDay = days[index];
                        },
                      ),
                      _buildPicker(
                        months,
                        monthController,
                        120,
                            (index) {
                          selectedMonth = index + 1;
                          updateDays();
                        },
                      ),
                      _buildPicker(
                        years.map((e) => e.toString()).toList(),
                        yearController,
                        80,
                            (index) {
                          selectedYear = years[index];
                          updateDays();
                        },
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
                  const SignUpPage(),
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
      Function(int) onChanged,
      ){
    return SizedBox(
      width: width.w,
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: onChanged,
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
