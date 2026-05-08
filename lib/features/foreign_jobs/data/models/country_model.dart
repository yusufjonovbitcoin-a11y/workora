import '../../domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    required super.name,
    required super.jobs,
    required super.flag,
    required super.tag,
  });
}
