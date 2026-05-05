import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Styles.dart';
import '../cubit/baby_care_cubit.dart';
import '../cubit/baby_care_state.dart';

class BabyCareDetailPage extends StatefulWidget {
  /// type: 'feeding' | 'vitamins' | 'vaccinations'
  final String type;
  final String? babyAge;
  final String title;

  const BabyCareDetailPage({
    super.key,
    required this.type,
    required this.title,
    this.babyAge,
  });

  @override
  State<BabyCareDetailPage> createState() => _BabyCareDetailPageState();
}

class _BabyCareDetailPageState extends State<BabyCareDetailPage> {
  late BabyCareCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BabyCareCubit()..loadByType(widget.type, age: widget.babyAge);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: AppColors.Pinky,
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(
              color: AppColors.Pinky,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
          ),
        ),
        body: BlocBuilder<BabyCareCubit, BabyCareState>(
          builder: (context, state) {
            if (state is BabyCareLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.Pinky),
              );
            }

            if (state is BabyCareError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: AppColors.Pinky, size: 56.sp),
                      SizedBox(height: 16.h),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyle14w400hints.copyWith(fontSize: 14.sp),
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.Pinky,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () =>
                            _cubit.loadByType(widget.type, age: widget.babyAge),
                        child: const Text('Try Again',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is BabyCareLoaded) {
              return _buildContent(state.data, state.type);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(Map<String, dynamic> data, String type) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFFFFC5D0)],
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page header badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.Pinky.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                _typeLabel(type),
                style: TextStyle(
                  color: AppColors.Pinky,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _buildDataWidgets(data),
          ],
        ),
      ),
    );
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'feeding':
        return '🍼  Feeding Guidelines';
      case 'vitamins':
        return '💊  Vitamin Recommendations';
      case 'vaccinations':
        return '💉  Vaccination Schedule';
      default:
        return '📋  Baby Care Info';
    }
  }

  Widget _buildDataWidgets(Map<String, dynamic> data) {
    String content = "";
    
    // Simplified logic to extract text from JSON
    void extractText(dynamic val, [String? prefix]) {
      if (val is List) {
        for (var item in val) {
          extractText(item);
        }
      } else if (val is Map) {
        val.forEach((k, v) {
          if (k == 'title' || k == 'name' || k == 'importance') {
             content += "\n• ${v.toString().toUpperCase()}\n";
          } else if (v is List || v is Map) {
            extractText(v, _formatKey(k));
          } else {
            content += "  ${_formatKey(k)}: ${v.toString()}\n";
          }
        });
        content += "\n";
      } else {
        content += "${prefix != null ? "$prefix: " : ""}${val.toString()}\n";
      }
    }

    extractText(data);

    if (content.trim().isEmpty) {
      content = "No specific tips found for this age.";
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.Pinky.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.Pinky.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.Pinky, size: 24.sp),
              SizedBox(width: 10.w),
              Text(
                "Age-Based Tips (${widget.babyAge} Months)",
                style: TextStyle(
                  color: AppColors.Pinky,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(height: 30.h, color: AppColors.Pinky.withOpacity(0.1)),
          Text(
            content.trim(),
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
              height: 1.6,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required String label, required Widget child}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.Pinky.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.Pinky,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }

  Widget _bulletItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h, right: 8.w),
            child: Container(
              width: 6.w,
              height: 6.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.Pinky,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppStyles.textStyle14w400hints.copyWith(
                fontSize: 13.sp,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _keyValueRow(String key, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_formatKey(key)}: ',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.Pinky,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppStyles.textStyle14w400hints.copyWith(
                fontSize: 13.sp,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatKey(String key) {
    // camelCase → Title Case with spaces
    final result = key.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (m) => ' ${m.group(0)}',
    );
    return result.trim().replaceFirst(
      result.trim()[0],
      result.trim()[0].toUpperCase(),
    );
  }
}
