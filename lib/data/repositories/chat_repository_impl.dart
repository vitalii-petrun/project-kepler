import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_kepler/core/global.dart';
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
      """ You're an Astronomy Assistant, answer the user's questions about astronomy.
      Your answer should be informative and helpful. 
      Provide accurate information and answer the user's questions to the best of your ability.
      """;

  @override
  Future<String> generateAIResponse(String message,
      {Map<String, dynamic>? context}) async {
    logger.i('Generating AI response for message: $message');
    logger.i('Context of request: ${context.toString()}');

    try {
      final systemMessage = OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
              _initialPrompt),
          if (context != null)
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
                // Add context to the AI request
                context.toString()),
        ],
        role: OpenAIChatMessageRole.system,
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
      logger.i('Request messages: $requestMessages');

      logger.d(int.parse(dotenv.env['MAX_TOKEN_PER_REQUEST']!));
      final response = await OpenAI.instance.chat.create(
        model: _model.id,
        seed: 6,
        messages: requestMessages,
        temperature: 0.2,
        maxTokens: int.parse(dotenv.env['MAX_TOKEN_PER_REQUEST']!),
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

// OpenAI: This part of the name indicates that the class is related to the OpenAI API.
// ChatCompletion: This refers to the specific API endpoint being used, which is the "chat completion" endpoint. This endpoint is designed for conversational AI models like ChatGPT.
// Choice: A single response from the API is called a "choice".
// Message: Each message in the conversation is represented by this class.
// Model: This part of the name indicates that the class is a model or data structure representing a message.