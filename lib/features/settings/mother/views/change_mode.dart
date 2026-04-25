import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../period_tracking/services/period_service.dart';
import '../../services/pregnancy_services.dart';

class ChangeModePage extends StatefulWidget {
  const ChangeModePage({super.key});

  @override
  State<ChangeModePage> createState() => _ChangeModePageState();
}

class _ChangeModePageState extends State<ChangeModePage> {
  bool pregnancyToChildbirth = false;
  bool tryingToConceive = false;

  DateTime lastPeriod = DateTime.now();
  DateTime dateOfLabor = DateTime.now().add(const Duration(days: 280));
  DateTime dateOfConception = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadSavedMode(); // تحميل المود المحفوظ لما الصفحة تفتح
  }

  // دالة لتحميل الداتا المحفوظة في الموبايل
  Future<void> _loadSavedMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pregnancyToChildbirth = prefs.getBool('mode_childbirth') ?? false;
      tryingToConceive = prefs.getBool('mode_conceive') ?? false;

      final savedPeriod = prefs.getString('last_period');
      if (savedPeriod != null) lastPeriod = DateTime.parse(savedPeriod);
    });
  }

  // دالة لحفظ المود وتحديث الباك إيند
  Future<void> _updateMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      if (mode == 'childbirth') {
        await PregnancyService.endPregnancy(); // تحديث الباك إيند
        await prefs.setBool('mode_childbirth', true);
        await prefs.setBool('mode_conceive', false);
        setState(() {
          pregnancyToChildbirth = true;
          tryingToConceive = false;
        });
      } else if (mode == 'conceive') {
        await PregnancyService.endPregnancy();
        await prefs.setBool('mode_conceive', true);
        await prefs.setBool('mode_childbirth', false);
        setState(() {
          tryingToConceive = true;
          pregnancyToChildbirth = false;
        });
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mode updated successfully!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Note: ${e.toString().replaceAll('Exception: ', '')}")),
        );
      }
    }
  }

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(radius: 22, backgroundColor: Colors.transparent),
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
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),

              SizedBox(height: 60.h),

              /// Toggle 1
              buildToggle(
                title: "From pregnancy to childbirth",
                value: pregnancyToChildbirth,
                onChanged: (val) {
                  if (val) {
                    showModeDialog(
                      title: "You’re switching to Childbirth mode",
                      message:
                      "It helps you care for your child up to the age of two and helps you learn everything about your child’s health. Would you like to switch?",
                      onYes: () => _updateMode('childbirth'),
                    );
                  }
                },
              ),

              SizedBox(height: 15.h),

              /// Toggle 2
              buildToggle(
                title: "Trying to conceive",
                value: tryingToConceive,
                onChanged: (val) {
                  if (val) {
                    showModeDialog(
                      title: "You’re switching to Trying to conceive",
                      message:
                      "Health insights and cycle tracking tools can help you find your most fertile days. Do you want to continue?",
                      onYes: () => _updateMode('conceive'),
                    );
                  }
                },
              ),

              SizedBox(height: 30.h),

              /// Date Fields
              buildDateField("Start of last period", lastPeriod, () async {
                DateTime? picked = await pickDate(lastPeriod);
                if (picked != null) {
                  setState(() => lastPeriod = picked);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('last_period', picked.toIso8601String());

                  // اختياري: نبعت التحديث للباك إيند
                  try {
                    await PeriodService.addPeriod(startDate: picked.toIso8601String().split('T').first);
                  } catch(e) {
                    print(e);
                  }
                }
              }),

              SizedBox(height: 15.h),

              buildDateField("Date of labor", dateOfLabor, () async {
                DateTime? picked = await pickDate(dateOfLabor);
                if (picked != null) setState(() => dateOfLabor = picked);
              }),

              SizedBox(height: 15.h),

              buildDateField("Gestational", dateOfLabor, () {}), // للعرض فقط حسب التصميم

              SizedBox(height: 15.h),

              buildDateField("Date of conception", dateOfConception, () async {
                DateTime? picked = await pickDate(dateOfConception);
                if (picked != null) setState(() => dateOfConception = picked);
              }),
            ],
          ),
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
          backgroundColor: AppColors.Pinky,
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
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.Pinky),
          ),
          child: child!,
        );
      },
    );
  }

  String _monthName(int month) {
    const names = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return names[month];
  }
}