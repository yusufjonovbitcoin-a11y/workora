import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/home_repository_impl.dart';
import '../../data/sources/home_mock_source.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/repositories/home_repository.dart';

class HomeState {
  const HomeState({required this.categories, required this.jobs});

  final List<CategoryEntity> categories;
  final List<JobEntity> jobs;
}

final homeMockSourceProvider = Provider<HomeMockSource>((ref) {
  return const HomeMockSource();
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final source = ref.watch(homeMockSourceProvider);
  return HomeRepositoryImpl(source);
});

final homeProvider = Provider<HomeState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return HomeState(
    categories: repository.getCategories(),
    jobs: repository.getRecommendedJobs(),
  );
});
