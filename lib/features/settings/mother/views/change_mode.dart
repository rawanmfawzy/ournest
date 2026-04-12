import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_svg.dart';

class ChangeModePage extends StatefulWidget {
  const ChangeModePage({super.key});

  @override
  State<ChangeModePage> createState() => _ChangeModePageState();
}

class _ChangeModePageState extends State<ChangeModePage> {
  bool pregnancyToChildbirth = false;
  bool tryingToConceive = false;

  DateTime lastPeriod = DateTime(2025, 9, 20);
  DateTime dateOfLabor = DateTime(2026, 6, 27);
  DateTime dateOfConception = DateTime(2025, 10, 4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFFFC5D0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(radius: 22),
                Text(
                  "Change mode",
                  style: AppStyles.textStyle20w700AY.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomSvg(
                  path: AppIcons.settings,
                  width: 24.w,
                  height: 24.h,
                  color: AppColors.Pinky,
                ),
              ],
            ),

            SizedBox(height: 60.h),

            /// Toggle 1
            buildToggle(
              title: "From pregnancy to childbirth",
              value: pregnancyToChildbirth,
              onChanged: (val) {
                showModeDialog(
                  title: "You’re switching to Childbirth mode",
                  message:
                  "It help you care for your child up to the age of two and helps you learn everything about your child’s health. Would you like to switch ?",
                  onYes: () {
                    setState(() {
                      pregnancyToChildbirth = val;
                    });
                  },
                );
              },
            ),

            SizedBox(height: 15.h),

            /// Toggle 2
            buildToggle(
              title: "Trying to conceive",
              value: tryingToConceive,
              onChanged: (val) {
                showModeDialog(
                  title: "You’re switching to Trying to conceive",
                  message:
                  "Health insights and cycle tracking tools can help you find your most fertile days. Do you want to continue?",
                  onYes: () {
                    setState(() {
                      tryingToConceive = val;
                    });
                  },
                );
              },
            ),

            SizedBox(height: 30.h),

            /// Date Fields
            buildDateField("Start of last period", lastPeriod, () async {
              DateTime? picked = await pickDate(lastPeriod);
              if (picked != null) setState(() => lastPeriod = picked);
            }),

            SizedBox(height: 15.h),

            buildDateField("Date of labor", dateOfLabor, () async {
              DateTime? picked = await pickDate(dateOfLabor);
              if (picked != null) setState(() => dateOfLabor = picked);
            }),

            SizedBox(height: 15.h),

            buildDateField("Gestational", dateOfLabor, () {}),

            SizedBox(height: 15.h),

            buildDateField("Date of conception", dateOfConception, () async {
              DateTime? picked = await pickDate(dateOfConception);
              if (picked != null) setState(() => dateOfConception = picked);
            }),
          ],
        ),
      ),
    );
  }

  /// Dialog Message
  void showModeDialog({
    required String title,
    required String message,
    required VoidCallback onYes,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor:AppColors.Pinky,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.Pinky,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  title,
                  style: AppStyles.textStyle20w700AY.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10.h),

                Text(
                  message,
                  style: AppStyles.textStyle14w400hints.copyWith(
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20.h),

                Row(
                  children: [

                    Expanded(
                      child: CustomButton(
                        text: "No",
                        height: 36,
                        borderRadius: 8,
                        backgroundColor: Colors.white,
                        textStyle: AppStyles.textStyle14w400hints.copyWith(color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    SizedBox(width: 10.w),

                    Expanded(
                      child: CustomButton(
                        text: "Yes",
                        height: 36,
                        borderRadius: 8,
                        backgroundColor: Colors.white,
                        textStyle: AppStyles.textStyle14w400hints.copyWith(color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                          onYes();
                        },
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Toggle Widget
  Widget buildToggle({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.Pinky),
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 14.sp)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF49C14E),
            inactiveThumbColor: Colors.grey[300],
            inactiveTrackColor: Colors.grey[200],
          ),
        ],
      ),
    );
  }

  /// Date Field
  Widget buildDateField(String label, DateTime date, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: AppStyles.textStyle14w500Alex.copyWith(fontSize: 12.sp),
        ),

        SizedBox(height: 5.h),

        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            height: 50.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.Pinky),
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "${date.day} ${_monthName(date.month)} ${date.year}",
                  style: AppStyles.textStyle14w400hints.copyWith(
                    color: const Color(0xFF9E9C9C),
                  ),
                ),

                CustomSvg(
                  path: AppIcons.uil_calender,
                  width: 24.w,
                  height: 24.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<DateTime?> pickDate(DateTime initial) async {
    return await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
  }

  String _monthName(int month) {
    const names = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return names[month];
  }
}
