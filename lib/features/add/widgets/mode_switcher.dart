import 'package:flutter/material.dart';

import 'mode_card.dart';

class ModeSwitcher extends StatelessWidget {
  const ModeSwitcher({
    super.key,
    required this.isJobSeeker,
    required this.onChanged,
  });

  final bool isJobSeeker;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE7EAF0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ModeCard(
              active: isJobSeeker,
              icon: Icons.person_rounded,
              title: 'Ish qidiruvchi',
              subtitle: 'O‘zim haqimda e’lon berish',
              onTap: () => onChanged(true),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ModeCard(
              active: !isJobSeeker,
              icon: Icons.work_rounded,
              title: 'Ish beruvchi',
              subtitle: 'Vakansiya joylashtirish',
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}
