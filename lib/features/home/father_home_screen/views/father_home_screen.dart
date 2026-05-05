import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../../core/utils/app_Styles.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../settings/father/views/father_settings.dart';

class FatherHomeScreen extends StatefulWidget {
  const FatherHomeScreen({super.key});

  @override
  State<FatherHomeScreen> createState() => _FatherHomeScreenState();
}

class _FatherHomeScreenState extends State<FatherHomeScreen> {
  final List<Map<String, dynamic>> circles = [
    {'top': 170.h, 'left': 18.w, 'text': "6"},
    {'top': 170.h, 'right': 10.w, 'text': "12"},
    {'top': 200.h, 'left': 63.w, 'text': "7"},
    {'top': 200.h, 'right': 55.w, 'text': "11"},
    {'top': 228.h, 'left': 112.w, 'text': "8"},
    {'top': 228.h, 'right': 105.w, 'text': "10"},
    {'top': 240.h, 'left': 152.w, 'text': "9", 'isCurrent': true},
  ];

  final int currentWeeks = 9;
  final int currentDays = 5;
  final int totalWeeks = 40;
  final String trimester = "1st trimester";

  late double progress = (currentWeeks + currentDays / 7) / totalWeeks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6EA),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 950.h,
          child: Stack(
            children: [

              /// الخلفية
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.splash,
                  ),
                ),
              ),

              /// svg
              Positioned(
                top: 1.h,
                left: 0,
                child: CustomSvg(
                  path: AppIcons.Ellipse1,
                  width: 200.w,
                  height: 315.h,
                ),
              ),

              /// header
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage: AssetImage(Appimages.fatherimage),
                      ),
                      CustomSvg(
                        path: AppIcons.settings,
                        width: 24.w,
                        height: 24.h,
                        color: AppColors.Pinky,
                        onTap:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SettingsScreenfather()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              /// صورة الطفل
              Positioned(
                top: 100.h,
                left: 70.w,
                child: Image.asset(
                  Appimages.getWeekImage(currentWeeks),
                  width: 250.w,
                  height: 250.h,
                ),
              ),

              /// الدواير
              ...circles.map((circle) {
                bool isCurrent = circle['isCurrent'] ?? false;

                return Positioned(
                  top: circle['top'],
                  left: circle.containsKey('left') ? circle['left'] : null,
                  right: circle.containsKey('right') ? circle['right'] : null,
                  child: Column(
                    children: [
                      SolidCircle(
                        size: 44,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFC5D0), Color(0xFF56DADA)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        text: circle['text'],
                        isCurrent: isCurrent,
                        textStyle: AppStyles.textStyle20w700AY.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      if (isCurrent)
                        Text(
                          "Current week",
                          style: AppStyles.textStyle14w400hints.copyWith(
                            fontSize: 12,
                            color: AppColors.Pinky,
                          ),
                        ),
                    ],
                  ),
                );
              }),

              /// كارد التقدم
              Positioned(
                top: 325.h,
                left: 10.w,
                right: 10.w,
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Color(0xFFFFC5D0),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$currentWeeks weeks and $currentDays days",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                          Text(
                            trimester,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12.sp),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      Stack(
                        children: [
                          Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          Container(
                            height: 8.h,
                            width: MediaQuery.of(context).size.width *
                                progress -
                                20.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFFC5D0),
                                  Color(0xFF56DADA)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4.h),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date of labor 27 Jun 2026",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12.sp),
                          ),
                          Text(
                            "${totalWeeks - currentWeeks} weeks left",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// الكونتينر
              Positioned(
                top: 415.h,
                left: 10.w,
                right: 10.w,
                child: SymptomsContainer(
                  icon: AppIcons.pregnant_woman,
                  title: "Expected symptoms in the 9 week",
                  symptoms: [
                    "Nausea and Vomiting (Morning Sickness): This may be at its worst stage now and can occur at any time of the day.",
                    "Severe Fatigue and Exhaustion: Due to high progesterone levels and the body's effort in building the placenta.",
                  ],
                ),
              ),
              Positioned(
                top: 585.h,
                left: 10.w,
                right: 10.w,
                child: SymptomsContainer(
                  icon: AppIcons.red_apple,
                  title: "Beneficial Food for You and Your Baby\n at 9 Weeks Pregnant",
                  symptoms: [
                    "Folic Acid: Importance: Crucial for the development   of the fetal nervous system and preventing birth defects in the brain and spinal cord. It is often prescribed by the",
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SymptomsContainer extends StatelessWidget {
  final String icon;
  final String title;
  final List<String> symptoms;
  final VoidCallback? onSeeAll;

  const SymptomsContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.symptoms,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 2,
          color: const Color(0xFFBFEAF5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [

                  CustomSvg(
                    path: icon,
                    width: 20.w,
                    height: 20.h,
                  ),

                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  "See All",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),

          ...symptoms.map(
                (symptom) => Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text(
                "• $symptom",
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SolidCircle extends StatelessWidget {
  final double size;
  final Gradient? gradient;
  final String text;
  final TextStyle? textStyle;
  final bool isCurrent;

  const SolidCircle({
    super.key,
    required this.size,
    this.gradient,
    required this.text,
    this.textStyle,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
        border: isCurrent
            ? Border.all(color: AppColors.Pinky, width: 3)
            : null,
      ),
      child: Center(
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
