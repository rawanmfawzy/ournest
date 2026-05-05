import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Styles.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../cubit/skin_cubit.dart';
import '../../services/skin/skinstate.dart';

class SkinTab extends StatefulWidget {
  const SkinTab({super.key});

  @override
  State<SkinTab> createState() => _SkinTabState();
}

class _SkinTabState extends State<SkinTab> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkinCubit, SkinState>(
      builder: (context, state) {
        return Column(
          children: [
            /// ================= CHAT LIST =================
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(10),
                itemCount: state.messages.length + (state.isSending ? 1 : 0),
                itemBuilder: (context, index) {
                  if (state.isSending && index == state.messages.length) {
                    return bubble(
                      text: "",
                      isUser: false,
                      isLoading: true,
                    );
                  }

                  final msg = state.messages[index];

                  if (msg.image != null) return imageBubble(msg.image!);

                  if (msg.text != null) {
                    return bubble(text: msg.text!, isUser: msg.isUser);
                  }

                  return const SizedBox.shrink();
                },
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
              ),
            ),

            /// ================= ERROR =================
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            /// ================= ATTACH BUTTON =================
            Padding(
              padding: EdgeInsets.all(10),
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
        );
      },
    );
  }

  /// ================= PICK IMAGE =================
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (!mounted) return;

    if (image != null) {
      context.read<SkinCubit>().sendImage(File(image.path));
    }
  }

  /// ================= IMAGE BUBBLE =================
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

  /// ================= TEXT + LOADING BUBBLE =================
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

/// ================= TYPING DOTS =================
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

  Widget _dot(int i) {
    final delay = i * 0.2;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final value = (_controller.value + delay) % 1.0;
        final opacity = value < 0.5 ? value * 2 : (1 - value) * 2;

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
        _dot(0),
        _dot(1),
        _dot(2),
      ],
    );
  }
}