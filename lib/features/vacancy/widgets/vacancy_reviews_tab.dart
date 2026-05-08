import 'package:flutter/material.dart';

import '../models/vacancy_detail_model.dart';
import 'review_card.dart';

class VacancyReviewsTab extends StatelessWidget {
  const VacancyReviewsTab({super.key, required this.vacancy});

  final VacancyDetailModel vacancy;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: vacancy.reviews
          .map((review) => ReviewCard(review: review))
          .toList(),
    );
  }
}
