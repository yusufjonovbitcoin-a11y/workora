import '../../domain/entities/category_entity.dart';
import '../../domain/entities/job_seeker_entity.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../sources/home_mock_source.dart';
import '../sources/supabase_home_source.dart';
import '../../../vacancy/data/vacancy_detail_mock_data.dart';
import '../../../vacancy/models/vacancy_detail_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({
    required this.mockSource,
    required this.supabaseSource,
  });

  final HomeMockSource mockSource;
  final SupabaseHomeSource? supabaseSource;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final source = supabaseSource;
    if (source == null) return mockSource.getCategories();

    try {
      final categories = await source.getCategories();
      return categories.isEmpty ? mockSource.getCategories() : categories;
    } catch (_) {
      return mockSource.getCategories();
    }
  }

  @override
  Future<List<JobEntity>> getRecommendedJobs() async {
    final source = supabaseSource;
    if (source == null) return mockSource.getRecommendedJobs();

    try {
      return await source.getRecommendedJobs();
    } catch (_) {
      return mockSource.getRecommendedJobs();
    }
  }

  @override
  Future<List<JobSeekerEntity>> getJobSeekers() async {
    final source = supabaseSource;
    if (source == null) return mockSource.getJobSeekers();

    try {
      return await source.getJobSeekers();
    } catch (_) {
      return mockSource.getJobSeekers();
    }
  }

  @override
  Future<VacancyDetailModel?> getVacancyDetail(String id) async {
    if (id.startsWith('mock-')) return VacancyDetailMockData.vacancy;

    final source = supabaseSource;
    if (source == null) return VacancyDetailMockData.vacancy;

    return source.getVacancyDetail(id);
  }
}
