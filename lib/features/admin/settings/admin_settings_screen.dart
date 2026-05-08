import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../profile/widgets/logout_button.dart';
import '../../profile/widgets/settings_switch_tile.dart';
import '../../profile/widgets/settings_tile.dart';
import '../widgets/admin_header.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  bool darkMode = false;
  bool notifications = true;
  bool permissions = true;
  String language = 'O‘zbekcha';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdminHeader(
          title: 'Sozlamalar',
          subtitle: 'Admin permissions, support va platform sozlamalari',
        ),
        const SizedBox(height: 18),
        SettingsSwitchTile(
          title: 'Dark mode',
          subtitle: 'Admin panel uchun tungi rejim',
          value: darkMode,
          onChanged: (value) => setState(() => darkMode = value),
        ),
        SettingsSwitchTile(
          title: 'Notifications',
          subtitle: 'Admin alert va support xabarlarini olish',
          value: notifications,
          onChanged: (value) => setState(() => notifications = value),
        ),
        SettingsTile(
          icon: Icons.translate_rounded,
          title: 'Language',
          subtitle: 'Admin panel tili',
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
          title: 'Admin permissions',
          subtitle: 'Moderatorlarga cheklangan ruxsat berish',
          value: permissions,
          onChanged: (value) => setState(() => permissions = value),
        ),
        SettingsTile(
          icon: Icons.support_agent_rounded,
          title: 'Support',
          subtitle: 'Support conversationlarni ochish',
          onTap: () => setState(() {}),
        ),
        const SizedBox(height: 10),
        LogoutButton(onTap: showLogoutDialog),
      ],
    );
  }

  void showLanguageSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
          title: const Text('Admin logout'),
          content: const Text('Admin paneldan chiqmoqchimisiz?'),
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
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
