import 'package:flutter/material.dart';
import 'package:ournest/core/utils/appStyles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/appColor.dart';
import '../../../../core/utils/appIcons.dart';
import '../../../../core/utils/appImages.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../settings/mother/views/settings_screen.dart';
import 'Reminder_Screen.dart';
import 'To_do_List_Screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFC5D0),
              ],
            ),
          ), child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                 SizedBox(height: 52.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile Image
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(Appimages.person_image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Settings Button
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

                 SizedBox(height: 60.h),

                 Text(
                  "Check and Remember\nYour Tasks.",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle20w700AY,
                ),

                 SizedBox(height: 116.h),

                _bigButton(
                  text: "To-Do List",
                  icon: AppIcons.task_list_pin,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TodoListScreen(),
                      ),
                    );
                  },
                ),

                 SizedBox(height: 32.h),

                _bigButton(
                  text: "Reminder To Me",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ReminderScreen(),
                      ),
                    );
                  },
                ),

                 SizedBox(height: 40.h),
              ],

            ),
          ),
          ),

    );
  }


  Widget _bigButton({
    required String text,
    required Function() onTap,
    String? icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 88.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.pink.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 6.r,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppStyles.textStyle20w700AY,
            ),

            if (icon != null) ...[
              CustomSvg(
                path: icon,
                width: 24.w,
                height: 24.h,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
