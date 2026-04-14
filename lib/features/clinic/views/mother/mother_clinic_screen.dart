import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../../core/widgets/custom_svg.dart';

import '../../../settings/mother/views/mather_settings.dart';
import '../../widgets/Medicines_tap.dart';
import '../../widgets/clinic_tap.dart';
import '../../widgets/feeding_tap.dart';
import '../../widgets/skin_tap.dart';

class ClinicScreenmother extends StatefulWidget {
  const ClinicScreenmother({super.key});

  @override
  State<ClinicScreenmother> createState() => _ClinicScreenmotherState();
}

class _ClinicScreenmotherState extends State<ClinicScreenmother>
    with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
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
                            image: AssetImage(Appimages.person_image),
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
                    Tab(text: "Feeding"),
                    Tab(text: "Medicines"),
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

                      /// FILE 2
                      FeedingTab(),

                      /// FILE 3
                      MedicinesTap(),

                      /// FILE 4
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
