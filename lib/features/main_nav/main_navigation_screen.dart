import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../add/add_screen.dart';
import '../ai_chat/presentation/screens/ai_chat_screen.dart';
import '../foreign_jobs/presentation/screens/foreign_jobs_screen.dart';
import '../home/presentation/screens/home_screen.dart';
import '../messages/messages_screen.dart';
import '../profile/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  static const items = [
    _NavItem(icon: Icons.home_rounded, label: 'Bosh sahifa'),
    _NavItem(icon: Icons.smart_toy_rounded, label: 'AI Chat'),
    _NavItem(icon: Icons.language_rounded, label: 'Xorijda ish'),
    _NavItem(icon: Icons.add_rounded, label: 'Qo‘shish'),
    _NavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Xabarlar'),
    _NavItem(icon: Icons.person_outline_rounded, label: 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      AiChatScreen(onExit: () => setState(() => currentIndex = 0)),
      const ForeignJobsScreen(),
      const AddScreen(),
      const MessagesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: currentIndex == 1
          ? null
          : SafeArea(
              top: false,
              child: Container(
                height: 94,
                margin: const EdgeInsets.fromLTRB(14, 0, 14, 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(34),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .08),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: List.generate(items.length, (index) {
                    final active = currentIndex == index;
                    final item = items[index];

                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() => currentIndex = index),
                        child: SizedBox.expand(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeOut,
                                width: active ? 44 : 38,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: active
                                      ? AppColors.primary.withValues(alpha: .12)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Icon(
                                  item.icon,
                                  size: active ? 26 : 25,
                                  color: active
                                      ? AppColors.primary
                                      : const Color(0xFF4B5563),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: active
                                      ? FontWeight.w900
                                      : FontWeight.w700,
                                  color: active
                                      ? AppColors.primary
                                      : const Color(0xFF4B5563),
                                ),
                              ),
                              const SizedBox(height: 5),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                width: active ? 28 : 0,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
