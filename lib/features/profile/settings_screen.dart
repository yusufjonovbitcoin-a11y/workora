import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import 'widgets/logout_button.dart';
import 'widgets/settings_switch_tile.dart';
import 'widgets/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool notifications = true;
  bool privacy = false;
  String language = 'O‘zbekcha';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          SettingsSwitchTile(
            title: 'Dark mode',
            subtitle: 'Tungi ko‘rinish demo rejimda',
            value: darkMode,
            onChanged: (value) => setState(() => darkMode = value),
          ),
          SettingsSwitchTile(
            title: 'Bildirishnomalar',
            subtitle: 'Yangi ish, xabar va ariza yangiliklari',
            value: notifications,
            onChanged: (value) => setState(() => notifications = value),
          ),
          SettingsTile(
            icon: Icons.translate_rounded,
            title: 'Til',
            subtitle: 'Ilova tili',
            trailing: Text(
              language,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
            onTap: showLanguageSheet,
          ),
          SettingsSwitchTile(
            title: 'Maxfiy profil',
            subtitle: 'Profilingizni ish beruvchilardan yashirish',
            value: privacy,
            onChanged: (value) => setState(() => privacy = value),
          ),
          SettingsTile(
            icon: Icons.help_outline_rounded,
            title: 'Help center',
            subtitle: 'Savollar va qo‘llanmalar',
            onTap: () => showSnack('Help center demo rejimda'),
          ),
          SettingsTile(
            icon: Icons.support_agent_rounded,
            title: 'Support',
            subtitle: 'Workora jamoasi bilan bog‘lanish',
            onTap: () => context.push('/chat-detail'),
          ),
          const SizedBox(height: 10),
          LogoutButton(onTap: showLogoutDialog),
        ],
      ),
    );
  }

  void showLanguageSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 18),
              for (final item in const ['O‘zbekcha', 'Русский', 'English'])
                ListTile(
                  title: Text(item),
                  trailing: language == item
                      ? const Icon(
                          Icons.check_rounded,
                          color: AppColors.primary,
                        )
                      : null,
                  onTap: () {
                    setState(() => language = item);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Akkauntdan chiqish'),
          content: const Text('Haqiqatan ham akkauntdan chiqmoqchimisiz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Bekor qilish'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                context.go('/login');
              },
              child: const Text('Chiqish'),
            ),
          ],
        );
      },
    );
  }

  void showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: AppColors.primary, content: Text(message)),
    );
  }
}
