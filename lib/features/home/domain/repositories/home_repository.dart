import '../entities/category_entity.dart';
import '../entities/job_entity.dart';

abstract class HomeRepository {
  List<CategoryEntity> getCategories();

  List<JobEntity> getRecommendedJobs();
}
