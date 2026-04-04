// cubit/clinic_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/message_model.dart';

class ClinicState extends Equatable {
  final List<Message> messages;
  final bool isSending;

  const ClinicState({this.messages = const [], this.isSending = false});

  ClinicState copyWith({List<Message>? messages, bool? isSending}) {
    return ClinicState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }

  @override
  List<Object> get props => [messages, isSending];
}

class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit() : super(const ClinicState());

  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final updatedMessages = List<Message>.from(state.messages)
      ..add(Message(text: text, isUser: true));
    emit(state.copyWith(messages: updatedMessages, isSending: true));

    final botResponse = await getBotResponse(text);

    final newMessages = List<Message>.from(state.messages)
      ..add(Message(text: text, isUser: true))
      ..add(Message(text: botResponse, isUser: false));

    emit(state.copyWith(messages: newMessages, isSending: false));
  }

  Future<String> getBotResponse(String userMessage) async {
    await Future.delayed(const Duration(seconds: 1));
    return "Bot reply: $userMessage";
  }
}