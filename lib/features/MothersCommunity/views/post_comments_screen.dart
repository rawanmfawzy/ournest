import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ournest/core/utils/app_colors.dart';
import 'package:ournest/core/utils/time_ago.dart';
import '../../../core/utils/app_Icons.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../settings/mother/views/mather_settings.dart';
import '../cubit/commentscubit.dart';
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
  FocusNode? focusNode;
  late String postId;

  String? replyingToCommentId;
  Map<String, bool> showReplies = {};

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    focusNode = FocusNode();
    postId = widget.post["id"].toString();

    Future.microtask(() {
      context.read<CommentsCubit>().getComments(postId);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CommentsCubit>();

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
                        backgroundImage: AssetImage(Appimages.person_image),
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
                _postCard(widget.post),

                const Divider(),

                /// COMMENTS
                Expanded(
                  child: BlocBuilder<CommentsCubit, CommunityState>(
                    builder: (context, state) {
                      if (state is CommunityLoading) {
                        return const Center(child: CircularProgressIndicator());
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
                            final commentId = comment["id"].toString();
                            final replies = cubit.replies[commentId];
                            final isShown = showReplies[commentId] ?? false;
                            final createdAt = DateTime.parse(
                              comment["createdAt"].toString(),
                            ).toLocal();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  comment["authorName"] ?? "",
                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                ),

                                                const SizedBox(width: 8),

                                                Text(
                                                  createdAt != null ? createdAt.timeAgo() : "just now",
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),

                                            Text(comment["content"] ?? ""),

                                            const SizedBox(height: 8),

                                            /// Reply
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  replyingToCommentId = commentId;
                                                });

                                                controller.clear();
                                                FocusScope.of(context)
                                                    .requestFocus(focusNode ?? FocusNode());
                                              },
                                              child: const Text(
                                                "Reply",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 6),

                                            /// Toggle Replies
                                            GestureDetector(
                                              onTap: () async {
                                                if (isShown) {
                                                  setState(() {
                                                    showReplies[commentId] = false;
                                                  });
                                                } else {
                                                  await context
                                                      .read<CommentsCubit>()
                                                      .getReplies(commentId);

                                                  if (!mounted) return;

                                                  setState(() {
                                                    showReplies[commentId] = true;
                                                  });
                                                }
                                              },
                                              child: Text(
                                                isShown ? "Hide replies" : "View replies",
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),

                                            /// Replies
                                            if (isShown && replies != null)
                                              Column(
                                                children: replies.map<Widget>((reply) {
                                                  final replyTime = DateTime.parse(
                                                    reply["createdAt"].toString(),
                                                  ).toLocal();
                                                  return Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 24, top: 8),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 2,
                                                          height: 40,
                                                          margin: const EdgeInsets.only(
                                                              right: 5),
                                                          color: Colors.grey.shade300,
                                                        ),
                                                        const CircleAvatar(
                                                          radius: 12,
                                                          backgroundImage: AssetImage(
                                                              Appimages.person_image),
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Expanded(
                                                          child: Container(
                                                            padding:
                                                            const EdgeInsets.all(6),
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey.shade100,
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  12),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  reply["authorName"] ??
                                                                      "Unknown",
                                                                  style:
                                                                  const TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 3),
                                                                Text(
                                                                  reply["content"] ?? "",
                                                                  style:
                                                                  const TextStyle(
                                                                    fontSize: 13,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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

  Widget _postCard(Map post) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
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
                backgroundImage: AssetImage(Appimages.person_image),
              ),
              const SizedBox(width: 8),
              Text(post["authorName"] ?? ""),
            ],
          ),
          const SizedBox(height: 6),
          Text(post["content"] ?? ""),
        ],
      ),
    );
  }

  Widget _commentInput() {
    return Container(
      width: double.infinity,
      height: 89,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC5D0),
        border: Border.all(width: 1, color: AppColors.Pinky),
      ),
      child: Container(
        height: 39,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: replyingToCommentId != null
                ? "Write a reply..."
                : "Write a comment...",
            border: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: () async {
                if (controller.text.trim().isEmpty) return;

                if (replyingToCommentId != null) {
                  final id = replyingToCommentId!;
                  await context
                      .read<CommentsCubit>()
                      .addReply(id, controller.text);

                  await context.read<CommentsCubit>().getReplies(id);
                  replyingToCommentId = null;
                } else {
                  await context
                      .read<CommentsCubit>()
                      .addComment(postId, controller.text);
                }

                controller.clear();

                if (!mounted) return;

                context.read<CommentsCubit>().getComments(postId);
              },
              child: Icon(
                Icons.send,
                color: AppColors.Pinky,
              ),
            ),
          ),
        ),
      ),
    );
  }
}