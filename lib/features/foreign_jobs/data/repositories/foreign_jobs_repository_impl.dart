import '../../domain/entities/country_entity.dart';
import '../../domain/entities/foreign_program_entity.dart';
import '../../domain/entities/region_entity.dart';
import '../../domain/repositories/foreign_jobs_repository.dart';

/// Hozircha tashqi API yo‘q — bo‘sh ro‘yxatlar (mock olib tashlangan).
class ForeignJobsRepositoryImpl implements ForeignJobsRepository {
  const ForeignJobsRepositoryImpl();

  @override
  List<RegionEntity> getRegions() => <RegionEntity>[];

  @override
  List<CountryEntity> getCountries() => <CountryEntity>[];

  @override
  List<ForeignProgramEntity> getPrograms() => <ForeignProgramEntity>[];
}
