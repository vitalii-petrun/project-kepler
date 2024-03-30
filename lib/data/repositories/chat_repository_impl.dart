// data/repositories/chat_repository_impl.dart
import 'package:dart_openai/dart_openai.dart';
import 'package:project_kepler/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  late final OpenAIModelModel _model;

  ChatRepositoryImpl() {
    _initModel();
  }

  Future<void> _initModel() async {
    _model = await OpenAI.instance.model.retrieve("gpt-3.5-turbo");
  }

  @override
  Future<String> generateAIResponse(String message) async {
    try {
      final systemMessage = OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "You're a Astronomy Assistant, answer the user's questions",
          ),
        ],
        role: OpenAIChatMessageRole.assistant,
      );

      final userMessage = OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(message),
        ],
        role: OpenAIChatMessageRole.user,
      );

      final requestMessages = [
        systemMessage,
        userMessage,
      ];

      final response = await OpenAI.instance.chat.create(
        model: _model.id,
        seed: 6,
        messages: requestMessages,
        temperature: 0.2,
        maxTokens: 500,
      );
      final aiResponse = response.choices.first.message.content?.first.text;

      return aiResponse ??
          ''; // Return the AI response or an empty string if error
    } catch (e) {
      throw Exception(
          'Error generating AI response: $e'); // Proper error handling
    }
  }
}
