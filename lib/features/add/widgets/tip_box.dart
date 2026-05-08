import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class TipBox extends StatelessWidget {
  const TipBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8F1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: AppColors.primary),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'To‘liq va aniq ma’lumotlar ko‘proq ish takliflarini olish imkonini beradi.',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF344054),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
