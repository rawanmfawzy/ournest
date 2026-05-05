import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ournest/core/utils/app_colors.dart';
import '../../../core/widgets/custom_buttom.dart';
import '../cubit/communitycubit.dart';

class AddPostSheet extends StatefulWidget {
  const AddPostSheet({super.key});

  @override
  State<AddPostSheet> createState() => _AddPostSheetState();
}

class _AddPostSheetState extends State<AddPostSheet> {
  final TextEditingController contentController = TextEditingController();
  File? imageFile;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 20,
        left: 16,
        right: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// Title
          const Text(
            "Create Post",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          /// Text Field
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: contentController,
              maxLines: 4,
              style: TextStyle(color: AppColors.Pinky),
              decoration: const InputDecoration(
                hintText: "What's on your mind?",
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// Image Preview
          if (imageFile != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    imageFile!,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        imageFile = null;
                      });
                    },
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close, size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 12),

          /// Actions
          Row(
            children: [

              /// Add Image Button (أحلى من icon لوحده)
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.Pinky),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.image, color: AppColors.Pinky),
                      const SizedBox(width: 6),
                      Text(
                        "Photo",
                        style: TextStyle(color: AppColors.Pinky),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              /// Post Button
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.Pinky,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
    onPressed: () {
    context.read<CommunityCubit>().createPost(
    content: contentController.text,
    category: "Baby Care",
      imageUrl: null,
    );

    Navigator.pop(context);
    },
                  child: const Text(
                    "Post",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}