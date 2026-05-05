import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../core/widgets/custom_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SplashDecorations extends StatelessWidget {
  final double? screenWidth;
  final double? screenHeight;

  const SplashDecorations({super.key, this.screenWidth, this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // GRADIENT BACKGROUND
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:
                  AppColors.splash,
                ),
              ),
            ),

            // TOP LINES
            Positioned(
              top: 20.h,
              child: CustomSvg(
                height: 98.h,
                width: constraints.maxWidth.w,
                path: AppIcons.Group1,
              ),
            ),

            // BOTTOM LINES
            Positioned(
              bottom: 0.h,
              child: CustomSvg(
                height: 87.04.h,
                width: constraints.maxWidth.w,
                path: AppIcons.Group3,
              ),
            ),
          ],
        );
      },
    );
  }
}
