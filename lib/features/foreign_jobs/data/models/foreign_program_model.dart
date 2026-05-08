import '../../domain/entities/foreign_program_entity.dart';

class ForeignProgramModel extends ForeignProgramEntity {
  const ForeignProgramModel({
    required super.title,
    required super.country,
    required super.salary,
    required super.time,
    required super.housing,
    required super.emoji,
  });
}
