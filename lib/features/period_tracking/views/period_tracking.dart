import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../settings/mother/views/mather_settings.dart';
import '../cubit/period_cubit.dart';
import '../cubit/period_state.dart';

class Periodtracking extends StatefulWidget {
  const Periodtracking({super.key});

  @override
  State<Periodtracking> createState() => _PeriodtrackingState();
}

class _PeriodtrackingState extends State<Periodtracking> {
  double progress = 0.0;
  String _centerTopText = 'Period in';
  String _centerMainText = '--';
  String _centerSubText = 'Loading…';

  @override
  void initState() {
    super.initState();
    context.read<PeriodCubit>().loadData();
  }

  void _updateFromPrediction(Map<String, dynamic>? prediction) {
    if (prediction == null || prediction['nextPeriodDate'] == null) return;

    final next = DateTime.tryParse(prediction['nextPeriodDate'].toString());
    if (next == null) return;

    final daysLeft = next.difference(DateTime.now()).inDays;
    final avgCycle = (prediction['averageCycle'] as num?)?.toDouble() ?? 28;

    setState(() {
      if (daysLeft <= 0) {
        _centerTopText = 'Period started';
        _centerMainText = '${daysLeft.abs()} days ago';
        _centerSubText = 'Log your period below';
        progress = 1.0;
      } else {
        _centerTopText = 'Period in';
        _centerMainText = '$daysLeft Days';
        _centerSubText = daysLeft <= 5
            ? 'High chance of getting pregnant'
            : daysLeft <= 10
                ? 'Medium chance'
                : 'Low chance of getting pregnant';
        progress = 1.0 - (daysLeft / avgCycle).clamp(0.0, 1.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PeriodCubit, PeriodState>(
      listener: (context, state) {
        if (state is PeriodLoaded) {
          _updateFromPrediction(state.prediction);
        }
        if (state is PeriodAddError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if (state is PeriodAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Period logged successfully!')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFE6EA),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFFFFF), Color(0xFFFFC5D0)],
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SettingsScreen()),
                        );
                      },
                    ),
                  ],
                ),

                /// MONTH LABEL
                BlocBuilder<PeriodCubit, PeriodState>(
                  builder: (context, state) {
                    final now = DateTime.now();
                    final monthNames = [
                      'January', 'February', 'March', 'April', 'May', 'June',
                      'July', 'August', 'September', 'October', 'November', 'December'
                    ];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_ios,
                            size: 14.sp, color: AppColors.Pinky),
                        SizedBox(width: 10.w),
                        Text(
                          '${monthNames[now.month - 1]} ${now.year}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Icon(Icons.arrow_forward_ios,
                            size: 14.sp, color: AppColors.Pinky),
                      ],
                    );
                  },
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
                            _centerTopText,
                            style: AppStyles.textStyle14w400hints.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          BlocBuilder<PeriodCubit, PeriodState>(
                            builder: (context, state) {
                              if (state is PeriodLoading) {
                                return SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.Pinky,
                                    strokeWidth: 2,
                                  ),
                                );
                              }
                              return Text(
                                _centerMainText,
                                style: AppStyles.textStyle14w500Alex.copyWith(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 80.h),
                          Text(
                            _centerSubText,
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

                SizedBox(height: 40.h),

                /// LOG PERIOD BUTTON
                GestureDetector(
                  onTap: () => _showLogPeriodDialog(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 28.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.Pinky,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.Pinky.withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Text(
                      '+ Log Period',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                /// LEGEND CHIPS
                Wrap(
                  spacing: 10.w,
                  runSpacing: 11.h,
                  alignment: WrapAlignment.center,
                  children: [
                    chip('High fertility', const Color(0xFF56DAD3)),
                    chip('Menstrual days', AppColors.Pinky),
                    chip('Medium fertility', Colors.black),
                    chip('Peak fertility', const Color(0xFF45F12E)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogPeriodDialog(BuildContext ctx) {
    final cubit = ctx.read<PeriodCubit>();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: ctx,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (_, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r)),
          title: Text('Log Period Start',
              style: TextStyle(
                  color: AppColors.Pinky,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select the first day of your period:',
                  style: TextStyle(fontSize: 13.sp)),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: dialogCtx,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    builder: (ctx, child) => Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme:
                            const ColorScheme.light(primary: AppColors.Pinky),
                      ),
                      child: child!,
                    ),
                  );
                  if (picked != null) {
                    setDialogState(() => selectedDate = picked);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.Pinky.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: AppColors.Pinky, size: 18.sp),
                      SizedBox(width: 10.w),
                      Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: TextStyle(
                            fontSize: 14.sp, color: AppColors.Pinky),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: Text('Cancel',
                  style:
                      TextStyle(color: Colors.grey, fontSize: 13.sp)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.Pinky,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              onPressed: () {
                Navigator.pop(dialogCtx);
                cubit.logPeriod(
                  startDate:
                      selectedDate.toIso8601String().split('T').first,
                );
              },
              child: const Text('Log', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget chip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: color, width: 1.5),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
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

    final basePaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, basePaint);

    final progressPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment(-0.2, -1),
        end: Alignment(0.8, 1),
        colors: [Color(0xFF2E7470), Color(0xFF56DAD3)],
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

    final angle = -pi / 2 + sweepAngle;
    final dotX = center.dx + radius * cos(angle);
    final dotY = center.dy + radius * sin(angle);

    final dotPaint = Paint()..color = const Color(0xFF56DAD3);
    canvas.drawCircle(Offset(dotX, dotY), 6, dotPaint);

    for (int i = 1; i <= 30; i++) {
      double dayAngle = (2 * pi / 30) * i - pi / 2;

      final x = center.dx + (radius + 20) * cos(dayAngle);
      final y = center.dy + (radius + 20) * sin(dayAngle);

      Color dayColor;
      if (i <= 8) {
        dayColor = Colors.black;
      } else if (i <= 14) {
        dayColor = const Color(0xFFD37E91);
      } else if (i <= 18) {
        dayColor = Colors.black;
      } else if (i <= 22) {
        dayColor = const Color(0xFF56DAD3);
      } else if (i == 23) {
        dayColor = const Color(0xFF45F12E);
      } else if (i <= 26) {
        dayColor = const Color(0xFF56DAD3);
      } else {
        dayColor = Colors.black;
      }

      if (i == 23) {
        final dashPaint = Paint()
          ..color = const Color(0xFF45F12E)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

        double dashWidth = pi / 15;
        double gap = dashWidth;
        const double r = 12;

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
          text: '$i',
          style: AppStyles.textStylenumoftracking.copyWith(color: dayColor),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
