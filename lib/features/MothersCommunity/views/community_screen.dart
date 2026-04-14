import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:ournest/core/utils/app_Styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_Icons.dart';
import '../../../../core/utils/app_Images.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../settings/mother/views/mather_settings.dart';
import '../cubit/communitycubit.dart';
import '../cubit/communitystate.dart';
import 'add_post_sheet.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CommunityCubit>().getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
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
            child: Column(
              children: [

                const SizedBox(height: 10),

                /// HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
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
                    suffix1: const Icon(Icons.search, color: Colors.black45),
                    suffix2: const Icon(Icons.tune, color: Colors.black45),
                    hintWidget: Text(
                      "Search for a post or person",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// FEED TITLE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Feed:",
                      style: AppStyles.textStyle14w400hints,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// FEED
                Expanded(
                  child: BlocBuilder<CommunityCubit, CommunityState>(
                    builder: (context, state) {

                      if (state is CommunityLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is CommunityError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }

                      if (state is CommunitySuccess) {
                        final posts = state.posts;

                        return ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          children: [

                            /// ADD POST (UI ثابت)
                            Container(
                              height: 32,
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.Pinky),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Add post",
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (_) => const AddPostSheet(),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.add_circle_outline,
                                      color: AppColors.Pinky,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// POSTS FROM API
                            ...posts.map((post) {
                              return _postCard(
                                id: post["id"],
                                user: post["authorName"] ?? "",
                                text: post["content"] ?? "",
                                image: post["imageUrl"],
                                likesCount: post["likesCount"] ?? 0,
                                commentsCount: post["commentsCount"] ?? 0,
                              );
                            }).toList(),

                            const SizedBox(height: 80),
                          ],
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// POST CARD (UI كما هو)
  Widget _postCard({
    required String id,
    required String user,
    required String text,
    String? image,
    required int likesCount,
    required int commentsCount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.Pinky.withValues(alpha: 0.3)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(Appimages.person_image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                user,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text(text),

          if (image != null && image.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],

          Divider(color: Colors.grey.shade300, height: 20),

          Row(
            children: [

              GestureDetector(
                onTap: () {
                  context.read<CommunityCubit>().likePost(id);
                },
                child: CustomSvg(
                  path: AppIcons.icons_favorite,
                  width: 18,
                  height: 18,
                ),
              ),

              const SizedBox(width: 4),
              Text("$likesCount"),

              const SizedBox(width: 20),

              GestureDetector(
                onTap: () {
                  _showCommentDialog(context, id);
                },
                child: CustomSvg(
                  path: AppIcons.message,
                  width: 18,
                  height: 18,
                ),
              ),

              const SizedBox(width: 4),
              Text("$commentsCount"),

              const Spacer(),

              CustomSvg(
                path: AppIcons.mdi_share_outline,
                width: 18,
                height: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// COMMENT DIALOG
void _showCommentDialog(BuildContext context, String postId) {
  final controller = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text("Add Comment"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Write comment...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<CommunityCubit>().addComment(
                postId,
                controller.text,
              );

              Navigator.pop(context);
            },
            child: const Text("Send"),
          ),
        ],
      );
    },
  );
}