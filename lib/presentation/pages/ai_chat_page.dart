import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/entities/chat_message.dart';
import 'package:project_kepler/presentation/cubits/ai_chat_page/ai_chat_page_cubit.dart';
import 'package:project_kepler/presentation/cubits/ai_chat_page/ai_chat_page_state.dart';
import 'package:project_kepler/presentation/widgets/message_loading_animation.dart';
import '../utils/ui_helpers.dart';

@RoutePage()
class AIChatPage extends StatefulWidget {
  const AIChatPage({Key? key}) : super(key: key);

  @override
  AIChatPageState createState() => AIChatPageState();
}

class AIChatPageState extends State<AIChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    context.read<ChatCubit>().initChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.aiChat)),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          logger.d(state);
          if (state is ChatSuccess) {
            return ChatView(
                messages: state.messages,
                controller: _controller,
                isLoading: context.watch<ChatCubit>().isLoading,
                sendMessage: () async {
                  if (_controller.text.isNotEmpty) {
                    String text = _controller.text;
                    _controller.clear();
                    FocusScope.of(context).unfocus();
                    await context.read<ChatCubit>().sendMessage(text);
                  }
                });
          } else if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatError) {
            return Center(child: Text(state.error));
          } else if (state is ChatInitial) {
            context.read<ChatCubit>().sendMessage('');
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class AIChat extends StatefulWidget {
  ///Just chat without app bar, to use AI ChatBot outside of the page.

  /// Page context for AI ChatBot.
  final Map<String, dynamic>? pageContext;

  const AIChat({Key? key, this.pageContext}) : super(key: key);

  @override
  AIChatState createState() => AIChatState();
}

class AIChatState extends State<AIChat> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    context.read<ChatCubit>().initChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatSuccess) {
            return ChatView(
                messages: state.messages,
                controller: _controller,
                isLoading: context.watch<ChatCubit>().isLoading,
                sendMessage: () async {
                  logger.d("Received Context: ${widget.pageContext}");
                  if (_controller.text.isNotEmpty) {
                    String text = _controller.text;
                    _controller.clear();
                    FocusScope.of(context).unfocus();

                    await context
                        .read<ChatCubit>()
                        .sendMessage(text, context: widget.pageContext);
                  }
                });
          } else if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatError) {
            return Center(child: Text(state.error));
          } else if (state is ChatInitial) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class ChatView extends StatefulWidget {
  final List<ChatMessage> messages;
  final TextEditingController controller;
  final Future<void> Function() sendMessage;
  final bool isLoading;

  const ChatView({
    Key? key,
    required this.messages,
    required this.controller,
    required this.sendMessage,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (widget.messages.isEmpty && !widget.isLoading)
          const Expanded(child: EmptyHistory()),
        if (widget.messages.isNotEmpty)
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ChatMessageList(
                    messages: widget.messages,
                    scrollController: _scrollController,
                  ),
                ),
                if (widget.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: LoadingAnimation(),
                  ),
              ],
            ),
          ),
        InputField(
          controller: widget.controller,
          sendMessage: widget.sendMessage,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessageList extends StatefulWidget {
  final List<ChatMessage> messages;
  final ScrollController scrollController;

  const ChatMessageList({
    Key? key,
    required this.messages,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (widget.scrollController.hasClients) {
      widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void didUpdateWidget(covariant ChatMessageList oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        controller: widget.scrollController,
        itemCount: widget.messages.length,
        itemBuilder: (context, index) {
          return MessageBubble(message: widget.messages[index]);
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
            const SizedBox(height: 12),
            Text(message.text,
                style: context.theme.textTheme.bodyLarge
                    ?.copyWith(color: Colors.grey[200])),
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
                          onTap: () =>
                              context.read<ChatCubit>().sendMessage(question),
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
