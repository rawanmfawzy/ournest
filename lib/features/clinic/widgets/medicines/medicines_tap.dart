import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Styles.dart';
import '../../../../core/widgets/custom_svg.dart';

class MedicinesTap extends StatefulWidget {
  const MedicinesTap({super.key});

  @override
  State<MedicinesTap> createState() => _MedicinesTapState();
}

class _MedicinesTapState extends State<MedicinesTap> {
  final ImagePicker _picker = ImagePicker();

  // بدل الـ Cubit
  final List<_Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                if (msg.image != null) {
                  return imageBubble(msg.image!);
                } else {
                  return bubble(
                    text: msg.text ?? "",
                    isUser: msg.isUser,
                  );
                }
              },
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
            ),
          ),

          // attach button
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: pickImage,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12.r),
                color: AppColors.Pinky,
                strokeWidth: 1.5,
                dashPattern: const [6, 4],
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 19.w,
                    vertical: 13.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomSvg(
                        path: AppIcons.attechment,
                        width: 28.w,
                        height: 28.h,
                      ),
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
      ),
    );
  }

  // pick image
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (!mounted) return;

    if (image != null) {
      setState(() {
        messages.add(
          _Message(image: File(image.path), isUser: true),
        );
      });
    }
  }

  // image bubble
  Widget imageBubble(File imageFile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Image.file(
            imageFile,
            width: 150.w,
            height: 150.h,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  // text bubble
  Widget bubble({required String text, required bool isUser}) {
    return Row(
      mainAxisAlignment:
      isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: 265.w),
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: isUser ? Colors.white : const Color(0x0FB34962),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
                bottomLeft: Radius.circular(isUser ? 0 : 8.r),
                bottomRight: Radius.circular(isUser ? 8 : 0),
              ),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Text(
              text,
              style: AppStyles.textStyle20w700AY.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(width: 5.w),
        if (!isUser)
          CustomSvg(
            path: AppIcons.chatbot,
            width: 28.w,
            height: 28.h,
          ),
      ],
    );
  }
}

// simple model بدل الـ Cubit
class _Message {
  final String? text;
  final File? image;
  final bool isUser;

  _Message({
    this.text,
    this.image,
    required this.isUser,
  });
}