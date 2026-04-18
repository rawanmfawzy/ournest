import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/cubit/token_storage_helper.dart';
import '../models/message_model.dart';
import '../services/clinic_ai_services.dart';
import '../services/clinic_state.dart';

class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit() : super(const ClinicState());

  final ClinicAIService _service = ClinicAIService();

  String? conversationId;

  /// INIT
  Future<void> initConversation() async {
    try {
      if (conversationId != null) return;

      conversationId = await _service.createConversation();

      emit(state.copyWith(
        conversationId: conversationId,
        isInitialized: true,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// SEND MESSAGE (FINAL STABLE)
  Future<void> sendMessage(String text) async {
    try {
      final userMsg = Message(
        text: text,
        isUser: true,
      );

      final updated = [...state.messages, userMsg];

      emit(state.copyWith(
        messages: updated,
        isSending: true,
        error: null,
      ));

      // 🔥 ensure conversation exists
      if (conversationId == null) {
        conversationId = await _service.createConversation();
      }

      if (conversationId == null) {
        emit(state.copyWith(isSending: false));
        return;
      }

      // 🔥 send message
      final aiResponse = await _service.sendMessage(
        conversationId: conversationId!,
        content: text,
      );

      final aiMsg = Message(
        text: aiResponse,
        isUser: false,
      );

      emit(state.copyWith(
        messages: [...updated, aiMsg],
        isSending: false,
      ));
    } catch (e) {
      final errorMsg = Message(
        text: "Sorry, AI is currently unavailable. Try again later.",
        isUser: false,
      );
      print("AI ERROR: $e");
      emit(state.copyWith(
        messages: [...state.messages, errorMsg],
        isSending: false,
        error: e.toString(),
      ));
    }
  }
}