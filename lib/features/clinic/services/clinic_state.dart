import 'package:equatable/equatable.dart';
import '../models/message_model.dart';

class ClinicState extends Equatable {
  final List<Message> messages;
  final bool isSending;
  final String? conversationId;
  final String? error;
  final bool isInitialized;

  const ClinicState({
    this.messages = const [],
    this.isSending = false,
    this.conversationId,
    this.error,
    this.isInitialized = false,
  });

  ClinicState copyWith({
    List<Message>? messages,
    bool? isSending,
    String? conversationId,
    String? error,
    bool? isInitialized,
  }) {
    return ClinicState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      conversationId: conversationId ?? this.conversationId,
      error: error,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  List<Object?> get props => [
    messages,
    isSending,
    conversationId,
    error,
    isInitialized,
  ];
}