import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../settings/mother/views/mather_settings.dart';
import '../../services/to_do_list/to_do_list_model.dart';
import '../../services/to_do_list/to_do_list_services.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  bool loading = true;

  final TextEditingController addController = TextEditingController();

  late String token;

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  /// GET
  void loadTodos() async {
    try {
      final data = await TodoService.getTodos(token);

      if (!mounted) return;

      setState(() {
        todos = data;
        loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());

      if (!mounted) return;
      setState(() => loading = false);
    }
  }

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
                  Text("To-Do List", style: AppStyles.textStyle20w700AY),
                  CustomSvg(
                    path: AppIcons.settings,
                    width: 24.w,
                    height: 24.h,
                    color: AppColors.Pinky,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              if (loading)
                const CircularProgressIndicator()
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, i) {
                      final todo = todos[i];

                      return ListTile(
                        onTap: () async {
                          await TodoService.toggleTodo(todo.id, token);
                          loadTodos(); // refresh from backend
                        },
                        leading: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: todo.isCompleted
                                ? const Color(0xFFB34962)
                                : Colors.transparent,
                            border: Border.all(
                              color: const Color(0xFFB34962),
                            ),
                          ),
                        ),
                        title: Text(todo.title),
                      );
                    },
                  ),
                ),

              /// ADD TODO
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
                        controller: addController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add to-do",
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (addController.text.isNotEmpty) {
                          await TodoService.addTodo(
                            addController.text,
                            token,
                          );

                          addController.clear();
                          loadTodos();
                        }
                      },
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFFB34962),
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    )
                  ],
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