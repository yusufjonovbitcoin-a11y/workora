import 'package:flutter/material.dart';

import 'chat_detail_screen.dart';
import 'data/messages_mock_data.dart';
import 'widgets/conversation_card.dart';
import 'widgets/messages_header.dart';
import 'widgets/messages_search_bar.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF0EA),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            const MessagesHeader(),
            const SizedBox(height: 18),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(42)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MessagesSearchBar(),
                    const SizedBox(height: 28),
                    const Text(
                      'Latest Messages',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF16351F),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: ListView.separated(
                        itemCount: MessagesMockData.conversations.length,
                        separatorBuilder: (_, __) => const Divider(height: 24),
                        itemBuilder: (context, index) {
                          final conversation =
                              MessagesMockData.conversations[index];
                          return ConversationCard(
                            conversation: conversation,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChatDetailScreen(
                                  name: conversation.name,
                                  avatar: conversation.avatar,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
