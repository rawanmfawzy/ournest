import 'package:flutter/material.dart';
import 'package:ournest/features/auth/views/signup_page.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../core/widgets/custom_buttom.dart';
import '../../core/widgets/custom_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WelcomeServicesPage extends StatelessWidget {
  const WelcomeServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
        Container(
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
        ),
        ),

          Column(
              children: [
                 SizedBox(height: 20.h),

                // BACK BUTTON
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(left: 20.w),
                    child: _backButton(context),
                  ),
                ),

                 SizedBox(height: 20.h),

                const _TitleSection(),

                 SizedBox(height: 25.h),

                // GRID
                Expanded(
                  child: GridView.count(
                    padding:  EdgeInsets.symmetric(horizontal: 26.5.h),
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: const [
                      _ServiceCard(asset: Appimages.box1, label: "Pregnancy\nTips"),
                      _ServiceCard(asset: Appimages.box2, label: "Chatbot\nClinic"),
                      _ServiceCard(asset: Appimages.box3, label: "Mother's\nCommunity", rightImage: true),
                      _ServiceCard(asset: Appimages.box4, label: "Healthy\nDiet"),
                      _ServiceCard(asset: Appimages.box5, label: "Father\nSection"),
                      _ServiceCard(asset: Appimages.box6, label: "Medical\nConsultation"),
                    ],
                  ),
                ),

                // CONTINUE BUTTON
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.h),
                  child: CustomButton(
                    text: "Continue",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignUpPage(),
                        ),
                      );
                    },
                    textStyle:  TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    height: 55.h,
                    borderRadius: 8.r,
                    backgroundColor: const Color(0xFFB34962),
                  ),
                ),


                 SizedBox(height: 25.h),
              ],
            ),
        ],
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFFC5D0),
            blurRadius: 6.r,
            offset: Offset(0, 1),
          )
        ],
      ),
      child:IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.pop(context),
        icon: CustomSvg(
          path: AppIcons.arrow_back,
          width: 8.w,
          height: 13.h,
        ),
      )
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text(
          "Welcome to Our App",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFB34962),
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          "You'll also have access to all\nour services",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFB34962),
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String asset;
  final String label;
  final bool rightImage;

  const _ServiceCard({
    required this.asset,
    required this.label,
    this.rightImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.pink.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 5.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ الصورة مرنة
          Expanded(
            flex: 3,
            child: Align(
              alignment:
              rightImage ? Alignment.centerRight : Alignment.center,
              child: Image.asset(
                asset,
                fit: BoxFit.contain,
              ),
            ),
          ),

           SizedBox(height: 6.h),

          // ✅ النص مرن ومش هيكسر
          Expanded(
            flex: 1,
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:  TextStyle(
                color: Color(0xE5000000),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
