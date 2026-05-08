import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  static const chats = [
    {
      'name': 'AI Support',
      'message': 'Salom! Sizga qanday yordam...',
      'time': '10:45',
      'avatar': '🤖',
      'unread': '2',
      'verified': true,
    },
    {
      'name': 'Asrorbek HR',
      'message': 'Sizning resumeingizni ko‘rib chiqdim.',
      'time': '10:32',
      'avatar': '👨‍💼',
      'unread': '1',
      'verified': false,
    },
    {
      'name': 'Malika Recruiter',
      'message': 'Interview haqida ma’lumot yuborildi.',
      'time': '09:18',
      'avatar': '👩‍💼',
      'unread': '',
      'verified': false,
    },
    {
      'name': 'Job Korea Team 🇰🇷',
      'message': 'Yangi ish o‘rinlari keldi!',
      'time': '08:50',
      'avatar': '👨‍💻',
      'unread': '3',
      'verified': false,
    },
    {
      'name': 'Dubai Jobs',
      'message': 'Hujjatlaringiz qabul qilindi.',
      'time': 'Yesterday',
      'avatar': '👩',
      'unread': '',
      'verified': false,
    },
    {
      'name': 'Workora Team',
      'message': 'Yangi funksiya qo‘shildi 🚀',
      'time': 'Tue',
      'avatar': '👩‍💻',
      'unread': '2',
      'verified': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF0EA),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            _StoryHeader(),
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
                    _TabsAndSearch(),
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
                        itemCount: chats.length,
                        separatorBuilder: (_, __) => const Divider(height: 24),
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          return _ChatTile(
                            chat: chat,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ChatDetailScreen(
                                    name: chat['name'].toString(),
                                    avatar: chat['avatar'].toString(),
                                  ),
                                ),
                              );
                            },
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

class _StoryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Column(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 8),
              const Text(
                'Add Story',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(width: 28),
          ...List.generate(
            4,
            (index) => Container(
              margin: const EdgeInsets.only(right: 24),
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFF9AB79E),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .12),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabsAndSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TabChip(text: 'Private Message', active: true),
        const SizedBox(width: 10),
        _TabChip(text: 'Group', active: false),
        const SizedBox(width: 10),
        _TabChip(text: 'Request', active: false),
        const Spacer(),
        const Icon(Icons.search, color: Color(0xFF6E9674), size: 30),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  final String text;
  final bool active;

  const _TabChip({required this.text, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF7FA384) : const Color(0xFFF2F3F2),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : const Color(0xFF344054),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final Map<String, Object> chat;
  final VoidCallback onTap;

  const _ChatTile({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final unread = chat['unread'].toString();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF7FA384),
                child: Text(
                  chat['avatar'].toString(),
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: const Color(0xFF16A34A),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        chat['name'].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF101828),
                        ),
                      ),
                    ),
                    if (chat['verified'] == true) ...[
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.verified_rounded,
                        color: Color(0xFF6E9674),
                        size: 18,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  chat['message'].toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF667085),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                chat['time'].toString(),
                style: const TextStyle(
                  color: Color(0xFF344054),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              unread.isNotEmpty
                  ? Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6E9674),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unread,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.done_all_rounded,
                      color: Color(0xFF9AB79E),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
