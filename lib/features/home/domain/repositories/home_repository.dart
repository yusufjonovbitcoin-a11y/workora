import '../entities/category_entity.dart';
import '../entities/job_seeker_entity.dart';
import '../entities/job_entity.dart';
import '../../../vacancy/models/vacancy_detail_model.dart';

abstract class HomeRepository {
  Future<List<CategoryEntity>> getCategories();

  Future<List<JobEntity>> getRecommendedJobs();

  Future<List<JobSeekerEntity>> getJobSeekers();

  Future<VacancyDetailModel?> getVacancyDetail(String id);
}
