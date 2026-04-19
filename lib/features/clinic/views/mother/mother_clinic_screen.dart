import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../../core/widgets/custom_svg.dart';

import '../../../settings/mother/views/mather_settings.dart';
import '../../cubit/clinic_cubit.dart';
import '../../widgets/Medicines_tap.dart';
import '../../widgets/clinic/clinic_drawer.dart';
import '../../widgets/clinic/clinic_tap.dart';
import '../../widgets/feeding/feeding_tap.dart';
import '../../widgets/skin/skin_tap.dart';

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
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClinicCubit(),
      child: Scaffold(
        drawer: const ClinicDrawer(),
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

                      Row(
                        children: [
                          /// زرار الشاتات 🔥
                          Builder(
                            builder: (context) {
                              return IconButton(
                                icon:  Icon(Icons.menu, color: AppColors.Pinky),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              );
                            },
                          ),
                        ],
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
                      ClinicTab(),
                      FeedingTab(),
                      MedicinesTap(),
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