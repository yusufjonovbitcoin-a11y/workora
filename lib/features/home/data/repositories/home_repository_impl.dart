import '../../domain/entities/category_entity.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../sources/home_mock_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this.source);

  final HomeMockSource source;

  @override
  List<CategoryEntity> getCategories() {
    return source.getCategories();
  }

  @override
  List<JobEntity> getRecommendedJobs() {
    return source.getRecommendedJobs();
  }
}
