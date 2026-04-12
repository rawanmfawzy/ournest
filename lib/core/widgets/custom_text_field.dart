import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_Styles.dart';
class CustomTextField extends StatefulWidget {
  final String label;
  final Widget? hintWidget;
  final Widget? suffix1;
  final Widget? suffix2;
  final TextEditingController? controller; // خليها nullable
  final double? width;
  final double? height;
  final double fontSize;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintWidget,
    this.suffix1,
    this.suffix2,
    this.width,
    this.height,
    this.fontSize = 14,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    // لو ما فيش controller من برة، نعمل واحد داخلي
    _internalController = widget.controller ?? TextEditingController();
    _internalController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // نمسح الـ controller الداخلي لو عملناه هنا
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppStyles.textStyle20w700AY.copyWith(
            color: AppColors.Pinky,
            fontSize: widget.fontSize.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? 55.h,
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: AppColors.Pinky),
          ),
          child: Row(
            children: [
              if (widget.suffix1 != null) widget.suffix1!,
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    if (_internalController.text.isEmpty &&
                        widget.hintWidget != null)
                      Positioned(
                        left: 0,
                        child: widget.hintWidget!,
                      ),
                    TextField(
                      controller: _internalController,
                      obscureText: widget.obscureText,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: AppColors.Pinky,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.suffix2 != null) widget.suffix2!,
            ],
          ),
        ),
      ],
    );
  }
}
