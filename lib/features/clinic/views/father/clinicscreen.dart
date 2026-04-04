import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/appColor.dart';
import '../../../../core/utils/appIcons.dart';
import '../../../../core/utils/appImages.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../settings/mother/views/settings_screen.dart';

import '../../widgets/clinic_tap.dart';
import '../../widgets/feeding_tap.dart';
import '../../widgets/skin_tap.dart';

class ClinicScreenfather extends StatefulWidget {
  const ClinicScreenfather({super.key});

  @override
  State<ClinicScreenfather> createState() => _ClinicScreenfatherState();
}

class _ClinicScreenfatherState extends State<ClinicScreenfather>
    with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xFFFFC5D0),
              ],
            ),
          ),

          child: SafeArea(
            child: Column(
              children: [

                SizedBox(height: 10.h),

                /// HEADER
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      /// PROFILE IMAGE
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(Appimages.fatherimage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      /// TITLE
                      Row(
                        children: [
                          Text(
                            "Clinic",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          CustomSvg(
                            path: AppIcons.maki_doctor,
                            width: 28.w,
                            height: 28.h,
                          ),
                        ],
                      ),

                      /// SETTINGS
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingsScreen(),
                            ),
                          );
                        },
                        icon: CustomSvg(
                          path: AppIcons.settings,
                          width: 24.w,
                          height: 24.h,
                          color: AppColors.Pinky,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15.h),

                /// TAB BAR
                TabBar(
                  controller: tabController,
                  indicatorColor: const Color(0xFFB34962),
                  labelColor: const Color(0xFFB34962),
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: const [
                    Tab(text: "Clinic"),
                    Tab(text: "Skin"),
                  ],
                ),

                SizedBox(height: 10.h),

                /// TAB VIEW
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [

                      /// FILE 1
                      ClinicTab(),


                      /// FILE 3
                      SkinTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}