import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../onboarding/services/onboarding_data.dart';
import '../../../settings/father/views/father_settings.dart';
import '../../../settings/mother/views/mather_settings.dart';
import '../../services/tips/tipmodel.dart';
import '../../services/tips/tips_cubit.dart';
import '../../services/tips/tips_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

  late double progress =
      (currentWeeks + currentDays / 7) / totalWeeks;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final week = OnboardingData.gestationalWeeks;
      context.read<TipsCubit>().loadTips(week);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 950.h,
          child: Stack(
            children: [

              /// BACKGROUND
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.splash,
                  ),
                ),
              ),

              /// HEADER
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage:
                        AssetImage(Appimages.person_image),
                      ),

                      CustomSvg(
                        path: AppIcons.settings,
                        width: 24.w,
                        height: 24.h,
                        color: AppColors.Pinky,
                        onTap: () {
                          final screen =
                          OnboardingData.role == "father"
                              ? SettingsScreenfather()
                              : SettingsScreen();

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => screen),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              /// BABY IMAGE
              Positioned(
                top: 98.h,
                left: 70.w,
                child: Image.asset(
                  Appimages.baby,
                  width: 250.w,
                  height: 250.h,
                ),
              ),

              /// CIRCLES
              ...circles.map((circle) {
                bool isCurrent = circle['isCurrent'] ?? false;

                return Positioned(
                  top: circle['top'],
                  left: circle['left'],
                  right: circle['right'],
                  child: Column(
                    children: [
                      SolidCircle(
                        size: 44,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFC5D0),
                            Color(0xFF56DADA)
                          ],
                        ),
                        text: circle['text'],
                        isCurrent: isCurrent,
                      ),
                      if (isCurrent)
                        Text(
                          "Current week",
                          style: TextStyle(
                            color: AppColors.Pinky,
                            fontSize: 12.sp,
                          ),
                        ),
                    ],
                  ),
                );
              }),

              /// PROGRESS CARD (UNCHANGED UI)
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
                      color: const Color(0xFFFFC5D0),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$currentWeeks weeks and $currentDays days",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            trimester,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.sp,
                            ),
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
                              borderRadius:
                              BorderRadius.circular(10.r),
                            ),
                          ),

                          Container(
                            height: 8.h,
                            width:
                            (MediaQuery.of(context).size.width *
                                progress)
                                .clamp(0.0, double.infinity),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFFC5D0),
                                  Color(0xFF56DADA),
                                ],
                              ),
                              borderRadius:
                              BorderRadius.circular(10.r),
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
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            "${totalWeeks - currentWeeks} weeks left",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// SYMPTOMS (FIXED ONLY LOGIC)
              Positioned(
                top: 415.h,
                left: 10.w,
                right: 10.w,
                child:BlocBuilder<TipsCubit, TipsState>(
                  builder: (context, state) {

                    if (state is TipsLoading) {
                      return const SizedBox(
                        height: 80,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is TipsLoaded) {
                      final symptoms = state.tips
                          .where((t) => t.category.toLowerCase().contains("symptom"))
                          .toList();

                      if (symptoms.isEmpty) {
                        return const SizedBox(
                          height: 50,
                          child: Center(child: Text("No symptoms today")),
                        );
                      }

                      return SymptomsContainer(
                        icon: AppIcons.pregnant_woman,
                        title: "Symptoms",
                        symptoms: symptoms.map((e) => e.content).toList(),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),

              /// FOOD (FIXED ONLY LOGIC)
              Positioned(
                top: 585.h,
                left: 10.w,
                right: 10.w,
                child:BlocBuilder<TipsCubit, TipsState>(
                  builder: (context, state) {

                    if (state is TipsLoading) {
                      return const SizedBox(
                        height: 80,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is TipsLoaded) {

                      final food = state.tips
                          .where((t) => t.category.toLowerCase().contains("food"))
                          .toList();
                      if (food.isEmpty) {
                        return const SizedBox(
                          height: 50,
                          child: Center(child: Text("No food tips today")),
                        );
                      }
                      return SymptomsContainer(
                        icon: AppIcons.red_apple,
                        title: "Food",
                        symptoms: food.map((e) => e.content).toList(),
                      );
                    }

                    return const SizedBox();
                  },
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
