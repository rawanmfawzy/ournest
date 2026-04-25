import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../../core/utils/app_Styles.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../views/baby_care_detail_page.dart';

class Babyhomescreen extends StatefulWidget {
  const Babyhomescreen({super.key});

  @override
  State<Babyhomescreen> createState() => _BabyhomescreenState();
}

class _BabyhomescreenState extends State<Babyhomescreen> {

  final List<Map<String, dynamic>> circles = [
    {'top': 200.h, 'left': 18.w, 'text': "6"},
    {'top': 200.h, 'right': 10.w, 'text': "12"},
    {'top': 230.h, 'left': 63.w, 'text': "7"},
    {'top': 230.h, 'right': 55.w, 'text': "11"},
    {'top': 258.h, 'left': 112.w, 'text': "8"},
    {'top': 258.h, 'right': 105.w, 'text': "10"},
    {'top': 270.h, 'left': 152.w, 'text': "9", 'isCurrent': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6EA),
      body: SingleChildScrollView(
    child: SizedBox(
    height: 800.h, // خليها أكبر من الشاشة
      child: Stack(
        children: [

          /// الخلفية المتدرجة
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.splash,
              ),
            ),
          ),

          /// الخلفية SVG
          Positioned(
            top: 20.h,
            left: 0,
            child: CustomSvg(
              path: AppIcons.Ellipse,
              width: 200.w,
              height: 315.h,
            ),
          ),

          /// الشكل العلوي
          Positioned(
            top: 20.h,
            left: 0,
            right: 0,
            child: CustomSvg(
              height: 98.h,
              width: MediaQuery.of(context).size.width,
              path: AppIcons.Group1,
            ),
          ),

          /// الهيدر
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage: AssetImage(Appimages.person_image),
                      ),

                      CustomSvg(
                        path: AppIcons.calender,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// الدائرة الرئيسية
          Positioned(
            top: 130.h,
            left: 132.w,
            child: Stack(
              alignment: Alignment.center,
              children: [

                /// أكبر دايرة
                Container(
                  width: 136.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.Pinky,
                      width: 2,
                    ),
                  ),
                ),

                /// الدايرة اللي بعدها
                Container(
                  width: 113.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.Pinky,
                      width: 2,
                    ),
                  ),
                ),

                /// أصغر دايرة + النص
                Container(
                  width: 115.w,
                  height: 108.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.Pinky,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "2 month 2 days",
                          style: AppStyles.textStyle20w700AY.copyWith(
                            fontSize: 12,
                            color: AppColors.Pinky,
                          ),
                        ),
                        Text(
                          "3.3 kg",
                          style: AppStyles.textStyle20w700AY.copyWith(
                            fontSize: 12,
                            color: AppColors.Pinky,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// رسم الدواير
          ...circles.map((circle) {

            bool isCurrent = circle['isCurrent'] ?? false;

            return Positioned(
              top: circle['top'],
              left: circle.containsKey('left') ? circle['left'] : null,
              right: circle.containsKey('right') ? circle['right'] : null,

              child: Column(
                children: [
                  SolidCircle(
                    size: 44,
                    color: const Color(0xFFFFC5D0),
                    text: circle['text'],
                    isCurrent: isCurrent,
                    textStyle: AppStyles.textStyle20w700AY
                        .copyWith(color: Colors.white),
                  ),

                  if (isCurrent)
                    Text(
                      "Current week",
                      style: AppStyles.textStyle14w400hints.copyWith(fontSize: 12,color: AppColors.Pinky)
                    ),
                ],
              ),
            );
          }),
          Positioned(
            top: 360.h,
            left: 20.w,
            right: 20.w,
            child: Wrap(
              spacing: 20.w,
              runSpacing: 35.h,
              alignment: WrapAlignment.center,
              children: [
                buildBabyCard(Appimages.feeding, "Feeding time",
                   () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BabyCareDetailPage(
                        type: 'feeding',
                        title: 'Feeding Time',
                      ),
                    ),
                  );
                },),
                buildBabyCard(Appimages.naps, "Baby naps",
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BabyCareDetailPage(
                          type: 'vitamins',
                          title: 'Baby Naps & Sleep',
                        ),
                      ),
                    );
                  },),
                buildBabyCard(Appimages.cry, "Reasons for a baby crying",
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BabyCareDetailPage(
                          type: 'vitamins',
                          title: 'Baby Care Tips',
                        ),
                      ),
                    );
                  },),
                buildBabyCard(Appimages.temperature, "Baby’s temperature",
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BabyCareDetailPage(
                          type: 'vitamins',
                          title: "Baby's Health",
                        ),
                      ),
                    );
                  },),
                buildBabyCard(Appimages.food, "Baby’s feeding",
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BabyCareDetailPage(
                          type: 'feeding',
                          title: "Baby's Feeding",
                        ),
                      ),
                    );
                  },),
                buildBabyCard(Appimages.vaccine, "Baby’s vaccins",
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BabyCareDetailPage(
                          type: 'vaccinations',
                          title: "Vaccination Schedule",
                        ),
                      ),
                    );
                  },),
              ],
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }
}

class SolidCircle extends StatelessWidget {

  final double size;
  final Color color;
  final String text;
  final TextStyle? textStyle;
  final bool isCurrent;

  const SolidCircle({
    super.key,
    required this.size,
    required this.color,
    required this.text,
    this.textStyle,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,

        border: isCurrent
            ? Border.all(
          color: AppColors.Pinky,
          width: 3,
        )
            : null,

        boxShadow: isCurrent
            ? [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ]
            : [],
      ),

      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle ??
              TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
Widget buildBabyCard(String image, String title,onTap, {Color borderColor =const Color(0xFFFFC5D0)}) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20.r),
    elevation: 4,
    child: InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap:onTap,
      child: Container(
        width: 150.w,
        padding: EdgeInsets.only(
          top: 60.h,
          bottom: 12.h,
          left: 8.w,
          right: 8.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: borderColor,
            width: 2, // سمك البوردر
          ),
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: -90.h,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: borderColor,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 45.r,
                      backgroundImage: AssetImage(image),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20w700AY.copyWith(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
