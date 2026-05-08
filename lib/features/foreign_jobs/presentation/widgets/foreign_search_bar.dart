import 'package:flutter/material.dart';

class ForeignSearchBar extends StatelessWidget {
  const ForeignSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7EAF0)),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, size: 30, color: Color(0xFF667085)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Davlat yoki kasb qidirish...',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17,
                color: Color(0xFF98A2B3),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Icon(Icons.tune_rounded, size: 28, color: Color(0xFF344054)),
        ],
      ),
    );
  }
}
