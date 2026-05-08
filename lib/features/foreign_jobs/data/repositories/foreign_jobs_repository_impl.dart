import '../../domain/entities/country_entity.dart';
import '../../domain/entities/foreign_program_entity.dart';
import '../../domain/entities/region_entity.dart';
import '../../domain/repositories/foreign_jobs_repository.dart';
import '../sources/foreign_jobs_mock_source.dart';

class ForeignJobsRepositoryImpl implements ForeignJobsRepository {
  const ForeignJobsRepositoryImpl(this.source);

  final ForeignJobsMockSource source;

  @override
  List<RegionEntity> getRegions() {
    return source.getRegions();
  }

  @override
  List<CountryEntity> getCountries() {
    return source.getCountries();
  }

  @override
  List<ForeignProgramEntity> getPrograms() {
    return source.getPrograms();
  }
}
