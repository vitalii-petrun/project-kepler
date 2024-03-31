import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/domain/use_cases/generate_chat_response_use_case.dart';
import 'package:project_kepler/presentation/cubits/ai_chat_page/ai_chat_page_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GenerateChatResponseUseCase _chatUseCase;

  ChatCubit(this._chatUseCase) : super(ChatInitial());

  Future<void> sendMessage(String message) async {
    emit(ChatLoading());
    try {
      final newMessage = await _chatUseCase.sendMessage(message);
      emit(ChatSuccess([...(state as ChatSuccess).messages, newMessage]));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
