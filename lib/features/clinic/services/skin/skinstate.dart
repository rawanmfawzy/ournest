import 'package:equatable/equatable.dart';
import '../../models/message_model.dart';
class SkinState extends Equatable {
  final List<Message> messages;
  final bool isSending;
  final String? error;

  const SkinState({
    this.messages = const [],
    this.isSending = false,
    this.error,
  });

  SkinState copyWith({
    List<Message>? messages,
    bool? isSending,
    String? error,
  }) {
    return SkinState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      error: error,
    );
  }

  @override
  List<Object?> get props => [messages, isSending, error];
}