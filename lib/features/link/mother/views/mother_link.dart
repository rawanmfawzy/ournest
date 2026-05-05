import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/app_Images.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Styles.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../settings/mother/views/mather_settings.dart';
import '../../partner_service.dart';

class LinkMother extends StatefulWidget {
  const LinkMother({super.key});

  @override
  State<LinkMother> createState() => _LinkMotherState();
}

class _LinkMotherState extends State<LinkMother> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  void sendInvite() async {
    if (emailController.text.isEmpty) return;
    setState(() => isLoading = true);
    try {
      final res = await PartnerService.sendInvite(emailController.text.trim());
      final String code = res['token'] ?? "";
      
      setState(() {
        emailController.text = code;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Code generated: $code. Share this with your partner.")),
      );
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
                          image: DecorationImage(image: AssetImage(Appimages.person_image), fit: BoxFit.cover),
                        ),
                      ),
                      Text("Partner", style: AppStyles.textStyle20w700AY),
                      CustomSvg(
                        path: AppIcons.settings, width: 24.w, height: 24.h, color: AppColors.Pinky,
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  CustomSvg(path: AppIcons.Share_with_your_partner, width: 10.w, height: 90.h),
                  Image.asset(Appimages.partner, width: 200.w, height: 200.h),
                  SizedBox(height: 20.h),

                  CustomTextField(
                    label: "Partner's Email",
                    controller: emailController,
                    hintWidget: const Text("Enter your partner's email"),
                  ),

                  SizedBox(height: 20.h),
                  isLoading
                      ? const CircularProgressIndicator(color: AppColors.Pinky)
                      : CustomButton(
                    text: "Send pairing code",
                    onPressed: sendInvite,
                    textStyle: AppStyles.textStyle14w400hints.copyWith(color: Colors.white, fontSize: 13.sp),
                    width: double.infinity,
                    height: 50.h,
                  ),
                  SizedBox(height: 44.h),
                  Text(
                    "Your personal data is important. Only share it with a trusted, responsible partner",
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