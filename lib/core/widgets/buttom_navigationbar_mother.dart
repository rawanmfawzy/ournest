import 'package:flutter/material.dart';

import '../../features/doctor/doctor_screen.dart';
import '../../features/MothersCommunity/views/community_screen.dart';
import '../../features/clinic/views/mother/clinic_screen.dart';
import '../../features/home/mother_home_screen/views/mother_home_screen.dart';
import '../../features/lists/views/mother&father/list_screen.dart';
import '../utils/appColor.dart';
import '../utils/appIcons.dart';
import 'custom_svg.dart';

class ButtomNavigationBarmother extends StatefulWidget {
  const ButtomNavigationBarmother({super.key});

  @override
  State<ButtomNavigationBarmother> createState() => _ButtomNavigationBarmotherState();
}

class _ButtomNavigationBarmotherState extends State<ButtomNavigationBarmother> {
  int currentIndex = 0;

  final screens = [
    MotherHomeScreen(),
    ListScreen(),
    ClinicScreenmother(),
    DoctorScreen(),
    CommunityScreen(),
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
          height: 72,
          child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.Pinky,
        unselectedItemColor: Colors.grey[600],
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
            icon: CustomSvg(path: AppIcons.doctor, width: 24, height: 24,color: _iconColor(3),),
            label: "Doctor",
          ),
          BottomNavigationBarItem(
            icon: CustomSvg(path: AppIcons.MothersCommunity, width: 24, height: 18,color: _iconColor(4),),
            label: "Community",
          ),
        ],
      ),
        ),
    );
  }
}