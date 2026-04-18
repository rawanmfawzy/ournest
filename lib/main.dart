import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/features/splash/views/splash_screen.dart';
import 'core/cubit/dio_interceptor.dart';
import 'core/widgets/buttom_navigation_bar_baby.dart';
import 'features/home/baby_home_screen/widgets/activities_screen.dart';
import 'core/cubit/user_cubit.dart';
import 'features/MothersCommunity/cubit/communitycubit.dart';
import 'features/clinic/cubit/clinic_cubit.dart';
import 'features/clinic/cubit/feeding_cubit.dart';
import 'features/clinic/cubit/skin_cubit.dart';
void main() {
  DioClient.init();
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

        // ✅ ADD THIS
        BlocProvider<CommunityCubit>(
          create: (_) => CommunityCubit(),
        ),
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
