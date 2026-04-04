import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/appColor.dart';
import '../../../core/utils/appIcons.dart';
import '../../../core/utils/appStyles.dart';
import '../../../core/widgets/custom_svg.dart';
import '../cubit/feeding_cubit.dart';
/// --- UI Feeding Tab ---
class FeedingTab extends StatefulWidget {
  const FeedingTab({super.key});

  @override
  State<FeedingTab> createState() => _FeedingTabState();
}

class _FeedingTabState extends State<FeedingTab> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedingCubit, FeedingState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(10),
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  final msg = state.messages[index];
                  if (msg.image != null) return imageBubble(msg.image!);
                  if (msg.text != null) return bubble(text: msg.text!, isUser: msg.isUser); // هنا
                  return SizedBox.shrink();
                },
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: pickImage,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12.r),
                  color: AppColors.Pinky,
                  strokeWidth: 1.5,
                  dashPattern: [6, 4],
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 13.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomSvg(path: AppIcons.attechment, width: 28.w, height: 28.h),
                        SizedBox(width: 6.w),
                        Text(
                          "Attach",
                          style: AppStyles.textStyle20w700AY.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.Pinky,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// اختيار صورة وتحديد modelType
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      // اختاري النوع الصحيح حسب الصورة
      String modelType = "food"; // أو "skin" حسب الحالة
      context.read<FeedingCubit>().addImage(File(image.path), modelType);
    }
  }

  Widget imageBubble(File imageFile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Image.file(imageFile, width: 150.w, height: 150.h, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}

Widget bubble({required String text, required bool isUser}) {
  return Row(
    mainAxisAlignment: isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flexible(
        child: Container(
          constraints: BoxConstraints(maxWidth: 265.w),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isUser ? Colors.white : Color(0x0FB34962),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
              bottomLeft: Radius.circular(isUser ? 0 : 8.r),
              bottomRight: Radius.circular(isUser ? 8.r : 0),
            ),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Text(
            text,
            style: AppStyles.textStyle20w700AY.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      SizedBox(width: 5.w),
      if (!isUser)
        CustomSvg(path: AppIcons.chatbot, width: 28.w, height: 28.h),
    ],
  );
}
