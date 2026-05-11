import '../../domain/entities/job_entity.dart';
import '../../domain/match_percent.dart';

class JobModel extends JobEntity {
  const JobModel({
    required super.id,
    required super.title,
    required super.company,
    required super.location,
    required super.salary,
    required super.match,
    required super.logo,
    super.category,
    super.jobType,
    super.createdAt,
  });

  factory JobModel.fromVacancyRow(Map<String, dynamic> row) {
    final createdRaw = row['created_at'];
    DateTime? createdAt;
    if (createdRaw != null) {
      createdAt = DateTime.tryParse(createdRaw.toString());
    }
    return JobModel(
      id: row['id']?.toString() ?? '',
      title: row['title']?.toString() ?? '',
      company: row['company']?.toString() ?? '',
      location: row['location']?.toString() ?? '',
      salary: row['salary']?.toString() ?? '',
      match: formatMatchFromDbRaw(row['match_score']),
      logo: row['logo']?.toString() ?? _initials(row['company']),
      category: row['category']?.toString() ?? '',
      jobType: row['job_type']?.toString() ?? '',
      createdAt: createdAt,
    );
  }
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
