import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/message_model.dart';
import '../services/feeding_ai_services.dart';

/// --- Cubit & State ---
class FeedingState extends Equatable {
  final List<Message> messages;
  final bool isSending;

  const FeedingState({this.messages = const [], this.isSending = false});

  FeedingState copyWith({List<Message>? messages, bool? isSending}) {
    return FeedingState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }

  @override
  List<Object> get props => [messages, isSending];
}

class FeedingCubit extends Cubit<FeedingState> {
  final FeedingAIService _aiService = FeedingAIService();

  FeedingCubit() : super(const FeedingState());

  void addImage(File imageFile, String modelType) async {
    final updatedMessages = List<Message>.from(state.messages)
      ..add(Message(image: imageFile, isUser: true));
    emit(state.copyWith(messages: updatedMessages, isSending: true));

    try {
      final botResponse = await _aiService.sendImage(imageFile, modelType);

      final newMessages = List<Message>.from(updatedMessages)
        ..add(Message(text: botResponse, isUser: false));

      emit(state.copyWith(messages: newMessages, isSending: false));
    } catch (e) {
      emit(state.copyWith(isSending: false));
    }
  }
}
