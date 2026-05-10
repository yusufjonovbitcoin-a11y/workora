class JobSeekerEntity {
  const JobSeekerEntity({
    required this.id,
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

  final String id;
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
}
