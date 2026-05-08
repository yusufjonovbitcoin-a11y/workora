import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({super.key, required this.title, this.onDeleted});

  final String title;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(title),
      onDeleted: onDeleted,
      deleteIconColor: AppColors.primary,
      backgroundColor: const Color(0xFFEAF6EE),
      side: BorderSide.none,
      labelStyle: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w900,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    );
  }
}
