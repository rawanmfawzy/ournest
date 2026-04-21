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
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          TextField(
            controller: contentController,
            style:  TextStyle(
              color: AppColors.Pinky,
            ),
            decoration: const InputDecoration(
              hintText: "Write your post...",
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide.none,
              ),
            ),
            maxLines: 3,
          ),

          const SizedBox(height: 10),

          if (imageFile != null)
            Image.file(imageFile!, height: 100),

          const SizedBox(height: 10),

          Row(
            children: [
              IconButton(
                onPressed: pickImage,
                icon:  Icon(Icons.image,color: AppColors.Pinky,),
              ),

              const Spacer(),

              CustomButton(
                text: "Post",
                onPressed: () {
                  context.read<CommunityCubit>().createPost(
                    content: contentController.text,
                    category: "Baby Care",
                    imageUrl: null, // هنضيف رفع بعدين لو عندك API
                  );
                  Navigator.pop(context);
                },
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                width: 100,
                height: 40,
                backgroundColor: const Color(0xFFB34962),
                borderRadius: 6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}