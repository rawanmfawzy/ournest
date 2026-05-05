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
import '../../../../core/cubit/token_storage_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentWeeks = 9;
  int currentDays = 5;
  int totalWeeks = 40;
  String trimester = "1st trimester";
  double progress = 0.0;
  List<Map<String, dynamic>> dynamicCircles = [];
  String? babyGender;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    int week = await TokenStorage.getCurrentWeek() ?? OnboardingData.gestationalWeeks;
    if (week <= 0) week = 9; // Fallback if no data
    
    String? storedGender = await TokenStorage.getBabyGender();

    setState(() {
      currentWeeks = week;
      babyGender = storedGender;
      progress = (currentWeeks + currentDays / 7) / totalWeeks;
      
      if (week <= 13) trimester = "1st trimester";
      else if (week <= 26) trimester = "2nd trimester";
      else trimester = "3rd trimester";
      
      dynamicCircles = [];
      void addCircle(double top, double? left, double? right, int val, bool isCurr) {
        if (val >= 1 && val <= 40) {
          dynamicCircles.add({'top': top, 'left': left, 'right': right, 'text': "$val", 'isCurrent': isCurr});
        }
      }
      
      addCircle(170.h, 18.w, null, week - 3, false);
      addCircle(170.h, null, 10.w, week + 3, false);
      addCircle(200.h, 63.w, null, week - 2, false);
      addCircle(200.h, null, 55.w, week + 2, false);
      addCircle(228.h, 112.w, null, week - 1, false);
      addCircle(228.h, null, 105.w, week + 1, false);
      addCircle(240.h, 152.w, null, week, true);
    });

    if (mounted) {
      context.read<TipsCubit>().loadTips(week);
    }
  }
  
  Future<void> _setGender(String gender) async {
    await TokenStorage.saveBabyGender(gender);
    setState(() {
      babyGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryGradient = babyGender == 'Boy'
        ? const LinearGradient(colors: [Color(0xFF56DADA), Color(0xFF0077B6)])
        : const LinearGradient(colors: [Color(0xFFFFC5D0), Color(0xFF56DADA)]);
    final primaryColor = babyGender == 'Boy' ? const Color(0xFF0077B6) : AppColors.Pinky;
    final borderColor = babyGender == 'Boy' ? const Color(0xFF56DADA) : const Color(0xFFFFC5D0);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1150.h,
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
                      
                      if (babyGender != null)
                        Text(
                          "It's a ${babyGender!.toLowerCase()} 🎉",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),

                      CustomSvg(
                        path: AppIcons.settings,
                        width: 24.w,
                        height: 24.h,
                        color: primaryColor,
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
                  Appimages.getWeekImage(currentWeeks),
                  width: 250.w,
                  height: 250.h,
                ),
              ),
              
              /// GENDER REVEAL BUTTONS
              if (currentWeeks >= 18 && currentWeeks <= 20 && babyGender == null)
                Positioned(
                  top: 140.h,
                  right: 20.w,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _setGender('Girl'),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: AppColors.Pinky, width: 1.5),
                          ),
                          child: Text("Girl", style: TextStyle(color: AppColors.Pinky, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () => _setGender('Boy'),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: const Color(0xFF0077B6), width: 1.5),
                          ),
                          child: Text("Boy", style: TextStyle(color: const Color(0xFF0077B6), fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),

              /// CIRCLES
              ...dynamicCircles.map((circle) {
                bool isCurrent = circle['isCurrent'] ?? false;

                return Positioned(
                  top: circle['top'],
                  left: circle['left'],
                  right: circle['right'],
                  child: Column(
                    children: [
                      SolidCircle(
                        size: 44,
                        gradient: primaryGradient,
                        text: circle['text'],
                        isCurrent: isCurrent,
                        currentColor: primaryColor,
                      ),
                      if (isCurrent)
                        Text(
                          "Current week",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                    ],
                  ),
                );
              }),

              /// PROGRESS CARD
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
                      color: borderColor,
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
                              gradient: primaryGradient,
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

              /// INSTRUCTIONS (NEW BLOCK)
              Positioned(
                top: 755.h,
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

                      final instructions = state.tips
                          .where((t) => t.category.toLowerCase().contains("instruction"))
                          .toList();
                      if (instructions.isEmpty) {
                        return const SizedBox(
                          height: 50,
                          child: Center(child: Text("No instructions today")),
                        );
                      }
                      return SymptomsContainer(
                        icon: AppIcons.about,
                        title: "Important Instructions and Tips",
                        symptoms: instructions.map((e) => e.content).toList(),
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
  final Color? currentColor;

  const SolidCircle({
    super.key,
    required this.size,
    this.gradient,
    required this.text,
    this.textStyle,
    this.isCurrent = false,
    this.currentColor,
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
            ? Border.all(color: currentColor ?? AppColors.Pinky, width: 3)
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
