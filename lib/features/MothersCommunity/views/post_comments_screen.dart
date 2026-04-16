import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ournest/core/utils/app_colors.dart';
import '../../../core/utils/app_Icons.dart';
import '../../../core/utils/app_Styles.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../settings/mother/views/mather_settings.dart';
import '../cubit/commentscubit.dart';
import '../cubit/communitycubit.dart';
import '../cubit/communitystate.dart';
import '../../../../core/utils/app_Images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCommentsScreen extends StatelessWidget {
  final Map post;

  const PostCommentsScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommentsCubit(),
      child: _PostCommentsBody(post: post),
    );
  }
}
class _PostCommentsBody extends StatefulWidget {
  final Map post;

  const _PostCommentsBody({required this.post});

  @override
  State<_PostCommentsBody> createState() => _PostCommentsBodyState();
}
class _PostCommentsBodyState extends State<_PostCommentsBody> {
  late TextEditingController controller;
  late String postId;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    postId = widget.post["id"].toString();

    /// ✅ تحميل الكومنتات
    Future.microtask(() {
      context.read<CommentsCubit>().getComments(postId);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFFC5D0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [

                const SizedBox(height: 10),

                /// HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                        AssetImage(Appimages.person_image),
                      ),

                      const Text(
                        "Mothers’ Community",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

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
                ),

                /// SEARCH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomTextField(
                    label: "",
                    height: 40.h,
                    suffix1: const Icon(Icons.search),
                    suffix2: const Icon(Icons.tune),
                    hintWidget: Text(
                      "Search for a post or person",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// POST
                _postCard(context, widget.post),

                const Divider(),

                /// COMMENTS
                Expanded(
                  child: BlocBuilder<CommentsCubit, CommunityState>(
                    builder: (context, state) {

                      if (state is CommunityLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (state is CommunityError) {
                        return Center(child: Text(state.message));
                      }

                      if (state is CommentsSuccess) {
                        final comments = state.comments;

                        return ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 18,
                                  backgroundImage:
                                  AssetImage(Appimages.person_image),
                                ),
                                const SizedBox(width: 10),

                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment["authorName"] ?? "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(comment["content"] ?? ""),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),

                /// INPUT
                _commentInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ================= POST =================
  Widget _postCard(BuildContext context, Map post) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.Pinky.withValues(alpha: 0.3),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              const CircleAvatar(
                backgroundImage:
                AssetImage(Appimages.person_image),
              ),
              const SizedBox(width: 8),
              Text(widget.post["authorName"] ?? ""),
            ],
          ),

          const SizedBox(height: 6),
          Text(widget.post["content"] ?? ""),

          const SizedBox(height: 10),

          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<CommunityCubit>().likePost(widget.post["id"]);
                },
                child: CustomSvg(
                  path: AppIcons.icons_favorite,
                  width: 18,
                  height: 18,
                ),
              ),
              const SizedBox(width: 4),
              Text("${widget.post["likesCount"] ?? 0}"),
            ],
          ),
        ],
      ),
    );
  }

  /// ================= INPUT =================
  Widget _commentInput() {
    return Container(
      width: double.infinity,
      height: 89,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC5D0),
        border: Border.all(
          width: 1,
          color: AppColors.Pinky,
        ),
      ),
      child: Container(
        height: 39,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFFFC5D0),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: "Write a comment...",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            border: InputBorder.none,

            /// send icon
            suffixIcon: GestureDetector(
              onTap: () async {
                if (controller.text.trim().isEmpty) return;

                await context.read<CommentsCubit>().addComment(
                  postId,
                  controller.text,
                );

                controller.clear();

                /// ✅ refresh
                context.read<CommentsCubit>().getComments(postId);
              },
              child: Icon(
                Icons.send,
                color: AppColors.Pinky,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}