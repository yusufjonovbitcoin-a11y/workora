import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final style = statusStyle(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: style.color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        style.label,
        style: TextStyle(
          color: style.color,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}

({String label, Color color}) statusStyle(String status) {
  return switch (status) {
    'active' => (label: 'Active', color: AppColors.success),
    'inactive' => (label: 'Inactive', color: AppColors.textSecondary),
    'draft' => (label: 'Draft', color: AppColors.warning),
    'pending' => (label: 'Pending', color: const Color(0xFF2563EB)),
    'approved' => (label: 'Approved', color: AppColors.success),
    'rejected' => (label: 'Rejected', color: const Color(0xFFE11D48)),
    'sent' => (label: 'Sent', color: AppColors.warning),
    'viewed' => (label: 'Viewed', color: const Color(0xFF2563EB)),
    'interview' => (label: 'Interview', color: const Color(0xFF7C3AED)),
    'blocked' => (label: 'Blocked', color: const Color(0xFFE11D48)),
    _ => (label: status, color: AppColors.primary),
  };
}
