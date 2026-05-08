class AdminVacancyModel {
  const AdminVacancyModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.status,
    required this.type,
    required this.applications,
    required this.isForeign,
    required this.country,
    required this.contract,
    required this.housing,
    required this.visa,
    required this.requirements,
    required this.benefits,
  });

  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String status;
  final String type;
  final int applications;
  final bool isForeign;
  final String country;
  final String contract;
  final String housing;
  final String visa;
  final List<String> requirements;
  final List<String> benefits;

  AdminVacancyModel copyWith({
    String? title,
    String? company,
    String? location,
    String? salary,
    String? status,
    String? type,
    int? applications,
    bool? isForeign,
    String? country,
    String? contract,
    String? housing,
    String? visa,
    List<String>? requirements,
    List<String>? benefits,
  }) {
    return AdminVacancyModel(
      id: id,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      salary: salary ?? this.salary,
      status: status ?? this.status,
      type: type ?? this.type,
      applications: applications ?? this.applications,
      isForeign: isForeign ?? this.isForeign,
      country: country ?? this.country,
      contract: contract ?? this.contract,
      housing: housing ?? this.housing,
      visa: visa ?? this.visa,
      requirements: requirements ?? this.requirements,
      benefits: benefits ?? this.benefits,
    );
  }
}
