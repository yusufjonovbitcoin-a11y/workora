import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/ai_chat_provider.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_header.dart';
import '../widgets/message_input.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key, this.onExit});

  final VoidCallback? onExit;

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> _sendMessage(String text) async {
    final value = text.trim();
    if (value.isEmpty) return;

    _controller.clear();
    final sendFuture = ref.read(aiChatProvider.notifier).sendMessage(value);
    _scrollToBottom();
    await sendFuture;
    if (!mounted) return;
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(aiChatProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            ChatHeader(onExit: widget.onExit),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                children: [
                  ...state.messages.map(
                    (message) => ChatBubble(message: message),
                  ),
                ],
              ),
            ),
            MessageInput(
              controller: _controller,
              onSend: () {
                _sendMessage(_controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
