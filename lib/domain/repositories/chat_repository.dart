abstract class ChatRepository {
  Future<String> generateAIResponse(String message,
      {Map<String, dynamic>? context});
}
