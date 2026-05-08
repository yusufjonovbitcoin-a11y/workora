class ReviewModel {
  const ReviewModel({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  final String userName;
  final double rating;
  final String comment;
  final String date;
}

class VacancyDetailModel {
  const VacancyDetailModel({
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
