import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/appImages.dart';
import 'package:ournest/features/settings/mother/views/settings_screen.dart';
import '../../../../core/utils/appColor.dart';
import '../../../../core/utils/appIcons.dart';
import '../../../../core/utils/appStyles.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_svg.dart';

class PartnerScreen extends StatelessWidget {
  const PartnerScreen({super.key});

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
        ), child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child:
      Column(
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
                Text("Partner", style: AppStyles.textStyle20w700AY),
                CustomSvg(
                  path: AppIcons.settings,
                  width: 24.w,
                  height: 24.h,
                  color: AppColors.Pinky,
                  onTap:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SettingsScreen()),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 40.h),

            /// Illustration
            CustomSvg(
              path: AppIcons.Share_with_your_partner,
              width: 10.w,
              height: 90.h,
            ),
            Image.asset(
              Appimages.partner,
              width: 200.w,
              height: 200.h,
            ),
            SizedBox(height: 34.h),
            /// Code Box
            Container(
              width: 275.w,
              height: 48.h,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.Pinky),
              ),
            ),

            SizedBox(height: 20.h),

            /// Send Button
            CustomButton(
              text: "Send pairing code",
              onPressed: () {},
              textStyle: AppStyles.textStyle14w400hints.copyWith(
                color: Colors.white,
                fontSize:11.sp
              ),
              width: 181.w,
              height: 50.h,
            ),


            Text(
              "Generate new pairing code",
              style: AppStyles.textStyle14w400hints.copyWith(
                fontSize: 12.sp,)
            ),

            SizedBox(height: 44.h),
            Text(
              "Your personal data is important. Only share it with a trusted, responsible partner",
              textAlign: TextAlign.center,
              style: AppStyles.textStyle14w400hints.copyWith(
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}