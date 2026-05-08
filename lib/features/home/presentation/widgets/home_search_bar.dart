import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7EAF0)),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, size: 32, color: Color(0xFF667085)),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              'Ish qidirish...',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF98A2B3),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(Icons.tune_rounded, size: 30, color: Color(0xFF344054)),
        ],
      ),
    );
  }
}
