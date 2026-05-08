import '../../domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required super.title,
    required super.company,
    required super.location,
    required super.salary,
    required super.match,
    required super.logo,
  });
}
