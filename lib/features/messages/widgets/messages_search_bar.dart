import 'package:flutter/material.dart';

class MessagesSearchBar extends StatelessWidget {
  const MessagesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _TabChip(text: 'Private Message', active: true),
        SizedBox(width: 10),
        _TabChip(text: 'Group', active: false),
        SizedBox(width: 10),
        _TabChip(text: 'Request', active: false),
        Spacer(),
        Icon(Icons.search, color: Color(0xFF6E9674), size: 30),
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
        color: active ? const Color(0xFF7FA384) : const Color(0xFFF2F3F2),
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
