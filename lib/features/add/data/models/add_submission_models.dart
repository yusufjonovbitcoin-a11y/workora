class JobSeekerPostInput {
  const JobSeekerPostInput({
    required this.profession,
    required this.jobType,
    required this.location,
    required this.expectedSalary,
    required this.experience,
    required this.skills,
    required this.education,
    required this.languages,
    required this.about,
    required this.contact,
  });

  final String profession;
  final String jobType;
  final String location;
  final String expectedSalary;
  final String experience;
  final List<String> skills;
  final String education;
  final List<String> languages;
  final String about;
  final String contact;

  Map<String, dynamic> toInsertRow({String? ownerProfileId}) {
    return {
      if (ownerProfileId != null) 'owner_profile_id': ownerProfileId,
      'profession': profession,
      'job_type': jobType,
      'location': location,
      'expected_salary': expectedSalary,
      'experience': experience,
      'skills': skills,
      'education': education,
      'languages': languages,
      'about': about,
      'contact': contact,
      'is_active': true,
    };
  }
}

class EmployerVacancyInput {
  const EmployerVacancyInput({
    required this.title,
    required this.company,
    required this.jobType,
    required this.location,
    required this.salary,
    required this.experience,
    required this.description,
    required this.requirements,
    required this.contact,
  });

  final String title;
  final String company;
  final String jobType;
  final String location;
  final String salary;
  final String experience;
  final String description;
  final List<String> requirements;
  final String contact;

  Map<String, dynamic> toInsertRow({String? ownerProfileId}) {
    return {
      if (ownerProfileId != null) 'owner_profile_id': ownerProfileId,
      'title': title,
      'company': company,
      'verified': false,
      'logo': _initials(company),
      'match_score': 90,
      'location': location,
      'salary': salary,
      'category': jobType.isEmpty ? 'General' : jobType,
      'job_type': jobType,
      'contract_type': jobType,
      'description': description,
      'requirements': requirements,
      'benefits': const <String>[],
      'company_description': company,
      'company_location': location,
      'company_employees': '',
      'company_active_vacancies': 1,
      'reviews': const <Map<String, dynamic>>[],
      'experience': experience,
      'contact': contact,
      'is_active': true,
      'featured': false,
    };
  }
}

List<String> splitInputList(String value) {
  return value
      .split(RegExp(r'[\n,;]+'))
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toList(growable: false);
}

String _initials(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return 'W';
  return trimmed
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();
}
