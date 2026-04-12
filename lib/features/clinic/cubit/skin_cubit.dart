import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/message_model.dart';
import '../services/skin_ai_services.dart';

class SkinState extends Equatable {
  final List<Message> messages;
  final bool isSending;

  const SkinState({this.messages = const [], this.isSending = false});

  SkinState copyWith({List<Message>? messages, bool? isSending}) {
    return SkinState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }

  @override
  List<Object> get props => [messages, isSending];
}
class SkinCubit extends Cubit<SkinState> {
  final SkinAIService _aiService = SkinAIService();

  SkinCubit() : super(const SkinState());

  void addImage(File imageFile) async {
    final updatedMessages = List<Message>.from(state.messages)
      ..add(Message(image: imageFile, isUser: true));
    emit(state.copyWith(messages: updatedMessages, isSending: true));

    try {
      final botResponse = await _aiService.sendImage(imageFile, "skin");
      final newMessages = List<Message>.from(updatedMessages)
        ..add(Message(text: botResponse, isUser: false));
      emit(state.copyWith(messages: newMessages, isSending: false));
    } catch (e) {
      emit(state.copyWith(isSending: false));
    }
  }
}
