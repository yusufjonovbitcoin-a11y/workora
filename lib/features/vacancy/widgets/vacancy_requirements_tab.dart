import 'package:flutter/material.dart';

import '../models/vacancy_detail_model.dart';
import 'requirement_item.dart';

class VacancyRequirementsTab extends StatelessWidget {
  const VacancyRequirementsTab({super.key, required this.vacancy});

  final VacancyDetailModel vacancy;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: vacancy.requirements
          .map((requirement) => RequirementItem(text: requirement))
          .toList(),
    );
  }
}
