import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  late final OpenAIModelModel _model;

  ChatRepositoryImpl._(this._model);

  static Future<ChatRepositoryImpl> create() async {
    await dotenv.load();
    OpenAI.apiKey = dotenv.env['OPENAI_API_KEY']!;
    final model = await _initModel();
    return ChatRepositoryImpl._(model);
  }

  static Future<OpenAIModelModel> _initModel() async {
    const modelTitle = "gpt-3.5-turbo";
    return await OpenAI.instance.model.retrieve(modelTitle);
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

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(_initialPrompt),
        if (context != null)
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
              context.toString()),
      ],
      role: OpenAIChatMessageRole.system,
    );

    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(message)
      ],
      role: OpenAIChatMessageRole.user,
    );

    final requestMessages = [systemMessage, userMessage];
    logger.i('Request messages: $requestMessages');

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
  }
}
