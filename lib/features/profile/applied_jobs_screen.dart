import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppliedJobsScreen extends StatelessWidget {
  const AppliedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const applications = [
      _ApplicationData(
        title: 'Factory Worker',
        company: 'Samsung Korea',
        status: 'sent',
      ),
      _ApplicationData(
        title: 'Hotel Assistant',
        company: 'Dubai Hotel Group',
        status: 'viewed',
      ),
      _ApplicationData(
        title: 'Warehouse Staff',
        company: 'German Logistics',
        status: 'interview',
      ),
      _ApplicationData(
        title: 'Flutter Developer',
        company: 'Remote Team',
        status: 'approved',
      ),
      _ApplicationData(
        title: 'SMM Manager',
        company: 'Marketing Pro',
        status: 'rejected',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        title: const Text('Arizalarim'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
        children: [
          for (final application in applications)
            _ApplicationCard(application: application),
        ],
      ),
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({required this.application});

  final _ApplicationData application;

  @override
  Widget build(BuildContext context) {
    final style = _statusStyle(application.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: style.color.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(Icons.work_rounded, color: style.color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  application.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 5),
                Text(
                  application.company,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: style.color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              style.label,
              style: TextStyle(color: style.color, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApplicationData {
  const _ApplicationData({
    required this.title,
    required this.company,
    required this.status,
  });

  final String title;
  final String company;
  final String status;
}

({String label, Color color}) _statusStyle(String status) {
  return switch (status) {
    'sent' => (label: 'Yuborildi', color: AppColors.warning),
    'viewed' => (label: 'Ko‘rildi', color: const Color(0xFF2563EB)),
    'interview' => (label: 'Suhbat', color: const Color(0xFF7C3AED)),
    'approved' => (label: 'Qabul', color: AppColors.success),
    'rejected' => (label: 'Rad etildi', color: const Color(0xFFE11D48)),
    _ => (label: status, color: AppColors.textSecondary),
  };
}
