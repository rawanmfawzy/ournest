import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/features/onboarding/baby/baby_name.dart';
import '../../../core/utils/appStyles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../splash/views/background.dart';

class baby_weight extends StatelessWidget {
  const baby_weight({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController heightController = TextEditingController();
    TextEditingController weightController = TextEditingController();

    return  GestureDetector(
        onTap: ()
        {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),


          Positioned(
            top: 376.h,
            left: 28.w,
            child: CustomTextField(
              label: "Enter your baby’s weight",
              controller: weightController,
              hintWidget: const Text("Enter your baby’s weight"),
              suffix2: const Text("kg"),
              width: 342.w,
              height: 52.h,
              fontSize: 16.sp,
            ),
          ),


          // 🔹 Save button
          Positioned(
            top: 550.h,
            left: 75.w,
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
                  MaterialPageRoute(builder: (_) => const babyname()),
                );
              },
            ),
          ),
        ],
      ),
    ),
    );
  }
}
