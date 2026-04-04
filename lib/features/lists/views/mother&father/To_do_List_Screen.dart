import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/appColor.dart';
import '../../../../core/utils/appIcons.dart';
import '../../../../core/utils/appImages.dart';
import '../../../../core/utils/appStyles.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../settings/mother/views/settings_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<bool> checked = List.generate(7, (_) => false);

  final List<String> tasks = [
    "Say goodbye to bad habits (smoking, alcohol, high caffeine intake)",
    "Confirm pregnancy (over-the-counter pregnancy test or HCG blood test)",
    "Prepare a list of questions for your first doctor's visit",
    "First prenatal visit blood tests: blood type and Rh, anemia, HCG, antibodies, immunity",
    "Say goodbye to bad habits (smoking, alcohol, high caffeine intake)",
    "Confirm pregnancy (over-the-counter pregnancy test or HCG blood test)",
    "Prepare a list of questions for your first doctor's visit",
  ];

  final TextEditingController addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6EA),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFFC5D0),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 65.h),

              /// Header
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "To-Do List",
                        style: AppStyles.textStyle20w700AY,
                      ),
                      CustomSvg(
                        path: AppIcons.task_list_pin,
                        width: 22.w,
                        height: 22.h,
                      ),
                    ],
                  ),
                  CustomSvg(
                    path: AppIcons.settings,
                    width: 24.w,
                    height: 24.h,
                    color: AppColors.Pinky,
                    onTap:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 55),

              Text(
                "First Trimester",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 24),

              ...List.generate(tasks.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() => checked[i] = !checked[i]);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: checked[i]
                                  ? const Color(0xFFB34962)
                                  : Colors.grey,
                              width: 2,
                            ),
                            color: checked[i]
                                ? const Color(0xFFB34962)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          tasks[i],
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.pink.shade200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: addController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add to-do",
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (addController.text.trim().isEmpty) return;

                        setState(() {
                          tasks.add(addController.text.trim());
                          checked.add(false);
                          addController.clear();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFB34962),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}