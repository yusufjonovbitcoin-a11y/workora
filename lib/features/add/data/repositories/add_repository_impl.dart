import '../../domain/repositories/add_repository.dart';
import '../models/add_submission_models.dart';
import '../sources/supabase_add_source.dart';

class AddRepositoryImpl implements AddRepository {
  const AddRepositoryImpl(this._source);

  final SupabaseAddSource _source;

  @override
  Future<void> submitJobSeekerPost(JobSeekerPostInput input) {
    return _source.submitJobSeekerPost(input);
  }

  @override
  Future<void> submitEmployerVacancy(EmployerVacancyInput input) {
    return _source.submitEmployerVacancy(input);
  }
}
