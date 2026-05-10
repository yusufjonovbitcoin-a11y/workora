class JobEntity {
  const JobEntity({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.match,
    required this.logo,
    this.category = '',
    this.jobType = '',
    this.createdAt,
  });

  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String match;
  final String logo;
  final String category;
  final String jobType;
  final DateTime? createdAt;
}
