import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/foreign_jobs_repository_impl.dart';
import '../../data/sources/foreign_jobs_mock_source.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/entities/foreign_program_entity.dart';
import '../../domain/entities/region_entity.dart';
import '../../domain/repositories/foreign_jobs_repository.dart';

class ForeignJobsState {
  const ForeignJobsState({
    required this.regions,
    required this.countries,
    required this.programs,
  });

  final List<RegionEntity> regions;
  final List<CountryEntity> countries;
  final List<ForeignProgramEntity> programs;
}

final foreignJobsMockSourceProvider = Provider<ForeignJobsMockSource>((ref) {
  return const ForeignJobsMockSource();
});

final foreignJobsRepositoryProvider = Provider<ForeignJobsRepository>((ref) {
  return ForeignJobsRepositoryImpl(ref.watch(foreignJobsMockSourceProvider));
});

final foreignJobsProvider = Provider<ForeignJobsState>((ref) {
  final repository = ref.watch(foreignJobsRepositoryProvider);

  return ForeignJobsState(
    regions: repository.getRegions(),
    countries: repository.getCountries(),
    programs: repository.getPrograms(),
  );
});
