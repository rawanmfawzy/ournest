import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../auth/views/login_page.dart';

class PasswordChangedPage extends StatefulWidget {
  const PasswordChangedPage({super.key});

  @override
  State<PasswordChangedPage> createState() => _PasswordChangedPageState();
}

class _PasswordChangedPageState extends State<PasswordChangedPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFB34962),
              ),
              child:  Icon(
                Icons.check,
                color: Colors.white,
                size: 60.sp,
              ),
            ),

             SizedBox(height: 25.h),

             Text(
              "Password Changed",
              style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xFFB34962),
                fontWeight: FontWeight.w700,
              ),
            ),

             SizedBox(height: 8.h),

             Text(
              "Password changed successfully",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
              ),
            ),

             SizedBox(height: 20.h),

          ],
        ),
      ),
    );
  }
}
