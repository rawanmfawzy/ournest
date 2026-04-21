import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../settings/mother/views/mather_settings.dart';

class Periodtracking extends StatefulWidget {
  const Periodtracking({super.key});

  @override
  State<Periodtracking> createState() => _PeriodtrackingState();
}

class _PeriodtrackingState extends State<Periodtracking> {
  double progress = 0.75; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6EA),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFFC5D0),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 65.h),

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(Appimages.person_image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CustomSvg(
                    path: AppIcons.settings,
                    width: 24.w,
                    height: 24.h,
                    color: AppColors.Pinky,
                    onTap:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),

              /// MONTH
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios,
                      size: 14.sp, color: AppColors.Pinky),
                  SizedBox(width: 10.w),
                  Text(
                    "November 2025",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Icon(Icons.arrow_forward_ios,
                      size: 14.sp, color: AppColors.Pinky),
                ],
              ),

              SizedBox(height: 92.h),

              /// CIRCLE WITH DAYS AND DOT
              SizedBox(
                width: 273.w,
                height: 273.w,
                child: CustomPaint(
                  painter: PeriodCirclePainter(progress),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Period in",
                          style:AppStyles.textStyle14w400hints.copyWith(fontSize: 12.sp,
                            fontWeight: FontWeight.w400,),
                        ),
                        Text(
                          "10 Days",
                          style:AppStyles.textStyle14w500Alex.copyWith(fontSize: 30.sp,
                            fontWeight: FontWeight.w500,),
                        ),
                        SizedBox(height: 80.h),
                        Text(
                          "Low chance of getting pregnant",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 60.h),

              /// BUTTONS
              Wrap(
                spacing: 10.w,
                runSpacing: 11.h,
                alignment: WrapAlignment.center,
                children: [
                  chip("High fertility",  Color(0xFF56DAD3)),
                  chip("Menstrual days",AppColors.Pinky),
                  chip("Medium fertility", Colors.black),
                  chip("Peak fertility", Color(0xFF45F12E)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// CHIP
  Widget chip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: color, width: 1.5),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// CUSTOM PAINTER FOR CIRCLE
class PeriodCirclePainter extends CustomPainter {
  final double progress; // 0 → 1

  PeriodCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    /// Base circle (gray)
    final basePaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, basePaint);

    /// Gradient arc
    final progressPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment(-0.2, -1),
        end: Alignment(0.8, 1),
        colors: [
          Color(0xFF2E7470),
          Color(0xFF56DAD3),
        ],
        stops: [0.0753, 0.9247],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    /// Small dot at end
    final angle = -pi / 2 + sweepAngle;
    final dotX = center.dx + radius * cos(angle);
    final dotY = center.dy + radius * sin(angle);

    final dotPaint = Paint()..color = const Color(0xFF56DAD3);
    canvas.drawCircle(Offset(dotX, dotY), 6, dotPaint);

    /// Days 1 → 30
    for (int i = 1; i <= 30; i++) {
      double dayAngle = (2 * pi / 30) * i - pi / 2;

      final x = center.dx + (radius + 20) * cos(dayAngle);
      final y = center.dy + (radius + 20) * sin(dayAngle);

      Color dayColor;
      if (i <= 8) {
        dayColor = Colors.black;
      } else if (i <= 14) {
        dayColor = Color(0xFFD37E91);
      } else if (i <= 18) {
        dayColor = Colors.black;
      } else if (i <= 22) {
        dayColor = Color(0xFF56DAD3);
      } else if (i == 23) {
        dayColor = Color(0xFF45F12E);
      } else if (i <= 26) {
        dayColor = Color(0xFF56DAD3);
      } else {
        dayColor = Colors.black;
      }

      if (i == 23) {
        final dashPaint = Paint()
          ..color = Color(0xFF45F12E)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

        double dashWidth = pi / 15;
        double gap = dashWidth;
        final double r = 12;

        for (double a = 0; a < 2 * pi; a += dashWidth + gap) {
          canvas.drawArc(
            Rect.fromCircle(center: Offset(x, y), radius: r),
            a,
            dashWidth,
            false,
            dashPaint,
          );
        }
      }

      final textPainter = TextPainter(
        text: TextSpan(
          text: "$i",
          style: AppStyles.textStylenumoftracking.copyWith(
            color: dayColor,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          x - textPainter.width / 2,
          y - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
