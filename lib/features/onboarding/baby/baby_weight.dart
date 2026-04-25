import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/features/onboarding/baby/baby_name.dart';
import '../../../core/utils/app_Styles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../splash/views/background.dart';
import '../services/baby_services.dart';

class BabyWeight extends StatelessWidget {
  const BabyWeight({super.key});

  @override
  Widget build(BuildContext context) {
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
                if (weightController.text.isNotEmpty) {
                  final value = double.tryParse(weightController.text.replaceAll(',', '.'));

                  if (value == null || value <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Enter valid weight")),
                    );
                    return;
                  }

                  BabyData.weight = value;
                }
                Navigator.push(context, MaterialPageRoute(builder: (_) => const BabyName()));
              },
            ),
          ),
        ],
      ),
    ),
    );
  }
}
