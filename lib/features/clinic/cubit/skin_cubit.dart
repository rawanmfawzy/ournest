import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/message_model.dart';
import '../services/skin/skin_ai_services.dart';
import '../services/skin/skinstate.dart';

class SkinCubit extends Cubit<SkinState> {
  final SkinAIService _service;

  SkinCubit(this._service) : super(const SkinState());

  /// 🧠 حماية من null أو empty
  String _safe(dynamic value) {
    if (value == null) return 'Not available';
    if (value.toString().trim().isEmpty) return 'Not available';
    return value.toString();
  }

  /// 🧾 Formatting حسب الـ backend الحقيقي
  String _formatSkinResponse(Map<String, dynamic> json) {
    final label = _safe(json['label']);
    final description = _safe(json['description']);

    return '''
🧾 Label: $label

🧠 Description:
$description
''';
  }

  Future<void> sendImage(File image) async {
    final userMessage = Message(
      image: image,
      isUser: true,
    );

    emit(state.copyWith(
      messages: [...state.messages, userMessage],
      isSending: true,
      error: null,
    ));

    try {
      final result = await _service.analyzeImage(image);

      print("FULL RESPONSE: $result");

      final botMessage = Message(
        text: _formatSkinResponse(result),
        isUser: false,
      );

      emit(state.copyWith(
        messages: [...state.messages, botMessage],
        isSending: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSending: false,
        error: e.toString(),
      ));
    }
  }

  void clearChat() {
    emit(const SkinState());
  }
}