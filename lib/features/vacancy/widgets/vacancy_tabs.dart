import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class VacancyTabs extends StatelessWidget {
  const VacancyTabs({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const _tabs = [
    'Tavsif',
    'Talablar',
    'Nima beriladi',
    'Kompaniya',
    'Sharhlar',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final active = selectedIndex == index;

          return GestureDetector(
            onTap: () => onChanged(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: active ? AppColors.primary : const Color(0xFFE7EAF0),
                ),
              ),
              child: Text(
                _tabs[index],
                style: TextStyle(
                  color: active ? Colors.white : const Color(0xFF344054),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
