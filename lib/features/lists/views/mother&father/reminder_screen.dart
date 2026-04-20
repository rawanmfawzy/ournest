import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../../core/widgets/custom_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../settings/mother/views/mather_settings.dart';
import '../../services/reminder/remindercubit.dart';
import '../../services/reminder/remindermodel.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final TextEditingController reminderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ReminderCubit>().loadReminders();
  }

  Future<void> selectDate(BuildContext context, String text) async {
    DateTime now = DateTime.now();

    final DateTime? pickedDate = await showDialog<DateTime>(
      context: context,
      builder: (context) => _DatePickerPopup(initial: now),
    );

    if (pickedDate != null) {
      await context
          .read<ReminderCubit>()
          .addReminder(text, pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xFFFFC5D0),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(Appimages.person_image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text(
                        "Reminder To Me",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingsScreen(),
                            ),
                          );
                        },
                        icon: CustomSvg(
                          path: AppIcons.settings,
                          width: 24.w,
                          height: 24.h,
                          color: AppColors.Pinky,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Remember me",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// INPUT
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.pink.shade200),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: reminderController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Add a reminder",
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            String text =
                            reminderController.text.trim();
                            if (text.isEmpty) return;

                            selectDate(context, text);
                            reminderController.clear();
                          },
                          child: CustomSvg(
                            path: AppIcons.add,
                            width: 24.w,
                            height: 24.h,
                            color: AppColors.Pinky,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// LIST
                  Expanded(
                    child: BlocBuilder<ReminderCubit,
                        List<ReminderModel>>(
                      builder: (context, reminders) {
                        if (reminders.isEmpty) {
                          return const Center(
                            child: Text("No reminders yet"),
                          );
                        }

                        return ListView.builder(
                          padding:
                          const EdgeInsets.only(bottom: 40),
                          itemCount: reminders.length,
                          itemBuilder: (context, index) {
                            final item = reminders[index];

                            return Container(
                              margin:
                              const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppColors.Pinky),
                              ),
                              child: Row(
                                children: [

                                  /// TITLE
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight:
                                        FontWeight.w600,
                                        decoration:
                                        item.isCompleted
                                            ? TextDecoration
                                            .lineThrough
                                            : null,
                                      ),
                                    ),
                                  ),

                                  /// DATE
                                  Text(
                                    "${item.reminderDateTime.day}-${item.reminderDateTime.month}",
                                    style: const TextStyle(
                                        fontSize: 13),
                                  ),
                                  /// COMPLETE
                                  IconButton(
                                    icon: const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<
                                          ReminderCubit>()
                                          .completeReminder(
                                          item.id);
                                    },
                                  ),

                                  /// DELETE
                                  IconButton(
                                    icon:  Icon(
                                      Icons.delete,
                                      color:
                                      AppColors.Pinky,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<
                                          ReminderCubit>()
                                          .deleteReminder(
                                          item.id);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DatePickerPopup extends StatefulWidget {
  final DateTime initial;

  const _DatePickerPopup({required this.initial});

  @override
  State<_DatePickerPopup> createState() =>
      _DatePickerPopupState();
}

class _DatePickerPopupState extends State<_DatePickerPopup> {
  late DateTime selectedDate;
  final now = DateTime.now();
  @override
  void initState() {
    super.initState();
    selectedDate = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(
              "Select a reminder date.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.Pinky
              ),
            ),
            SizedBox(
              height: 280,
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.Pinky, // لون اليوم المختار
                    onPrimary: Colors.white,   // لون رقم اليوم المختار
                    onSurface: Colors.black,   // باقي الأرقام
                  ),
                ),
                child: CalendarDatePicker(
                  initialDate: selectedDate.isBefore(now) ? now : selectedDate,
                  firstDate: now,
                  lastDate: DateTime(2030),
                  onDateChanged: (date) {
                    if (date.isBefore(now)) return;
                    setState(() => selectedDate = date);
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedDate);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.Pinky,
              ),
              child:  Text("Select Date",style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}