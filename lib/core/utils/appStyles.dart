import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppStyles {
  static final textStyle20w700AY = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'Poppins',
    fontFamilyFallback: const ['Roboto'],
    letterSpacing: 0,
  );
  static final textStylenumoftracking = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  fontFamily: 'Inter',
  fontFamilyFallback: const ['Roboto'],
  letterSpacing: 0,
  );
  static final textStyle14w400hints = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    fontFamilyFallback: const ['Regular'],
    letterSpacing: 0,
  );
  static final textStyle50w400ournest = TextStyle(
    fontSize: 50.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'Pacifico',
    fontFamilyFallback: const ['Regular'],
    letterSpacing: 0,
  );
  static final textStyle14w500Alex = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'Alexandria',
    fontFamilyFallback: const ['Regular'],
    letterSpacing: 0,
  );
}