import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ournest/core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../cubit/clinic_cubit.dart';

class ClinicDrawer extends StatefulWidget {
  const ClinicDrawer({super.key});

  @override
  State<ClinicDrawer> createState() => _ClinicDrawerState();
}

class _ClinicDrawerState extends State<ClinicDrawer> {
  List<dynamic> conversations = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final cubit = context.read<ClinicCubit>();
    final data = await cubit.fetchConversations();

    setState(() {
      conversations = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ClinicCubit>();

    return Drawer(
      backgroundColor:Color(0xFFFFE4EA),
      child: Column(
        children: [
          const SizedBox(height: 80),
          /// NEW CHAT BUTTON
          ListTile(
            leading: CustomSvg(
              path: AppIcons.new_chat,
              color: AppColors.Pinky,
            ),
            title: const Text("New Chat"),
            onTap: () async {
              Navigator.pop(context);
              await cubit.initConversation();
            },
          ),

          Divider(color:AppColors.Pinky ),

          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final item = conversations[index];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD6DE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading:  Icon(
                      Icons.history,
                      color: AppColors.Pinky,
                    ),

                    title: Text(
                      (item["messages"] is List &&
                          (item["messages"] as List).isNotEmpty)
                          ? (item["messages"] as List)
                          .first["content"]
                          : "New Chat",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    subtitle: (item["messages"] is List &&
                        (item["messages"] as List).isNotEmpty)
                        ? Text(
                      (item["messages"] as List).last["content"] ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    )
                        : null,

                    onTap: () {
                      Navigator.pop(context);
                      cubit.loadMessagesByConversation(item["id"]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}