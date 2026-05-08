import 'package:flutter/material.dart';

import '../models/vacancy_detail_model.dart';
import 'benefit_item.dart';

class VacancyBenefitsTab extends StatelessWidget {
  const VacancyBenefitsTab({super.key, required this.vacancy});

  final VacancyDetailModel vacancy;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vacancy.benefits.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) {
        return BenefitItem(text: vacancy.benefits[index]);
      },
    );
  }
}
