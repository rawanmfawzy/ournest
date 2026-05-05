import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/app_colors.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import 'package:ournest/core/widgets/custom_buttom.dart';
import 'package:ournest/core/widgets/custom_text_field.dart';
import 'package:ournest/features/link/partner_service.dart';

class LinkPartnerScreen extends StatefulWidget {
  const LinkPartnerScreen({super.key});

  @override
  State<LinkPartnerScreen> createState() => _LinkPartnerScreenState();
}

class _LinkPartnerScreenState extends State<LinkPartnerScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();
  
  bool isLoading = false;
  String? generatedToken;

  void sendInvite() async {
    if (emailController.text.isEmpty) return;
    
    setState(() => isLoading = true);
    try {
      final res = await PartnerService.sendInvite(emailController.text.trim());
      if (res['token'] != null) {
        setState(() {
          generatedToken = res['token'];
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invite sent! Share this token.')));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invite sent successfully!')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void acceptInvite() async {
    if (tokenController.text.isEmpty) return;
    
    setState(() => isLoading = true);
    try {
      await PartnerService.acceptInvite(tokenController.text.trim());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully linked!')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Partner', style: TextStyle(color: AppColors.Pinky)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.Pinky),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Send Invite", style: AppStyles.textStyle20w700AY.copyWith(color: AppColors.Pinky, fontSize: 18.sp)),
            SizedBox(height: 10.h),
            CustomTextField(
              label: "Partner Email (or Username)",
              controller: emailController,
            ),
            SizedBox(height: 15.h),
            CustomButton(
              text: isLoading ? "..." : "Generate & Send Token",
              onPressed: isLoading ? () {} : sendInvite,
              width: double.infinity,
              backgroundColor: AppColors.Pinky,
              textStyle: const TextStyle(color: Colors.white),
            ),
            if (generatedToken != null) ...[
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.Pinky),
                ),
                child: Row(
                  children: [
                    Expanded(child: SelectableText(generatedToken!, style: const TextStyle(fontWeight: FontWeight.bold))),
                    const Icon(Icons.copy, color: AppColors.Pinky),
                  ],
                ),
              ),
            ],
            
            SizedBox(height: 40.h),
            const Divider(),
            SizedBox(height: 40.h),
            
            Text("Accept Invite", style: AppStyles.textStyle20w700AY.copyWith(color: AppColors.Pinky, fontSize: 18.sp)),
            SizedBox(height: 10.h),
            CustomTextField(
              label: "Enter Token",
              controller: tokenController,
            ),
            SizedBox(height: 15.h),
            CustomButton(
              text: isLoading ? "..." : "Link Account",
              onPressed: isLoading ? () {} : acceptInvite,
              width: double.infinity,
              backgroundColor: AppColors.Pinky,
              textStyle: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
