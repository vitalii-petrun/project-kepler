import 'package:project_kepler/domain/entities/chat_message.dart';
import 'package:project_kepler/domain/repositories/chat_repository.dart';

class GenerateChatResponseUseCase {
  final ChatRepository _chatRepository;

  GenerateChatResponseUseCase(this._chatRepository);

  Future<ChatMessage> sendMessage(String message) async {
    try {
      final aiResponse = await _chatRepository.generateAIResponse(message);
      return ChatMessage(text: aiResponse, type: MessageType.ai);
    } catch (e) {
      return ChatMessage(text: 'Error: $e', type: MessageType.ai);
    }
  }
}
