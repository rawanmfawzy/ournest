import 'dart:io';

class Message {
  final String? text;
  final File? image;
  final bool isUser;

  Message({this.text, this.image, required this.isUser});
}
