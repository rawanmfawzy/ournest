import 'package:flutter/material.dart';
import '../../../core/widgets/custom_buttom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Create_New_Password_Page.dart';


class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final List<TextEditingController> controllers =
  List.generate(4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFFB34962),
        centerTitle: true,
        toolbarHeight: 58,
      ),

      body: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.w),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

             SizedBox(height: 30.h),

             Text(
              "Verify Code",
              style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xFFB34962),
                fontWeight: FontWeight.w700,
              ),
            ),

             Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                      "Please enter the code we just sent to Phone Number\n",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 13.sp,
                      ),
                    ),
                    TextSpan(
                      text: "example +01 23 56 78 917",
                      style: TextStyle(
                        color: Color(0xFF2BA24C), // green color
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),

             SizedBox(height: 46.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 55.w,
                  height: 45.h,
                  margin:  EdgeInsets.symmetric(horizontal: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB34962),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: TextField(
                    controller: controllers[index],
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: "-",
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onChanged: (val) {
                      if (val.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),

             SizedBox(height: 30.h),

            Column(
              children: [
                 Text(
                  "Didn't receive OTP ?",
                  style: TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 13.sp,
                  ),
                ),
                 SizedBox(height: 5.h),
                GestureDetector(
                  onTap: () {},
                  child:  Text(
                    "Resend code",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

             SizedBox(height: 56.h),

            CustomButton(
              text: "Verify",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CreateNewPasswordPage()),
                );
              },
              textStyle:  TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              width: double.infinity,
              height: 50.h,
              borderRadius: 8.r,
              backgroundColor: const Color(0xFFB34962),
            ),

             SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
