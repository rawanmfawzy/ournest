import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/cubit/token_storage_helper.dart';
import '../models/message_model.dart';
import '../services/clinic/clinic_ai_services.dart';
import '../services/clinic/clinic_state.dart';

class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit() : super(const ClinicState());

  final ClinicAIService _service = ClinicAIService();

  String? conversationId;

  /// INIT
  Future<void> initConversation() async {
    try {
      conversationId = null;
      emit(state.copyWith(messages: [], conversationId: null));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// SEND MESSAGE (FINAL STABLE)
  Future<void> sendMessage(String text) async {
    try {
      final userMsg = Message(text: text, isUser: true);
      final updated = [...state.messages, userMsg];

      emit(state.copyWith(
        messages: updated,
        isSending: true,
        error: null,
      ));

      // 🔥 CREATE ONLY IF FIRST MESSAGE
      if (conversationId == null) {
        conversationId = await _service.createConversation();
      }

      final aiResponse = await _service.sendMessage(
        conversationId: conversationId!,
        content: text,
      );

      final aiMsg = Message(text: aiResponse, isUser: false);

      emit(state.copyWith(
        messages: [...updated, aiMsg],
        isSending: false,
      ));
    } catch (e) {
      emit(state.copyWith(isSending: false, error: e.toString()));
    }
  }
  Future<void> loadHistory() async {
    try {
      final history = await _service.getHistory();

      if (history.isEmpty) return;

      // ناخد آخر conversation
      final lastConversation = history.first;

      conversationId = lastConversation["id"];

      final messagesFromApi = lastConversation["messages"] ?? [];

      final loadedMessages = messagesFromApi.map<Message>((msg) {
        return Message(
          text: msg["content"] ?? "",
          isUser: msg["role"] == "user",
        );
      }).toList();

      emit(state.copyWith(
        messages: loadedMessages,
        conversationId: conversationId,
        isInitialized: true,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
  Future<List<dynamic>> fetchConversations() async {
    try {
      final data = await _service.getConversations();
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<void> loadMessagesByConversation(String id) async {
    try {
      final messagesFromApi =
      await _service.getMessagesByConversation(id);

      final loadedMessages = messagesFromApi.map<Message>((msg) {
        return Message(
          text: msg["content"] ?? "",
          isUser: msg["role"] == "user",
        );
      }).toList();

      conversationId = id;

      emit(state.copyWith(
        messages: loadedMessages,
        conversationId: id,
        isInitialized: true,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}