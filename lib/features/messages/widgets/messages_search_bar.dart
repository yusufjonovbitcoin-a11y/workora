import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class MessagesSearchBar extends StatelessWidget {
  const MessagesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _TabChip(text: 'Private Message', active: true),
        const SizedBox(width: 10),
        const _TabChip(text: 'Group', active: false),
        const SizedBox(width: 10),
        const _TabChip(text: 'Request', active: false),
        const Spacer(),
        Icon(
          Icons.search,
          color: AppColors.primary.withValues(alpha: 0.65),
          size: 30,
        ),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({required this.text, required this.active});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: active ? AppColors.primaryLight : const Color(0xFFF2F3F2),
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
