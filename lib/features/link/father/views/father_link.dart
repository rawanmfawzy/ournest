import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/features/home/father_home_screen/views/father_home_screen.dart';
import 'package:ournest/features/settings/father/views/father_settings.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../../core/utils/app_Styles.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../partner_service.dart';

class LinkFather extends StatefulWidget {
  const LinkFather({super.key});

  @override
  State<LinkFather> createState() => _LinkFatherState();
}

class _LinkFatherState extends State<LinkFather> {
  final TextEditingController codeController = TextEditingController();
  bool isLoading = false;
  bool get isFilled => codeController.text.isNotEmpty;

  void acceptInvite() async {
    if (!isFilled) return;
    setState(() => isLoading = true);
    try {
      await PartnerService.acceptInvite(codeController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Partner linked successfully!")),
      );
      Navigator.pop(context); // الرجوع للإعدادات
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll("Exception: ", ""))),
      );
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFE6EA),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFFFFF), Color(0xFFFFC5D0)],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 65.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage(Appimages.fatherimage), fit: BoxFit.cover),
                        ),
                      ),
                      Text("Link with Partner", style: AppStyles.textStyle20w700AY),
                      CustomSvg(
                        path: AppIcons.settings, width: 24.w, height: 24.h, color: AppColors.Pinky,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SettingsScreenfather(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  CustomSvg(path: AppIcons.Share_with_your_partner, width: 10.w, height: 90.h),
                  Image.asset(Appimages.partner, width: 200.w, height: 200.h),
                  SizedBox(height: 34.h),
                  SizedBox(
                    width: 275.w,
                    height: 48.h,
                    child: TextField(
                      controller: codeController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "Write the code...",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.Pinky)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: AppColors.Pinky, width: 2.w)),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  isLoading
                      ? const CircularProgressIndicator(color: AppColors.Pinky)
                      : CustomButton(
                    text: "Confirm",
                    onPressed: isFilled ? acceptInvite : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FatherHomeScreen(),
                        ),
                      );
                    },
                    backgroundColor: isFilled ? AppColors.Pinky : Colors.grey,
                    textStyle: AppStyles.textStyle14w400hints.copyWith(color: Colors.white, fontSize: 13.sp),
                    width: 181.w, height: 50.h,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "You will be able to monitor your partner and child's status by entering the code",
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyle14w400hints.copyWith(fontSize: 11.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}