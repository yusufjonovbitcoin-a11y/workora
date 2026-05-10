import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile_record.dart';

class SupabaseProfileRepository {
  SupabaseProfileRepository(this._client);

  final SupabaseClient _client;

  String? get _userId => _client.auth.currentUser?.id;

  /// Supabase sessiyasi bo‘lsa profilni yuklaydi; aks holda `null`.
  Future<ProfileRecord?> fetchCurrentProfile() async {
    final uid = _userId;
    if (uid == null) return null;

    final row = await _client
        .from('profiles')
        .select()
        .eq('id', uid)
        .maybeSingle();

    if (row == null) return null;
    return ProfileRecord.fromRow(Map<String, dynamic>.from(row));
  }

  Future<void> upsertProfile(ProfileRecord record) async {
    final uid = _userId;
    if (uid == null || uid != record.userId) {
      throw StateError('Profilni saqlash uchun tizimga kiring.');
    }

    await _client.from('profiles').upsert(record.toUpsertRow());
  }

  /// Telegram deep-link login (`telegram_users`).
  Future<ProfileRecord?> fetchTelegramProfile(int telegramId) async {
    final res = await _client.functions.invoke(
      'get-telegram-profile',
      body: {'telegram_id': telegramId},
    );
    final data = res.data;
    if (data == null) return null;
    if (data is Map) {
      return ProfileRecord.fromTelegramUserRow(
        Map<String, dynamic>.from(data),
      );
    }
    return null;
  }

  Future<void> upsertTelegramProfile({
    required int telegramId,
    required ProfileRecord record,
  }) async {
    await _client.functions.invoke(
      'upsert-telegram-profile',
      body: {
        'telegram_id': telegramId,
        'full_name': record.fullName,
        'profession': record.profession,
        'bio': record.bio,
        'phone': record.phone,
        'location': record.location,
        'skills': record.skills.map((e) => e.toJson()).toList(),
        'languages': record.languages.map((e) => e.toJson()).toList(),
        'experiences': record.experiences.map((e) => e.toJson()).toList(),
        'cv_file_name': record.cvFileName,
      },
    );
  }
}
