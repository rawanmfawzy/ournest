import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ournest/core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../cubit/clinic_cubit.dart';
import '../../cubit/skin_cubit.dart';
import '../../services/skin/skinstate.dart';

class ClinicDrawer extends StatefulWidget {
  final int tabIndex;

  const ClinicDrawer({super.key, required this.tabIndex});

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

  /// ================= LOAD CLINIC HISTORY =================
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
    final isSkin = widget.tabIndex == 3;

    return Drawer(
      backgroundColor: const Color(0xFFFFE4EA),
      child: Column(
        children: [
          const SizedBox(height: 80),

          /// ================= NEW CHAT =================
          ListTile(
            leading: CustomSvg(
              path: AppIcons.new_chat,
              color: AppColors.Pinky,
            ),
            title: const Text("New Chat"),
            onTap: () async {
              Navigator.pop(context);

              if (isSkin) {
                context.read<SkinCubit>().clearChat();
              } else {
                await context.read<ClinicCubit>().initConversation();
              }
            },
          ),

          Divider(color: AppColors.Pinky),

          /// ================= HISTORY =================
          Expanded(
            child: buildClinicHistory(),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // 🧠 CLINIC HISTORY
  // =========================================================
  Widget buildClinicHistory() {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final item = conversations[index];

        return Container(
          margin:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD6DE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Icon(
              Icons.history,
              color: AppColors.Pinky,
            ),
            title: Text(
              (item["messages"] is List &&
                  (item["messages"] as List).isNotEmpty)
                  ? (item["messages"] as List).first["content"]
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
              context
                  .read<ClinicCubit>()
                  .loadMessagesByConversation(item["id"]);
            },
          ),
        );
      },
    );
  }

}