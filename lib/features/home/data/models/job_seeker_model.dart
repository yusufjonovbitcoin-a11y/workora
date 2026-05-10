import '../../domain/entities/job_seeker_entity.dart';

class JobSeekerModel extends JobSeekerEntity {
  const JobSeekerModel({
    required super.id,
    required super.profession,
    required super.jobType,
    required super.location,
    required super.expectedSalary,
    required super.experience,
    required super.skills,
    required super.education,
    required super.languages,
    required super.about,
    required super.contact,
  });

  factory JobSeekerModel.fromRow(Map<String, dynamic> row) {
    return JobSeekerModel(
      id: row['id']?.toString() ?? '',
      profession: row['profession']?.toString() ?? '',
      jobType: row['job_type']?.toString() ?? '',
      location: row['location']?.toString() ?? '',
      expectedSalary: row['expected_salary']?.toString() ?? '',
      experience: row['experience']?.toString() ?? '',
      skills: _stringList(row['skills']),
      education: row['education']?.toString() ?? '',
      languages: _stringList(row['languages']),
      about: row['about']?.toString() ?? '',
      contact: row['contact']?.toString() ?? '',
    );
  }
}

List<String> _stringList(Object? value) {
  if (value is List) {
    return value.map((item) => item.toString()).toList(growable: false);
  }
  return const [];
}
