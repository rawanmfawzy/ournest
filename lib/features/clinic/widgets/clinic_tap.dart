import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/appIcons.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/utils/appStyles.dart';
import '../cubit/clinic_cubit.dart';
import '../models/message_model.dart';

class ClinicTab extends StatefulWidget {
  const ClinicTab({super.key});

  @override
  State<ClinicTab> createState() => _ClinicTabState();
}

class _ClinicTabState extends State<ClinicTab> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicCubit, ClinicState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
          Expanded(
          child: ListView.separated(
          padding: const EdgeInsets.all(15),
          itemCount: state.messages.length,
          itemBuilder: (context, index) {
            final msg = state.messages[index];
            return bubble(
              text: msg.text ?? "",
              isUser: msg.isUser,
            );
          },
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
        ),
        ),

              Container(
                width: 334.w,
                constraints: BoxConstraints(minHeight: 87.h),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.pink.shade100, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Ask your questions..",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: InputBorder.none,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          final text = controller.text.trim();
                          if (text.isEmpty) return;
                          controller.clear();
                          context.read<ClinicCubit>().sendMessage(text);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade50,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.send, size: 16.sp, color: Colors.grey),
                              SizedBox(width: 4.w),
                              Text(
                                "Send",
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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
}