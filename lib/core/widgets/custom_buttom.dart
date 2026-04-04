import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_svg.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final double borderRadius;
  final String? suffixAsset;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.textStyle,
    this.width,
    this.height,
    this.backgroundColor = const Color(0xFFB34962),
    this.borderRadius = 20,
    this.suffixAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w ?? 209.w,
      height: height?.h ?? 52.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
            if (suffixAsset != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomSvg(
                  path: suffixAsset!,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
