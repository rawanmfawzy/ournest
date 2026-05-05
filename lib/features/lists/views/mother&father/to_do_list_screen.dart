import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../settings/mother/views/mather_settings.dart';
import '../../services/to_do_list/todocubit.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController addController = TextEditingController();

  late TodoCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<TodoCubit>();
    cubit.loadTodos();
  }

  @override
  void dispose() {
    addController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child:Scaffold(
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
        child: Column(
          children: [
            SizedBox(height: 65.h),

            /// HEADER
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
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
                  Text("To-Do List",
                      style: AppStyles.textStyle20w700AY),
                  CustomSvg(
                    path: AppIcons.settings,
                    width: 24.w,
                    height: 24.h,
                    color: AppColors.Pinky,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 45),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    // انتي هتحطي ال logic هنا بعدين
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.Pinky.withOpacity(0.01),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.Pinky),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 18,
                          color: AppColors.Pinky,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "Show all",
                          style: TextStyle(
                            color: AppColors.Pinky,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            /// TITLE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "First Trimester",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// LIST (FULL WIDTH)
            Expanded(
              child: BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.todos.isEmpty) {
                    return const Center(
                      child: Text("No todos yet"),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.todos.length,
                    itemBuilder: (context, i) {
                      final todo = state.todos[i];

                      return ListTile(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.w),

                        onTap: () => cubit.toggle(todo.id),

                        leading: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: todo.isCompleted
                                ? AppColors.Pinky
                                : Colors.white,
                            border: Border.all(
                              color: AppColors.Pinky,
                              width: 2,
                            ),
                          ),
                        ),

                        title: Text(
                          todo.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            /// ✅ SHARE CHECKBOX
                            Checkbox(
                              value: todo.sharedWithPartner ?? false,
                              activeColor: AppColors.Pinky,
                              onChanged: (val) {
                                context.read<TodoCubit>().share(todo.id, val!);
                              },
                            ),

                            /// 🗑 DELETE (بس لما يخلص التاسك)
                            if (todo.isCompleted)
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.Pinky,
                                ),
                                onPressed: () => cubit.delete(todo.id),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            /// INPUT
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
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

                        context.read<TodoCubit>()
                            .addTodo(addController.text.trim());

                        addController.clear();
                      },
                      child: Icon(Icons.add, color: AppColors.Pinky),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
        ),
    );
  }
}