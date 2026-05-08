import '../models/experience_model.dart';
import '../models/language_model.dart';
import '../models/profile_model.dart';
import '../models/skill_model.dart';

class ProfileMockData {
  const ProfileMockData._();

  static const profile = ProfileModel(
    fullName: 'Muhammadamin',
    profession: 'Flutter Developer',
    bio:
        'Mobil ilovalar, chiroyli UI va foydalanuvchiga qulay ish topish tajribalarini yarataman.',
    phone: '+998 90 123 45 67',
    location: 'Toshkent, Uzbekistan',
    imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
    verified: true,
    completion: 85,
    appliedJobsCount: 12,
    savedJobsCount: 8,
    aiMatchPercent: 92,
    cvFileName: 'muhammadamin_cv.pdf',
    skills: [
      SkillModel(title: 'Flutter'),
      SkillModel(title: 'Dart'),
      SkillModel(title: 'Firebase'),
      SkillModel(title: 'UI/UX'),
    ],
    languages: [
      LanguageModel(name: 'O‘zbek tili', level: 'Native'),
      LanguageModel(name: 'Rus tili', level: 'B1'),
      LanguageModel(name: 'Ingliz tili', level: 'B1'),
    ],
    experiences: [
      ExperienceModel(
        position: 'Flutter Developer',
        company: 'Workora',
        period: '2024 - hozirgacha',
        description:
            'Job platform uchun mobil UI va feature modullar yaratish.',
      ),
      ExperienceModel(
        position: 'Junior Mobile Developer',
        company: 'Startup Lab',
        period: '2023 - 2024',
        description: 'Dart, REST API va responsive layoutlar bilan ishlash.',
      ),
    ],
  );
}
