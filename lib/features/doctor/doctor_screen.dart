import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../core/utils/app_Icons.dart';
import '../../core/utils/app_Images.dart';
import '../../core/widgets/custom_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../settings/mother/views/mather_settings.dart';


class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.splash,
        ),
      ),

      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile image
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

                  // Title
                  Row(
                    children: const [
                      Text(
                        "Doctor",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text("🩺", style: TextStyle(fontSize: 22)),
                    ],
                  ),

                  // SETTINGS PNG (NOW CLICKABLE)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SettingsScreen()),
                      );
                    },
                    child:  CustomSvg(
                      path: AppIcons.settings,
                      width: 24.w,
                      height: 24.h,
                      color: AppColors.Pinky,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 70),

            // ICON
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.pink.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.medical_information_rounded,
                size: 80,
                color: Color(0xFFB34962),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "Coming Soon",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFFB34962),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "This feature is under development.\nStay tuned!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
