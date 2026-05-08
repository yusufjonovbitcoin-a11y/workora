import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class QuickRequests extends StatelessWidget {
  const QuickRequests({super.key, required this.requests, required this.onTap});

  final List<String> requests;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: requests.map((text) {
        return GestureDetector(
          onTap: () => onTap(text),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE7EAF0)),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
