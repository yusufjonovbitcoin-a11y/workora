import 'package:flutter/material.dart';

import '../models/vacancy_detail_model.dart';
import 'company_card.dart';

class VacancyCompanyTab extends StatelessWidget {
  const VacancyCompanyTab({super.key, required this.vacancy});

  final VacancyDetailModel vacancy;

  @override
  Widget build(BuildContext context) {
    return CompanyCard(vacancy: vacancy);
  }
}
