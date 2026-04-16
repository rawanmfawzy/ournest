import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Images.dart';

class FeedingScreen extends StatelessWidget {
  const FeedingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

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

        child: SafeArea(
          child: Stack(
            children: [

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/icons/group1.svg",
                  fit: BoxFit.cover,
                ),
              ),

              SingleChildScrollView(
                child: Column(
                  children: [

                    SizedBox(height: 10.h),

                    buildAddFeedingBar(),

                    SizedBox(height: 10.h),

                    Text(
                      "GUIDE TO FEEDING : MONTH 2",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: AppColors.Pinky,
                      ),
                    ),

                    SizedBox(height: 15.h),

                    Center(
                      child: Image.asset(
                        "assets/images/baby_center.png",
                        width: 220.w,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18.w),
                      padding: EdgeInsets.only(top: 16.h, bottom: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppColors.Pinky,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [

                          Text(
                            "PROPOSED FOOD\nSCHEDULE (MONTH2)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: AppColors.Pinky,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3D7DC),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: const [
                                Text("TIME",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text("ACTIVITY",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),

                          SizedBox(height: 8.h),

                          /// TABLE
                          ...[
                            "6:30 AM",
                            "9:30 AM",
                            "12:30 PM",
                            "3:30 PM",
                            "6:30 PM",
                            "9:30 PM",
                            "12:30 AM",
                          ].map((time) => Column(
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 7.h),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(time,
                                        style:
                                        TextStyle(fontSize: 12.sp)),
                                    Text("FEEDING",
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.w600,
                                            fontSize: 12.sp)),
                                  ],
                                ),
                              ),
                              Container(
                                height: 0.6,
                                color: Colors.grey.shade300,
                              )
                            ],
                          )),
                        ],
                      ),
                    ),

                    SizedBox(height: 15.h),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18.w),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppColors.Pinky,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [

                          Text(
                            "DAILY NEEDS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: AppColors.Pinky,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          buildNeed("assets/icons/feed.png",
                              "NUMBER OF FEEDINGS: 6-8 PER DAY"),
                          buildNeed("assets/icons/diaper.png",
                              "NUMBER OF WET DIAPERS: 6+ PER DAY"),
                          buildNeed("assets/icons/weight.png",
                              "WEIGHT GAIN RATE: 150-200 GM/WEEK"),
                          buildNeed("assets/icons/vaccine.png",
                              "NEXT VACCINATIONS: END OF MONTH 2"),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddFeedingBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.Pinky,
            child:
            const Icon(Icons.arrow_back, color: Colors.white, size: 18),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE6EA),
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(
                color: AppColors.Pinky,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Add the last\nFeeding time",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.sp),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    color: AppColors.Pinky,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add,
                      size: 14, color: Colors.white),
                ),
              ],
            ),
          ),

          CircleAvatar(
            radius: 18.r,
            backgroundImage:
            AssetImage(Appimages.person_image),
          ),
        ],
      ),
    );
  }

  Widget buildNeed(String icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Image.asset(icon, width: 18.w),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 11.sp),
            ),
          ),
        ],
      ),
    );
  }
}