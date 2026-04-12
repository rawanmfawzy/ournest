import 'package:flutter/material.dart';
import 'package:ournest/features/Exercises.dart';
import '../../features/clinic/views/father/father_clinic_screen.dart';
import '../../features/home/baby_home_screen/views/baby_home_screen.dart';
import '../../features/lists/views/mother&father/list_screen.dart';
import '../../features/settings/father/views/father_settings.dart';
import '../utils/app_colors.dart';
import '../utils/app_Icons.dart';
import 'custom_svg.dart';

class ButtomNavigationBarBaby extends StatefulWidget {
  const ButtomNavigationBarBaby({super.key});

  @override
  State<ButtomNavigationBarBaby> createState() => _ButtomNavigationBarBabyState();
}

class _ButtomNavigationBarBabyState extends State<ButtomNavigationBarBaby> {
  int currentIndex = 0;

  final screens = [
    Babyhomescreen(),
    ListScreen(),
    ClinicScreenfather(),
    BabyExercises(),
    SettingsScreenfather(),
  ];
  Color _iconColor(int index) {
    return currentIndex == index ? AppColors.Pinky : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child:BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.Pinky,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: CustomSvg(path: AppIcons.home, width: 24, height: 24,color: _iconColor(0),),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: CustomSvg(path: AppIcons.list, width: 24, height: 24,color: _iconColor(1),),
              label: "List",
            ),
            BottomNavigationBarItem(
              icon: CustomSvg(path: AppIcons.clinic, width: 24, height: 24,color: _iconColor(2),),
              label: "Clinic",
            ),
            BottomNavigationBarItem(
              icon: CustomSvg(path: AppIcons.Exercises, width: 24, height: 24,color: _iconColor(3),),
              label: "Exercises",
            ),
            BottomNavigationBarItem(
              icon: CustomSvg(path: AppIcons.settings, width: 24, height: 24,color: _iconColor(4),),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
