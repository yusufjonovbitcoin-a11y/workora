class ReviewModel {
  const ReviewModel({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userName: json['user_name']?.toString() ?? '',
      rating: _doubleValue(json['rating'], fallback: 0),
      comment: json['comment']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
    );
  }

  final String userName;
  final double rating;
  final String comment;
  final String date;
}

class VacancyDetailModel {
  const VacancyDetailModel({
    required this.id,
    required this.title,
    required this.company,
    required this.verified,
    required this.logo,
    required this.match,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.contractType,
    required this.description,
    required this.startDate,
    required this.employeesNeeded,
    required this.languageRequirement,
    required this.housing,
    required this.requirements,
    required this.benefits,
    required this.companyDescription,
    required this.companyLocation,
    required this.companyEmployees,
    required this.companyActiveVacancies,
    required this.reviews,
  });

  factory VacancyDetailModel.fromVacancyRow(Map<String, dynamic> row) {
    return VacancyDetailModel(
      id: row['id']?.toString() ?? '',
      title: row['title']?.toString() ?? '',
      company: row['company']?.toString() ?? '',
      verified: row['verified'] == true,
      logo: row['logo']?.toString() ?? _initials(row['company']),
      match: _formatMatch(row['match_score']),
      location: row['location']?.toString() ?? '',
      salary: row['salary']?.toString() ?? '',
      jobType: row['job_type']?.toString() ?? '',
      contractType: row['contract_type']?.toString() ?? '',
      description: row['description']?.toString() ?? '',
      startDate: row['start_date']?.toString() ?? '',
      employeesNeeded: _countText(row['employees_needed'], 'nafar'),
      languageRequirement: row['language_requirement']?.toString() ?? '',
      housing: row['housing']?.toString() ?? '',
      requirements: _stringList(row['requirements']),
      benefits: _stringList(row['benefits']),
      companyDescription: row['company_description']?.toString() ?? '',
      companyLocation: row['company_location']?.toString() ?? '',
      companyEmployees: row['company_employees']?.toString() ?? '',
      companyActiveVacancies: _countText(row['company_active_vacancies'], 'ta'),
      reviews: _reviews(row['reviews']),
    );
  }

  final String id;
  final String title;
  final String company;
  final bool verified;
  final String logo;
  final String match;
  final String location;
  final String salary;
  final String jobType;
  final String contractType;
  final String description;
  final String startDate;
  final String employeesNeeded;
  final String languageRequirement;
  final String housing;
  final List<String> requirements;
  final List<String> benefits;
  final String companyDescription;
  final String companyLocation;
  final String companyEmployees;
  final String companyActiveVacancies;
  final List<ReviewModel> reviews;
}

String _formatMatch(Object? value) {
  if (value == null) return '90%';
  final text = value.toString();
  return text.endsWith('%') ? text : '$text%';
}

String _initials(Object? value) {
  final text = value?.toString().trim() ?? '';
  if (text.isEmpty) return 'W';
  return text
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();
}

String _countText(Object? value, String suffix) {
  if (value == null) return '';
  final text = value.toString();
  return text.endsWith(suffix) ? text : '$text $suffix';
}

List<String> _stringList(Object? value) {
  if (value is List) {
    return value.map((item) => item.toString()).toList(growable: false);
  }
  return const [];
}

List<ReviewModel> _reviews(Object? value) {
  if (value is List) {
    return value
        .whereType<Map>()
        .map((item) => ReviewModel.fromJson(Map<String, dynamic>.from(item)))
        .toList(growable: false);
  }
  return const [];
}

double _doubleValue(Object? value, {required double fallback}) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? fallback;
}
