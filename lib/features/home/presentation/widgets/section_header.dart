import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Text(
            'Tavsiya etilgan ishlar',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
        ),
        Text(
          'Barchasini koвЂrish',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        SizedBox(width: 6),
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.primary,
          size: 16,
        ),
      ],
    );
  }
}
