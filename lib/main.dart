import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/features/splash/views/splash_screen.dart';
import 'core/cubit/dio_interceptor.dart';
import 'core/cubit/token_storage_helper.dart';
import 'core/widgets/buttom_navigation_bar_baby.dart';
import 'features/clinic/services/skin/skin_ai_services.dart';
import 'features/home/baby_home_screen/widgets/activities_screen.dart';
import 'core/cubit/user_cubit.dart';
import 'features/MothersCommunity/cubit/communitycubit.dart';
import 'features/clinic/cubit/clinic_cubit.dart';
import 'features/clinic/cubit/feeding_cubit.dart';
import 'features/clinic/cubit/skin_cubit.dart';
import 'features/home/baby_home_screen/widgets/feeding_screen.dart';
import 'features/home/services/tips/tips_cubit.dart';
import 'features/home/services/tips/tips_service.dart';
import 'features/lists/services/reminder/remindercubit.dart';
import 'features/lists/services/reminder/reminderservice.dart';
import 'features/lists/services/to_do_list/to_do_list_services.dart';
import 'features/lists/services/to_do_list/todocubit.dart';
import 'features/period_tracking/cubit/period_cubit.dart';
import 'features/period_tracking/views/period_tracking.dart';
import 'features/settings/cubit/settings_cubit.dart';
import 'features/home/baby_home_screen/cubit/baby_care_cubit.dart';
import 'features/pass/cubit/pass_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider<CommunityCubit>(
          create: (_) => CommunityCubit(),
        ),
        BlocProvider(
          create: (_) => ReminderCubit(
            ReminderService(DioClient.dio),
          ),
        ),
        BlocProvider<TodoCubit>(
          create: (_) => TodoCubit(
            TodoService(),
          )..loadTodos(),
        ),
        BlocProvider(
          create: (_) => TipsCubit(TipsService()),
        ),
        BlocProvider<PeriodCubit>(create: (_) => PeriodCubit()),
        BlocProvider<SettingsCubit>(create: (_) => SettingsCubit()),
        BlocProvider<BabyCareCubit>(create: (_) => BabyCareCubit()),
        BlocProvider<PassCubit>(create: (_) => PassCubit()),
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
