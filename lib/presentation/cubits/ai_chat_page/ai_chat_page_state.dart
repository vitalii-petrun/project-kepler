import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_kepler/domain/entities/chat_message.dart';

class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<ChatMessage> messages;

  ChatSuccess(this.messages);
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);
}
