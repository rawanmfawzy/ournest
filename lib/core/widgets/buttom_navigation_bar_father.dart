import 'package:flutter/material.dart';

import '../../features/clinic/views/father/father_clinic_screen.dart';
import '../../features/home/mother_father_home_screen/views/home_screen.dart';
import '../../features/lists/views/mother&father/list_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_Icons.dart';
import 'custom_svg.dart';

class ButtomNavigationBarFather extends StatefulWidget {
  const ButtomNavigationBarFather({super.key});

  @override
  State<ButtomNavigationBarFather> createState() => _ButtomNavigationBarFatherState();
}

class _ButtomNavigationBarFatherState extends State<ButtomNavigationBarFather> {
  int currentIndex = 0;

  final screens = [
    HomeScreen(),
    ListScreen(),
    ClinicScreenfather(),
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
          height: 58,
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
        ],
      ),
        ),
    );
  }
}
