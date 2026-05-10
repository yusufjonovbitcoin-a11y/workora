import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/add_submission_models.dart';

class SupabaseAddSource {
  const SupabaseAddSource(this._client);

  final SupabaseClient _client;

  Future<void> submitJobSeekerPost(JobSeekerPostInput input) async {
    await _submit(
      type: 'job_seeker',
      row: input.toInsertRow(ownerProfileId: _client.auth.currentUser?.id),
    );
  }

  Future<void> submitEmployerVacancy(EmployerVacancyInput input) async {
    await _submit(
      type: 'employer',
      row: input.toInsertRow(ownerProfileId: _client.auth.currentUser?.id),
    );
  }

  Future<void> _submit({
    required String type,
    required Map<String, dynamic> row,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId != null) {
      final table = type == 'job_seeker' ? 'job_seeker_posts' : 'vacancies';
      await _client.from(table).insert(row);
      return;
    }

    throw StateError('E’lon joylashtirish uchun tizimga kiring.');
  }
}
