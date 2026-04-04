import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/appColor.dart';
import '../../../core/utils/appStyles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'step4_first_child.dart';
import '../../splash/views/background.dart';

class Step3WeightHeight extends StatelessWidget {
  const Step3WeightHeight({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController heightController = TextEditingController();
    TextEditingController weightController = TextEditingController();

    return  GestureDetector(
        onTap: ()
        {
          FocusScope.of(context).unfocus();
        },
        child:Scaffold(
      body: Stack(
        children: [
          const SplashDecorations(),
          Positioned(
            top: 276.h,
            left: 31.w,
            child: SizedBox(
              child: Text(
                "Please enter your pre-pregnancy",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  color: AppColors.Pinky,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        Positioned(
          top: 300.h,
          left: 105.w,
          child: SizedBox(
            child: Text(
            "weight and height",
            textAlign: TextAlign.center,
            style: AppStyles.textStyle20w700AY.copyWith(
              color: AppColors.Pinky,
              fontSize: 18.sp,
            ),
            ),
          ),
        ),
          Positioned(
            top: 376.h,
            left: 24.w,
            child: CustomTextField(
              label: "Height",
              controller: heightController,
              hintWidget: const Text("Enter your height"),
              suffix2: const Text("cm"),
              width: 342.w,
              height: 52.h,
              fontSize: 16.sp,
            ),
          ),

          Positioned(
            top: 462.h,
            left: 24.w,
            child: CustomTextField(
              label: "Weight",
              controller: weightController,
              hintWidget: const Text("Enter your Weight"),
              suffix2: const Text("kg"),
              width: 342.w,
              height: 52.h,
              fontSize: 16.sp,
            ),
          ),

          Positioned(
            top: 600.h,
            left: 80.w,
            child: CustomButton(
              width: 240.w,
              height: 55.h,
              text: "Save",
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
        ),
    );
  }
}
