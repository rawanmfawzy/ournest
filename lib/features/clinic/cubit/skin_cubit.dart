import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/message_model.dart';
import '../services/skin/skin_ai_services.dart';
import '../services/skin/skinstate.dart';
class SkinCubit extends Cubit<SkinState> {
  final SkinAIService _service;

  SkinCubit(this._service) : super(const SkinState());

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

      final label = result['label'] ?? "Unknown";
      final confidence = (result['confidence'] ?? 0).toStringAsFixed(2);
      final description = result['description'] ?? "No description available";

      final botMessage = Message(
        text: "$label\nConfidence: $confidence\n\n$description",
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