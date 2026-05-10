import '../../data/models/add_submission_models.dart';

abstract class AddRepository {
  Future<void> submitJobSeekerPost(JobSeekerPostInput input);

  Future<void> submitEmployerVacancy(EmployerVacancyInput input);
}
