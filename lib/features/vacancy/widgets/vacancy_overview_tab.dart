import 'package:flutter/material.dart';

import '../models/vacancy_detail_model.dart';
import 'vacancy_info_grid.dart';

class VacancyOverviewTab extends StatelessWidget {
  const VacancyOverviewTab({super.key, required this.vacancy});

  final VacancyDetailModel vacancy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ish haqida',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFF101828),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          vacancy.description,
          style: const TextStyle(
            color: Color(0xFF344054),
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        VacancyInfoGrid(
          items: [
            (
              icon: Icons.event_available_rounded,
              title: 'Ish boshlanish sanasi',
              value: vacancy.startDate,
            ),
            (
              icon: Icons.groups_rounded,
              title: 'Xodimlar soni',
              value: vacancy.employeesNeeded,
            ),
            (
              icon: Icons.language_rounded,
              title: 'Til talabi',
              value: vacancy.languageRequirement,
            ),
            (
              icon: Icons.home_work_outlined,
              title: 'Yashash joyi',
              value: vacancy.housing,
            ),
          ],
        ),
      ],
    );
  }
}
