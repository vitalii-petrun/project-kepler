import 'package:auto_route/annotations.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import '../utils/ui_helpers.dart';

@RoutePage()
class AIChatPage extends StatefulWidget {
  const AIChatPage({Key? key}) : super(key: key);

  @override
  AIChatPageState createState() => AIChatPageState();
}

class AIChatPageState extends State<AIChatPage> {
  final TextEditingController _controller = TextEditingController();
  late OpenAIModelModel model;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    initModel();
  }

  void initModel() async {
    model = await OpenAI.instance.model.retrieve("gpt-3.5-turbo");
  }

  Future<void> sendMessage([String? messageText]) async {
    final text = messageText ?? _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, type: MessageType.user));
    });

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
          OpenAIChatCompletionChoiceMessageContentItemModel.text(text),
        ],
        role: OpenAIChatMessageRole.user,
      );

      final requestMessages = [
        systemMessage,
        userMessage,
      ];

      final response = await OpenAI.instance.chat.create(
        model: model.id,
        seed: 6,
        messages: requestMessages,
        temperature: 0.2,
        maxTokens: 500,
      );
      final aiResponse = response.choices.first.message.content?.first.text;

      setState(() {
        _messages
            .add(ChatMessage(text: aiResponse ?? '', type: MessageType.ai));
      });
    } catch (e) {
      setState(() {
        _messages.add(
            ChatMessage(text: 'Error: ${e.toString()}', type: MessageType.ai));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.aiChat)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (_messages.isEmpty) const Expanded(child: EmptyHistory()),
          if (_messages.isNotEmpty)
            Expanded(
              child: ChatMessageList(messages: _messages),
            ),
          InputField(controller: _controller, sendMessage: sendMessage),
        ],
      ),
    );
  }
}

class ChatMessageList extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatMessageList({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageBubble(message: messages[index]);
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.type == MessageType.user
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width * 0.7), // Limiting width
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: message.type == MessageType.user
              ? context.theme.colorScheme.primary
              : AppColors.aiChatBubbleColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: message.type == MessageType.user
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  message.type == MessageType.user
                      ? Icons.person
                      : Icons.computer,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  message.type == MessageType.user
                      ? context.l10n.you
                      : context.l10n.aiChat,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(message.text),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final Future<void> Function() sendMessage;

  const InputField(
      {Key? key, required this.controller, required this.sendMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: context.l10n.enterYourMessage,
          labelStyle: TextStyle(color: context.theme.colorScheme.onSurface),
          fillColor: context.theme.colorScheme.surface,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send, color: AppColors.aiChatBubbleColor),
            onPressed: sendMessage,
          ),
        ),
        onSubmitted: (value) => sendMessage(),
      ),
    );
  }
}

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({Key? key}) : super(key: key);

  List<String> _questions(BuildContext context) {
    return [
      context.l10n.darkMatterQuestion,
      context.l10n.bigBangTheoryQuestion,
      context.l10n.speedOfLightQuestion,
      context.l10n.universeMadeOfQuestion,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<AIChatPageState>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Icon(Icons.chat_bubble_outline, size: 50),
          const SizedBox(height: 10),
          Text(
            context.l10n.startConversation,
            style: context.theme.textTheme.headlineMedium,
          ),
          const Spacer(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _questions(context)
                  .map((question) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PromptChipMessage(
                          text: question,
                          onTap: () {
                            state?.sendMessage(
                                question); // Use the sendMessage method
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class PromptChipMessage extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PromptChipMessage({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(color: context.theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final MessageType type;

  ChatMessage({required this.text, required this.type});
}

enum MessageType { user, ai }
