class JobEntity {
  const JobEntity({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.match,
    required this.logo,
  });

  final String title;
  final String company;
  final String location;
  final String salary;
  final String match;
  final String logo;
}
