import 'package:flutter/material.dart';

import 'completion_card.dart';
import 'profile_menu_tile.dart';

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    super.key,
    required this.onCv,
    required this.onSkills,
    required this.onLanguages,
    required this.onExperience,
    required this.onPortfolio,
    required this.onSettings,
  });

  final VoidCallback onCv;
  final VoidCallback onSkills;
  final VoidCallback onLanguages;
  final VoidCallback onExperience;
  final VoidCallback onPortfolio;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: profileCardDecoration(),
      child: Column(
        children: [
          ProfileMenuTile(
            icon: Icons.description_outlined,
            title: 'Rezyume / CV',
            subtitle: 'CV ni yuklash va tahrirlash',
            onTap: onCv,
          ),
          ProfileMenuTile(
            icon: Icons.work_outline_rounded,
            title: 'Ko‘nikmalar',
            subtitle: 'Asosiy ko‘nikmalar va sertifikatlar',
            onTap: onSkills,
          ),
          ProfileMenuTile(
            icon: Icons.language_rounded,
            title: 'Tillar',
            subtitle: 'Biladigan tillar va darajalari',
            onTap: onLanguages,
          ),
          ProfileMenuTile(
            icon: Icons.person_outline_rounded,
            title: 'Ish tajribasi',
            subtitle: 'Oldingi ish tajribalarim',
            onTap: onExperience,
          ),
          ProfileMenuTile(
            icon: Icons.folder_copy_outlined,
            title: 'Portfolio',
            subtitle: 'Loyihalar va namunalar',
            onTap: onPortfolio,
          ),
          ProfileMenuTile(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'Til, maxfiylik va yordam',
            isLast: true,
            onTap: onSettings,
          ),
        ],
      ),
    );
  }
}
