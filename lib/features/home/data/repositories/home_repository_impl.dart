import '../../domain/entities/category_entity.dart';
import '../../domain/entities/job_seeker_entity.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../sources/supabase_home_source.dart';
import '../../../vacancy/models/vacancy_detail_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({required this.supabaseSource});

  final SupabaseHomeSource? supabaseSource;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final source = supabaseSource;
    if (source == null) return [];
    try {
      return await source.getCategories();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<JobEntity>> getRecommendedJobs() async {
    final source = supabaseSource;
    if (source == null) return [];
    try {
      return await source.getRecommendedJobs();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<JobSeekerEntity>> getJobSeekers() async {
    final source = supabaseSource;
    if (source == null) return [];
    try {
      return await source.getJobSeekers();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<VacancyDetailModel?> getVacancyDetail(String id) async {
    final trimmed = id.trim();
    if (trimmed.isEmpty) return null;

    final source = supabaseSource;
    if (source == null) return null;

    return source.getVacancyDetail(trimmed);
  }
}
