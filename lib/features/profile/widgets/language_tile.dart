import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.name,
    required this.level,
    this.onDelete,
  });

  final String name;
  final String level;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: const Color(0xFFEAF6EE),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.language_rounded, color: AppColors.primary),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(level),
      trailing: onDelete == null
          ? null
          : IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.close_rounded),
            ),
    );
  }
}
