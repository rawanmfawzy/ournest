import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Styles.dart';
import '../../../../core/widgets/custom_svg.dart';

import '../../services/medicines/medicines_ai_services.dart';

class MedicinesTap extends StatefulWidget {
  const MedicinesTap({super.key});

  @override
  State<MedicinesTap> createState() => _MedicinesTapState();
}

class _MedicinesTapState extends State<MedicinesTap> {
  final ImagePicker _picker = ImagePicker();
  final List<Message> messages = [];

  final MedicineService service = MedicineService();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (isLoading && index == messages.length) {
                  return bubble(
                    text: "",
                    isUser: false,
                    isLoading: true,
                  );
                }

                final msg = messages[index];

                if (msg.image != null) {
                  return imageBubble(msg.image!, msg.isUser);
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
                  padding:
                  EdgeInsets.symmetric(horizontal: 19.w, vertical: 13.h),
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
                          height: 28.h),
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

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    final file = File(image.path);

    setState(() {
      messages.add(Message(image: file, isUser: true));
      isLoading = true;
    });

    try {
      final result = await service.scanMedicine(file);

      if (!mounted) return;

      final data = result as Map<String, dynamic>;

      final message = data['formattedText'] ??
          data['result'] ??
          data['error'] ??
          data.toString();

      setState(() {
        isLoading = false;
        messages.add(Message(text: message, isUser: false));
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        messages.add(
          Message(
            text: e.toString(),
            isUser: false,
          ),
        );
      });
    }
  }

  Widget imageBubble(File image, bool isUser) {
    return Row(
      mainAxisAlignment:
      isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(6.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Image.file(
            image,
            width: 150.w,
            height: 150.h,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget bubble({
    required String text,
    required bool isUser,
    bool isLoading = false,
  }) {
    return Row(
      mainAxisAlignment:
      isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: 265.w),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isUser ? Colors.white : const Color(0x0FB34962),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
                bottomLeft: Radius.circular(isUser ? 0 : 8.r),
                bottomRight: Radius.circular(isUser ? 8.r : 0),
              ),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: isLoading
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TypingDots(),
                SizedBox(width: 10.w),
                Text(
                  "Analyzing...",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            )
                : Text(
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

class Message {
  final String? text;
  final File? image;
  final bool isUser;

  Message({this.text, this.image, required this.isUser});
}

class _TypingDots extends StatefulWidget {
  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    final delay = index * 0.2;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final value = (_controller.value + delay) % 1.0;

        final opacity = (value < 0.5) ? value * 2 : (1 - value) * 2;

        return Opacity(
          opacity: opacity,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            width: 5.w,
            height: 5.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildDot(0),
        _buildDot(1),
        _buildDot(2),
      ],
    );
  }
}