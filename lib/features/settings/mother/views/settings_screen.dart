import 'package:flutter/material.dart';
import '../../../../core/helper/my_navgator.dart';
import '../../../../core/utils/appColor.dart';
import '../../../../core/utils/appIcons.dart';
import '../../../../core/utils/appImages.dart';
import '../../../../core/utils/appStyles.dart';
import '../../../../core/widgets/custom_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../link/mother/views/mother_link.dart';
import 'change_mode.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFE6EA),
        body: Container(
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
            ), child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 65.h),

              /// Header
              Row(
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
                  Text("Settings",
                      style: AppStyles.textStyle20w700AY),
                  CustomSvg(
                    path: AppIcons.settings,
                    width: 24.w,
                    height: 24.h,
                    color: AppColors.Pinky,
                  ),
                ],
              ),
              SizedBox(height: 40.h),

              // FIRST CONTAINER
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.Pinky),
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    settingsRow(
                      icon: CustomSvg(
                        path: AppIcons.change_mode,
                        width: 24.w,
                        height: 24.h,
                      ),
                      title: "Change mode",
                      onTap: () { MyNavigator.goTo(
                        context,
                        const ChangeModePage(),
                        type: NavigatorType.push,
                      );},
                    ),
                    Divider(height: 1.h),
                    settingsRow(
                      icon:CustomSvg(
                        path: AppIcons.language,
                        width: 24.w,
                        height: 24.h,
                      ),
                      title: "Change Language",
                      value: "English",
                      onTap: () {},
                    ),
                    Divider(height: 1.h),
                    settingsRow(
                      icon: CustomSvg(
                        path: AppIcons.premium,
                        width: 24.w,
                        height: 24.h,
                      ),
                      title: "Get premium",
                      trailingIcon: CustomSvg(
                        path: AppIcons.lock_closed,
                        width: 24.w,
                        height: 24.h,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // SECOND CONTAINER
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.Pinky),
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    settingsRow(
                      icon: CustomSvg(
                path: AppIcons.partner_heart,
                  width: 24.w,
                  height: 24.h,
                ),
                      title: "Share with partner",
                      onTap: () { MyNavigator.goTo(
                        context,
                        const PartnerScreen(),
                        type: NavigatorType.push,
                      );},
                    ),
                    Divider(height: 1.h),
                    settingsRow(
                      icon: CustomSvg(
                        path: AppIcons.share,
                        width: 24.w,
                        height: 24.h,
                      ),
                      title: "Share with friends",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              // THIRD CONTAINER
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Other",
                  style: AppStyles.textStyle14w400hints.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.Pinky),
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    settingsRow(
                      icon: CustomSvg(
                path: AppIcons.support,
                  width: 24.w,
                  height: 24.h,
                ),
                      title: "Support",
                      onTap: () {},
                    ),
                    Divider(height: 1.h),
                    settingsRow(
                      icon: CustomSvg(
                        path: AppIcons.help,
                        width: 24.w,
                        height: 24.h,
                      ),
                      title: "Privacy policy",
                      onTap: () {},
                    ),
                    Divider(height: 1.h),
                    settingsRow(
                      icon: CustomSvg(
                        path: AppIcons.about,
                        width: 24.w,
                        height: 24.h,
                      ),
                      title: "About",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
          SizedBox(height: 65.h),

          // LOG OUT
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.Pinky),
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            child: settingsRow(
              icon: CustomSvg(
    path: AppIcons.log_out,
    width: 24.w,
    height: 24.h,
    ),
              title: "Log out",
              onTap: () {},
            ),
          ),
            ],
      ),
      ),
        ),
    );
  }
}
Widget settingsRow({
  required Widget icon,
  required String title,
  String? value,
  Widget? trailingIcon,
  required VoidCallback onTap,
}) {
  return ListTile(
    onTap: onTap,
    leading: icon,
    title: Text(title, style: AppStyles.textStyle14w500Alex),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value != null)
          Text(value, style: TextStyle(color: Color(0xFF49C14E), fontSize: 13.sp)),
        if (trailingIcon != null) trailingIcon,
        if (value == null && trailingIcon == null)
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.Pinky),
      ],
    ),
  );
}