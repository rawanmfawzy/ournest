import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/my_navgator.dart';
import '../../../core/utils/app_Images.dart';
import '../../auth/views/login_page.dart';
import 'background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1, end: 1.1)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;

      MyNavigator.goTo(
        context,
        const LoginPage(),
        type: NavigatorType.pushReplacement,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          const SplashDecorations(),


          Positioned(
            top: 269.h,
            left: 97.w,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                Appimages.our_nest,
                width: 182.w,
                height: 274.h,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // TEXT "OUR NEST"
          Positioned(
            top: 365.h,
            left: 95.w,
            child:Image.asset(
              Appimages.text_our_nest,
              width: 182.w,
              height: 274.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
