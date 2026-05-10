import 'experience_model.dart';
import 'language_model.dart';
import 'skill_model.dart';

/// `public.profiles` jadvali bilan mos ma’lumot.
class ProfileRecord {
  ProfileRecord({
    required this.userId,
    required this.fullName,
    required this.profession,
    required this.bio,
    required this.phone,
    required this.location,
    this.avatarUrl,
    required this.skills,
    required this.languages,
    required this.experiences,
    this.cvUrl,
    required this.cvFileName,
  });

  final String userId;
  final String fullName;
  final String profession;
  final String bio;
  final String phone;
  final String location;
  final String? avatarUrl;
  final List<SkillModel> skills;
  final List<LanguageModel> languages;
  final List<ExperienceModel> experiences;
  final String? cvUrl;
  final String cvFileName;

  factory ProfileRecord.fromRow(Map<String, dynamic> row) {
    List<T> parseList<T>(
      dynamic raw,
      T Function(Map<String, dynamic>) fromJson,
    ) {
      if (raw is! List) return [];
      return raw
          .whereType<Object>()
          .map((e) {
            if (e is Map<String, dynamic>) return fromJson(e);
            if (e is Map) return fromJson(Map<String, dynamic>.from(e));
            return null;
          })
          .whereType<T>()
          .toList();
    }

    final id = row['id'] as String?;
    return ProfileRecord(
      userId: id ?? '',
      fullName: row['full_name'] as String? ?? '',
      profession: row['profession'] as String? ?? '',
      bio: row['bio'] as String? ?? '',
      phone: row['phone'] as String? ?? '',
      location: row['location'] as String? ?? '',
      avatarUrl: row['avatar_url'] as String?,
      skills: parseList(row['skills'], SkillModel.fromJson),
      languages: parseList(row['languages'], LanguageModel.fromJson),
      experiences: parseList(row['experiences'], ExperienceModel.fromJson),
      cvUrl: row['cv_url'] as String?,
      cvFileName: row['cv_file_name'] as String? ?? '',
    );
  }

  /// `telegram_users` qatori (`photo_url` → avatar).
  factory ProfileRecord.fromTelegramUserRow(Map<String, dynamic> row) {
    List<T> parseList<T>(
      dynamic raw,
      T Function(Map<String, dynamic>) fromJson,
    ) {
      if (raw is! List) return [];
      return raw
          .whereType<Object>()
          .map((e) {
            if (e is Map<String, dynamic>) return fromJson(e);
            if (e is Map) return fromJson(Map<String, dynamic>.from(e));
            return null;
          })
          .whereType<T>()
          .toList();
    }

    final id = row['id'] as String? ?? '';
    return ProfileRecord(
      userId: id,
      fullName: row['full_name'] as String? ?? '',
      profession: row['profession'] as String? ?? '',
      bio: row['bio'] as String? ?? '',
      phone: row['phone'] as String? ?? '',
      location: row['location'] as String? ?? '',
      avatarUrl: row['photo_url'] as String?,
      skills: parseList(row['skills'], SkillModel.fromJson),
      languages: parseList(row['languages'], LanguageModel.fromJson),
      experiences: parseList(row['experiences'], ExperienceModel.fromJson),
      cvUrl: null,
      cvFileName: row['cv_file_name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toUpsertRow() {
    return {
      'id': userId,
      'full_name': fullName,
      'profession': profession,
      'bio': bio,
      'phone': phone,
      'location': location,
      'avatar_url': avatarUrl,
      'skills': skills.map((e) => e.toJson()).toList(),
      'languages': languages.map((e) => e.toJson()).toList(),
      'experiences': experiences.map((e) => e.toJson()).toList(),
      'cv_url': cvUrl,
      'cv_file_name': cvFileName,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
  }
}
