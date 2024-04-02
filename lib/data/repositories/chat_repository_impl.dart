import 'package:dart_openai/dart_openai.dart';
import 'package:project_kepler/domain/repositories/chat_repository.dart';

/// A concrete implementation of the [ChatRepository] interface.
class ChatRepositoryImpl implements ChatRepository {
  late final OpenAIModelModel _model;

  ChatRepositoryImpl() {
    _initModel();
  }

  Future<void> _initModel() async {
    const modelTitle = "gpt-3.5-turbo";
    _model = await OpenAI.instance.model.retrieve(modelTitle);
  }

  /// The initial prompt to start the conversation.
  ///  Configures the AI to act as an Astronomy Assistant.
  final _initialPrompt =
      """You're a Astronomy Assistant, answer the user's questions about astronomy.
      User message could contain data in JSON format, it's a context of page where they're requesting  your help,
      so if question is related to additional data you can use it to provide better answer.
      """;

  @override
  Future<String> generateAIResponse(String message) async {
    try {
      final systemMessage = OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
              _initialPrompt),
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
