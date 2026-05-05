import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'activitycard.dart';
import '../../../splash/views/background.dart';
import '../../../../../../../../core/utils/app_Images.dart';
import '../../../../../../../../core/utils/app_colors.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// الخلفية
          const SplashDecorations(),

          /// المحتوى الأساسي
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 52.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// الهيدر
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 18.r,
                      backgroundColor: AppColors.Pinky,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    CircleAvatar(
                      radius: 18.r,
                      backgroundImage: AssetImage(Appimages.person_image),
                    ),
                  ],
                ),

                SizedBox(height: 22.h),

                /// العنوان
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    "GUIDE TO ACTIVITIES : MONTH 2",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontFamilyFallback: const ['Roboto'],
                      letterSpacing: 0,
                      color: AppColors.Pinky
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 145.h,
            left: 102.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 172.w,
                  height: 161.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.Pinky,
                      width: 2,
                    ),
                  ),
                ),

                Container(
                  width: 155.w,
                  height: 155.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.Pinky,
                      width: 2,
                    ),
                  ),
                ),

                Container(
                  width: 145.w,
                  height: 138.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.Pinky,
                      width: 2,
                    ),
                  ),
                  child:Center(
                    child: Container(
                      width: 145.w,
                      height: 138.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(Appimages.feeding),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 320.h,
            left: 5,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  ActivityCard(
                    title: "Tummy Time 1",
                    image: Appimages.ex1,
                    time: "7:00AM",
                    duration: "5 min",
                    onPlay: () {},
                  ),

                  ActivityCard(
                    title: "Tummy Time 3",
                    image: Appimages.ex2,
                    time: "8:00AM",
                    duration: "7 min",
                    onPlay: () {},
                  ),

                  ActivityCard(
                    title: "Tummy Time 4",
                    image: Appimages.ex2,
                    time: "9:00AM",
                    duration: "10 min",
                    onPlay: () {},
                  ),
                  ActivityCard(
                    title: "Tummy Time 5",
                    image: Appimages.ex1,
                    time: "9:00AM",
                    duration: "10 min",
                    onPlay: () {},
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