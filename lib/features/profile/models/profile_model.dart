import 'experience_model.dart';
import 'language_model.dart';
import 'skill_model.dart';

class ProfileModel {
  /// Mocksiz boshlang‘ich / Supabase kutilganda.
  static const empty = ProfileModel(
    fullName: '',
    profession: '',
    bio: '',
    phone: '',
    location: '',
    imageUrl: '',
    verified: false,
    completion: 0,
    appliedJobsCount: 0,
    savedJobsCount: 0,
    aiMatchPercent: 0,
    skills: [],
    languages: [],
    experiences: [],
    cvFileName: '',
  );

  const ProfileModel({
    required this.fullName,
    required this.profession,
    required this.bio,
    required this.phone,
    required this.location,
    required this.imageUrl,
    required this.verified,
    required this.completion,
    required this.appliedJobsCount,
    required this.savedJobsCount,
    required this.aiMatchPercent,
    required this.skills,
    required this.languages,
    required this.experiences,
    required this.cvFileName,
  });

  final String fullName;
  final String profession;
  final String bio;
  final String phone;
  final String location;
  final String imageUrl;
  final bool verified;
  final int completion;
  final int appliedJobsCount;
  final int savedJobsCount;
  final int aiMatchPercent;
  final List<SkillModel> skills;
  final List<LanguageModel> languages;
  final List<ExperienceModel> experiences;
  final String cvFileName;
}
