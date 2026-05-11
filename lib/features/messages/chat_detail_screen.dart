import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
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
  final messages = <MessageModel>[];

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
      backgroundColor: AppColors.navBarLight,
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
                        color: AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Today 10:45',
                        style: TextStyle(
                          color: AppColors.primary,
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
