import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/domain/entities/chat_message.dart';
import 'package:project_kepler/domain/use_cases/generate_chat_response_use_case.dart';
import 'package:project_kepler/presentation/cubits/ai_chat_page/ai_chat_page_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GenerateChatResponseUseCase _chatUseCase;

  ChatCubit(this._chatUseCase) : super(ChatInitial());

  bool isLoading = false;

  Future<void> initChat() async {
    try {
      final messages = <ChatMessage>[];
      emit(ChatSuccess(messages));
    } catch (e) {
      emit(ChatError(e.toString(), []));
    }
  }

  Future<void> sendMessage(String message,
      {Map<String, dynamic>? context}) async {
    if (message.isEmpty) return;
    _addUserMessage(message);
    final currentState = state;
    List<ChatMessage> currentMessages =
        currentState is ChatSuccess ? currentState.messages : [];

    try {
      isLoading = true;
      final newMessage = await _chatUseCase.sendMessage(message, context: {
        'user_message': message,
        'previous_messages': currentMessages.map((e) => e.text).toList(),
        'context': context ?? "Treat this as a context placeholder"
      });
      isLoading = false;
      emit(ChatSuccess([...currentMessages, newMessage]));
    } catch (e) {
      emit(ChatError(e.toString(), currentMessages));
    }
  }

  void _addUserMessage(String message) {
    final currentState = state;
    List<ChatMessage> currentMessages =
        currentState is ChatSuccess ? currentState.messages : [];
    emit(ChatSuccess([
      ...currentMessages,
      ChatMessage(text: message, type: MessageType.user)
    ]));
  }
}
