import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/features/clinic/services/skin/skin_ai_services.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../../core/widgets/custom_svg.dart';

import '../../cubit/clinic_cubit.dart';
import '../../cubit/feeding_cubit.dart';
import '../../cubit/skin_cubit.dart';

import '../../widgets/clinic/clinic_drawer.dart';
import '../../widgets/clinic/clinic_tap.dart';
import '../../widgets/feeding/feeding_tap.dart';
import '../../widgets/medicines/medicines_tap.dart';
import '../../widgets/skin/skin_tap.dart';

class ClinicScreenmother extends StatefulWidget {
  const ClinicScreenmother({super.key});

  @override
  State<ClinicScreenmother> createState() => _ClinicScreenmotherState();
}

class _ClinicScreenmotherState extends State<ClinicScreenmother>
    with SingleTickerProviderStateMixin {

  late TabController tabController;
  int currentTabIndex = 0;

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ClinicCubit()),

        BlocProvider(
          create: (_) => FeedingCubit(),
        ),

        BlocProvider(
          create: (_) => SkinCubit(SkinAIService()),
        ),
      ],
      child: Scaffold(
        drawer: ClinicDrawer(tabIndex: currentTabIndex),
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
                          Builder(
                            builder: (context) {
                              return IconButton(
                                icon: Icon(Icons.menu, color: AppColors.Pinky),
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
                  onTap: (index) {
                    setState(() {
                      currentTabIndex = index;
                    });
                  },
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