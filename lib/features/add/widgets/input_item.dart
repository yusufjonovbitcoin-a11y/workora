import 'package:flutter/material.dart';

class InputItem extends StatelessWidget {
  const InputItem({
    super.key,
    required this.icon,
    required this.title,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  final IconData icon;
  final String title;
  final String hint;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE7EAF0)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: maxLines > 1
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: maxLines > 1 ? 12 : 0),
            child: Icon(icon, color: const Color(0xFF101828)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                labelText: title,
                hintText: hint,
                border: InputBorder.none,
                labelStyle: const TextStyle(
                  color: Color(0xFF101828),
                  fontWeight: FontWeight.w900,
                ),
                hintStyle: const TextStyle(
                  color: Color(0xFF98A2B3),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
