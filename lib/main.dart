import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'core/cubit/user_cubit.dart';
import 'core/widgets/buttom_navigation_bar_father.dart';
import 'core/widgets/buttom_navigationbar_mother.dart';
import 'features/clinic/cubit/clinic_cubit.dart';
import 'features/clinic/cubit/feeding_cubit.dart';
import 'features/clinic/cubit/skin_cubit.dart';
import 'features/doctor/doctor_screen.dart';
import 'features/MothersCommunity/views/community_screen.dart';
import 'features/auth/views/login_page.dart';
import 'features/clinic/views/father/clinicscreen.dart';
import 'features/clinic/views/mother/clinic_screen.dart';
import 'features/home/baby_home_screen/views/babyhomescreen.dart';
import 'features/home/father_home_screen/views/fatherhomescreen.dart';
import 'features/home/mother_home_screen/views/mother_home_screen.dart';
import 'features/link/father/views/father_link.dart';
import 'features/link/mother/views/mother_link.dart';
import 'features/lists/views/mother&father/Reminder_Screen.dart';
import 'features/onboarding/mother/Step2_Not_Pregnant.dart';
import 'features/period_tracking/views/period_tracking.dart';
import 'features/settings/father/views/settings.dart';
import 'features/settings/mother/views/settings_screen.dart';
import 'features/splash/views/splash_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (_) => UserCubit()),
        BlocProvider<ClinicCubit>(create: (_) => ClinicCubit()),
        BlocProvider<FeedingCubit>(create: (_) => FeedingCubit()),
        BlocProvider<SkinCubit>(create: (_) => SkinCubit()),

      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}