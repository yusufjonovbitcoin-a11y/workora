class ApplicationModel {
  const ApplicationModel({
    required this.id,
    required this.applicant,
    required this.vacancy,
    required this.company,
    required this.status,
    required this.date,
  });

  final String id;
  final String applicant;
  final String vacancy;
  final String company;
  final String status;
  final String date;

  ApplicationModel copyWith({String? status}) {
    return ApplicationModel(
      id: id,
      applicant: applicant,
      vacancy: vacancy,
      company: company,
      status: status ?? this.status,
      date: date,
    );
  }
}
