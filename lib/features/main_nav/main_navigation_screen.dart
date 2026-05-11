import 'package:flutter/material.dart';

import '../add/add_screen.dart';
import '../ai_chat/presentation/screens/ai_chat_screen.dart';
import '../home/presentation/screens/home_screen.dart';
import '../messages/messages_screen.dart';
import '../profile/profile_screen.dart';
import 'widgets/premium_nav_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      AiChatScreen(onExit: () => setState(() => currentIndex = 0)),
      const AddScreen(),
      const MessagesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: currentIndex, children: screens),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: currentIndex == 1
          ? null
          : Material(
              color: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: PremiumNavBar(
                currentIndex: currentIndex,
                onTap: (index) => setState(() => currentIndex = index),
              ),
            ),
    );
  }
}
