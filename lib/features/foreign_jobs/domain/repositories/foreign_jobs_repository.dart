import '../entities/country_entity.dart';
import '../entities/foreign_program_entity.dart';
import '../entities/region_entity.dart';

abstract class ForeignJobsRepository {
  List<RegionEntity> getRegions();

  List<CountryEntity> getCountries();

  List<ForeignProgramEntity> getPrograms();
}
