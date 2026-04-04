import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/appIcons.dart';
import '../../../core/utils/appStyles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../mother/step4_first_child.dart';
import '../../splash/views/background.dart';

class cycleofperiod extends StatelessWidget {
  const cycleofperiod({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController heightController = TextEditingController();
    TextEditingController weightController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),


          Positioned(
            top: 171.h,
            left: 20.w,
            child: CustomTextField(
              label: "Your last period",
              hintWidget: const Text("29-10-2025"),
              suffix2: Icon(AppIcons.calender as IconData?),
              width: 342.w,
              height: 52.h,
              fontSize: 16.sp, controller: weightController,
            ),
          ),

          Positioned(
            top: 366.h,
            left: 17.w,
            child: CustomTextField(
              label: "Your period length",
              controller: weightController,
              hintWidget: const Text("Enter your period length"),
              suffix2:  Icon(AppIcons.blood_drops as IconData?),
              width: 342.w,
              height: 52.h,
              fontSize: 16.sp,
            ),
          ),
          Positioned(
            top: 455.h,
            left: 17.w,
            child: CustomTextField(
              label: "Your cycle length",
              controller: weightController,
              hintWidget: const Text("Enter your cycle length"),
              suffix2:  Icon(AppIcons.cycle as IconData?),
              width: 342.w,
              height: 52.h,
              fontSize: 16.sp,
            ),
          ),

          // 🔹 Save button
          Positioned(
            top: 671.h,
            left: 83.w,
            child: CustomButton(
              width: 240.w,
              height: 55.h,
              text: "Continue",
              textStyle: AppStyles.textStyle20w700AY.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Step4FirstChild()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
