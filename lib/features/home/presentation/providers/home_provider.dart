import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repositories/home_repository_impl.dart';
import '../../data/sources/home_mock_source.dart';
import '../../data/sources/supabase_home_source.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/job_seeker_entity.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../../../vacancy/models/vacancy_detail_model.dart';
import '../../domain/entities/home_job_filters.dart';

class HomeState {
  const HomeState({
    required this.categories,
    required this.jobs,
    required this.jobSeekers,
  });

  final List<CategoryEntity> categories;
  final List<JobEntity> jobs;
  final List<JobSeekerEntity> jobSeekers;
}

final homeSearchQueryProvider = StateProvider<String>((ref) => '');

final homeJobFiltersProvider =
    StateProvider<HomeJobFilters>((ref) => HomeJobFilters.initial());

final homeMockSourceProvider = Provider<HomeMockSource>((ref) {
  return const HomeMockSource();
});

final homeSupabaseSourceProvider = Provider<SupabaseHomeSource?>((ref) {
  if (!Supabase.instance.isInitialized) return null;
  return SupabaseHomeSource(Supabase.instance.client);
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    mockSource: ref.watch(homeMockSourceProvider),
    supabaseSource: ref.watch(homeSupabaseSourceProvider),
  );
});

final homeProvider = FutureProvider<HomeState>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return HomeState(
    categories: await repository.getCategories(),
    jobs: await repository.getRecommendedJobs(),
    jobSeekers: await repository.getJobSeekers(),
  );
});

final vacancyDetailProvider =
    FutureProvider.family<VacancyDetailModel?, String>((ref, id) {
      final repository = ref.watch(homeRepositoryProvider);
      return repository.getVacancyDetail(id);
    });
