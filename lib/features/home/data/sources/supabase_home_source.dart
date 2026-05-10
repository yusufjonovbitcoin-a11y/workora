import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../vacancy/models/vacancy_detail_model.dart';
import '../models/category_model.dart';
import '../models/job_seeker_model.dart';
import '../models/job_model.dart';

class SupabaseHomeSource {
  const SupabaseHomeSource(this._client);

  final SupabaseClient _client;

  Future<List<CategoryModel>> getCategories() async {
    final rows = await _client
        .from('vacancies')
        .select('category')
        .eq('is_active', true)
        .order('category');

    final titles = <String>{};
    for (final row in rows) {
      final category = (row['category'] as String?)?.trim();
      if (category != null && category.isNotEmpty) {
        titles.add(category);
      }
    }

    return titles
        .map((title) => CategoryModel(title: title))
        .toList(growable: false);
  }

  /// Faol vakansiyalarni yuklaydi; filtrlash istemolchi tomonda (keng limit).
  Future<List<JobModel>> getRecommendedJobs({int limit = 250}) async {
    final rows = await _client
        .from('vacancies')
        .select(
          'id,title,company,location,salary,match_score,logo,featured,created_at,category,job_type',
        )
        .eq('is_active', true)
        .order('featured', ascending: false)
        .order('created_at', ascending: false)
        .limit(limit);

    return rows
        .map((row) => JobModel.fromVacancyRow(Map<String, dynamic>.from(row)))
        .toList(growable: false);
  }

  Future<List<JobSeekerModel>> getJobSeekers({int limit = 150}) async {
    final rows = await _client
        .from('job_seeker_posts')
        .select(
          'id,profession,job_type,location,expected_salary,experience,skills,education,languages,about,contact,created_at',
        )
        .eq('is_active', true)
        .order('created_at', ascending: false)
        .limit(limit);

    return rows
        .map((row) => JobSeekerModel.fromRow(Map<String, dynamic>.from(row)))
        .toList(growable: false);
  }

  Future<VacancyDetailModel?> getVacancyDetail(String id) async {
    final row = await _client
        .from('vacancies')
        .select()
        .eq('id', id)
        .eq('is_active', true)
        .maybeSingle();

    if (row == null) return null;
    return VacancyDetailModel.fromVacancyRow(Map<String, dynamic>.from(row));
  }
}
