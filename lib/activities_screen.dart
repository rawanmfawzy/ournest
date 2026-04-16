import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Images.dart';
import 'features/splash/views/background.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// ✅ الخلفية الجديدة (Gradient + SVG)
          const SplashDecorations(),

          /// ✅ المحتوى
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: 20.h),

                  buildTopBar(),

                  SizedBox(height: 10.h),

                  Text(
                    "GUIDE TO ACTIVITIES : MONTH 2",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: AppColors.Pinky,
                    ),
                  ),

                  SizedBox(height: 15.h),

                  Image.asset(
                    Appimages.feeding,
                    width: 200.w,
                  ),

                  SizedBox(height: 15.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: List.generate(
                        6,
                            (index) => buildCard(index),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Top Bar
  Widget buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.Pinky,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 18,
            ),
          ),

          CircleAvatar(
            radius: 18.r,
            backgroundImage: AssetImage(Appimages.person_image),
          ),
        ],
      ),
    );
  }

  /// 🔹 Card
  Widget buildCard(int index) {

    /// 👇 الصور الجديدة
    final images = [
      "assets/images/Rectangle 304.png",
      "assets/images/Rectangle 305.png",
      "assets/images/feeding.jpg",
    ];

    return Container(
      width: 165.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.Pinky),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.all(8.w),
            child: Text(
              "Activity ${index + 1}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ),

          Stack(
            alignment: Alignment.center,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  images[index % images.length], // 👈 هنا التغيير
                  height: 100.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC5D0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "Time: 7:00AM | Dur: 5 min",
              style: TextStyle(fontSize: 10.sp),
            ),
          ),

          SizedBox(height: 6.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "Play",
              style: TextStyle(
                color: AppColors.Pinky,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
              ),
            ),
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}