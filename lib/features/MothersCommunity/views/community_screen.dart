import 'package:flutter/material.dart';
import '../../../core/utils/appColor.dart';
import '../../../core/utils/appIcons.dart';
import '../../../core/utils/appImages.dart';
import '../../../core/utils/appStyles.dart';
import '../../../core/widgets/custom_svg.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../settings/mother/views/settings_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
                       onTap:() {
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (_) => SettingsScreen()),
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
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Feed:",
                      style: AppStyles.textStyle14w400hints
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// FEED CONTENT
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    children: [
                      /// ADD POST
                      Container(
                        height: 32,
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.Pinky),
                          color: Colors.white,
                        ),
                        child:  Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Add post",
                                style: TextStyle(color: Colors.black45),
                              ),
                            ),
                            Icon(Icons.add_circle_outline,
                                color: AppColors.Pinky),
                          ],
                        ),
                      ),

                      /// POSTS
                      _postCard(
                        user: "Mariam Ali",
                        text:
                        "A balanced diet rich in folate and iron is crucial for expectant mothers and it is important to stay well-hydrated by drinking plenty of water throughout the day",
                      ),

                      _postCard(
                        user: "Mariam Ali",
                        text:
                        "A balanced diet rich in folate and iron is crucial for expectant mothers and it is important to stay well-hydrated by drinking plenty of water throughout the day",
                        image: Appimages.babyfeed,
                      ),

                      _postCard(
                        user: "Mariam Ali",
                        text:
                        "A balanced diet rich in folate and iron is crucial for expectant mothers and it is important to stay well-hydrated by drinking plenty of water throughout the day",
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// POST CARD
  Widget _postCard({
    required String user,
    required String text,
    String? image,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.Pinky.withOpacity(.3)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// USER
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
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          /// TEXT
          Text(text),

          /// IMAGE
          if (image != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],

          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
            height: 20,
          ),

          /// ACTIONS
           Row(
            children: [
              CustomSvg(
                path: AppIcons.icons_favorite,
                width: 18,
                height: 18,

              ),
              SizedBox(width: 4),
              Text("16"),
              SizedBox(width: 20),
              CustomSvg(
                path: AppIcons.message,
                width: 18,
                height: 18,

              ),
              SizedBox(width: 4),
              Text("2"),
              Spacer(),
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