import 'package:flutter/material.dart';
import 'package:ournest/core/utils/app_Icons.dart';
import 'package:ournest/features/pass/views/password_changed_page.dart';

import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  bool hidePassword1 = true;
  bool hidePassword2 = true;

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()
        {
          FocusScope.of(context).unfocus();
        },
        child:Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFFB34962),
        centerTitle: true,
        toolbarHeight: 58,
        title:  Text(
          "Create New Password",
          style: TextStyle(
            color: Color(0xFFB34962),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom:  PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1.h,
            thickness: 1,
            color: Color(0xFFE5E5E5),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal: 17.h, vertical: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

             SizedBox(height: 50.h),
            CustomSvg(
              height: 90.h,
               width: 90.w,
              path: AppIcons.solar_password_broken,
            ),
             SizedBox(height: 22.h),
            Text(
              "Your new password must be different\nfrom previously used passwords",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFB34962), fontSize: 13.sp),
            ),
             SizedBox(height: 90.h),

            // New Password
            CustomTextField(
              label: "New Password",
              controller: newPasswordController,
              suffix1: Icon(
                Icons.lock_outline,
                color: Color(0xFFB34962),
              ),
              suffix2: IconButton(
                icon: Icon(
                  hidePassword1 ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFFB34962),
                ),
                onPressed: () {
                  setState(() {
                    hidePassword1 = !hidePassword1;
                  });
                },
              ),
            ),

             SizedBox(height: 25.h),

            // Confirm Password
            CustomTextField(
              label: "Confirm Password",
              controller: confirmPasswordController,
              suffix1: Icon(
                Icons.lock_outline,
                color: Color(0xFFB34962),
              ),
              suffix2: IconButton(
                icon: Icon(
                  hidePassword2 ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFFB34962),
                ),
                onPressed: () {
                  setState(() {
                    hidePassword2 = !hidePassword2;
                  });
                },
              ),
            ),

             SizedBox(height: 86.h),

            // Save Button
            CustomButton(
              text: "Save",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PasswordChangedPage()),
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
        ),
    );
  }
}
