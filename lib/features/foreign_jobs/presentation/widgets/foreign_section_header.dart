import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ForeignSectionHeader extends StatelessWidget {
  const ForeignSectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF101828),
            ),
          ),
        ),
        const Text(
          'Barchasini koвЂrish',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 6),
        const Icon(
          Icons.arrow_forward_rounded,
          color: AppColors.primary,
          size: 20,
        ),
      ],
    );
  }
}
