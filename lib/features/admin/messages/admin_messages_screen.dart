import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/admin_message_model.dart';
import '../widgets/admin_header.dart';

class AdminMessagesScreen extends StatefulWidget {
  const AdminMessagesScreen({
    super.key,
    required this.conversations,
    required this.onChanged,
  });

  final List<AdminMessageModel> conversations;
  final ValueChanged<List<AdminMessageModel>> onChanged;

  @override
  State<AdminMessagesScreen> createState() => _AdminMessagesScreenState();
}

class _AdminMessagesScreenState extends State<AdminMessagesScreen> {
  int selected = 0;
  final replyController = TextEditingController();

  @override
  void dispose() {
    replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.conversations[selected];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdminHeader(
          title: 'Xabarlar',
          subtitle: 'Support conversationlar va tezkor javoblar',
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 800;
            final list = _ConversationList(
              conversations: widget.conversations,
              selected: selected,
              onSelect: (index) => setState(() => selected = index),
            );
            final chat = _ChatPanel(
              conversation: current,
              controller: replyController,
              onSend: sendReply,
            );
            if (narrow) {
              return Column(children: [list, const SizedBox(height: 14), chat]);
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 320, child: list),
                const SizedBox(width: 16),
                Expanded(child: chat),
              ],
            );
          },
        ),
      ],
    );
  }

  void sendReply() {
    final text = replyController.text.trim();
    if (text.isEmpty) return;
    final conversations = [...widget.conversations];
    final current = conversations[selected];
    conversations[selected] = current.copyWith(
      lastMessage: text,
      unread: 0,
      messages: [
        ...current.messages,
        ChatLineModel(text: text, isAdmin: true),
      ],
    );
    replyController.clear();
    widget.onChanged(conversations);
  }
}

class _ConversationList extends StatelessWidget {
  const _ConversationList({
    required this.conversations,
    required this.selected,
    required this.onSelect,
  });

  final List<AdminMessageModel> conversations;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _card(),
      child: Column(
        children: [
          for (var i = 0; i < conversations.length; i++)
            ListTile(
              selected: selected == i,
              selectedTileColor: const Color(0xFFEAF6EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onTap: () => onSelect(i),
              title: Text(conversations[i].user),
              subtitle: Text(conversations[i].lastMessage),
              trailing: conversations[i].unread == 0
                  ? null
                  : CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        '${conversations[i].unread}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}

class _ChatPanel extends StatelessWidget {
  const _ChatPanel({
    required this.conversation,
    required this.controller,
    required this.onSend,
  });

  final AdminMessageModel conversation;
  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 560,
      padding: const EdgeInsets.all(18),
      decoration: _card(),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(child: Icon(Icons.person_rounded)),
              const SizedBox(width: 12),
              Text(
                conversation.user,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const Divider(height: 28),
          Expanded(
            child: ListView(
              children: [
                for (final message in conversation.messages)
                  Align(
                    alignment: message.isAdmin
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message.isAdmin
                            ? AppColors.primary
                            : const Color(0xFFF2F4F7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isAdmin ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Javob yozing...',
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) => onSend(),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filled(
                onPressed: onSend,
                icon: const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

BoxDecoration _card() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(28),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: .04),
        blurRadius: 18,
        offset: const Offset(0, 10),
      ),
    ],
  );
}
