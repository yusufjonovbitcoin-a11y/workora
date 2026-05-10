import 'package:flutter/material.dart';

import 'data/messages_mock_data.dart';
import 'models/message_model.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_header.dart';
import 'widgets/chat_input.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key, required this.name, required this.avatar});

  final String name;
  final String avatar;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final controller = TextEditingController();
  final messages = List<MessageModel>.of(MessagesMockData.messages);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(MessageModel(text: text, isMe: true));
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF0EA),
      body: SafeArea(
        child: Column(
          children: [
            ChatHeader(name: widget.name, avatar: widget.avatar),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCE8DD),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Today 10:45',
                        style: TextStyle(
                          color: Color(0xFF48674D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ...messages.map((message) => ChatBubble(message: message)),
                ],
              ),
            ),
            ChatInput(controller: controller, onSend: sendMessage),
          ],
        ),
      ),
    );
  }
}
