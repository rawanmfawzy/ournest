import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_Styles.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../splash/views/background.dart';
import '../../../core/widgets/buttom_navigation_bar_mother.dart';
import '../services/baby_services.dart'; // مسار الهوم

class BabyName extends StatefulWidget {
  const BabyName({super.key});
  @override
  State<BabyName> createState() => _BabyNameState();
}

class _BabyNameState extends State<BabyName> {
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  void saveBaby() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter baby name")),
      );
      return;
    }
    setState(() => isLoading = true);
    try {
      BabyData.name = nameController.text.trim();
      await BabyService.createBaby(); // إرسال الداتا للباك إيند

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const ButtomNavigationBarmother()),
              (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            const SplashDecorations(),
            Positioned(
              top: 376.h, left: 28.w,
              child: CustomTextField(
                label: "Enter your baby’s name",
                controller: nameController,
                hintWidget: const Text("e.g. Liam, Emma..."),
                width: 342.w, height: 52.h, fontSize: 16.sp,
              ),
            ),
            Positioned(
              top: 550.h, left: 75.w,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                width: 240.w, height: 55.h, text: "Save",
                textStyle: AppStyles.textStyle20w700AY.copyWith(color: Colors.white, fontSize: 16.sp),
                onPressed: saveBaby,
              ),
            ),
          ],
        ),
      ),
    );
  }
}