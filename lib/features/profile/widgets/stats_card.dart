import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'completion_card.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.appliedJobsCount,
    required this.savedJobsCount,
    required this.aiMatchPercent,
    required this.onApplied,
    required this.onSaved,
    required this.onAiMatch,
  });

  final int appliedJobsCount;
  final int savedJobsCount;
  final int aiMatchPercent;
  final VoidCallback onApplied;
  final VoidCallback onSaved;
  final VoidCallback onAiMatch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: profileCardDecoration(),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              icon: Icons.send_rounded,
              value: '$appliedJobsCount',
              label: 'Arizalarim',
              onTap: onApplied,
            ),
          ),
          const _DividerLine(),
          Expanded(
            child: _StatItem(
              icon: Icons.bookmark_rounded,
              value: '$savedJobsCount',
              label: 'Saqlangan',
              onTap: onSaved,
            ),
          ),
          const _DividerLine(),
          Expanded(
            child: _StatItem(
              icon: Icons.auto_awesome_rounded,
              value: '$aiMatchPercent%',
              label: 'AI moslik',
              onTap: onAiMatch,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String value;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 104, color: const Color(0xFFE5E7EB));
  }
}
