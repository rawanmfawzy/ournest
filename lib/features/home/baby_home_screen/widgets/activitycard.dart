import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import 'package:ournest/core/utils/app_colors.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String image;
  final String time;
  final String duration;
  final VoidCallback? onPlay;

  const ActivityCard({
    super.key,
    required this.title,
    required this.image,
    required this.time,
    required this.duration,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.Pinky),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// الجزء العلوي (أبيض)
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Center(
              child:Text(
              title,
              style: AppStyles.textStyle20w700AY.copyWith(fontSize: 14),
            ),
            ),
          ),

          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                child: Image.asset(
                  image,
                  height: 108.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              GestureDetector(
                onTap: onPlay,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFC5D0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          /// الجزء السفلي (بينك)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFFFC5D0), // بينك فاتح
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time: $time | Dur: $duration",
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: onPlay,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Play",
                              style: TextStyle(
                                color: AppColors.Pinky,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}